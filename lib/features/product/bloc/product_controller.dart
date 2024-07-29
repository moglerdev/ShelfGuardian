import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/product/models/product_model.dart';
import 'package:shelf_guardian/features/product/bloc/product_state.dart';
import 'package:shelf_guardian/service/product_service.dart';
import 'package:shelf_guardian/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The abstract class representing the contract for a product controller.
/// It defines methods for initializing products, adding and removing products,
/// selecting and deselecting products, and updating the list of shown products.
abstract class ProductController {
  /// Initializes the list of products.
  /// Returns `true` if the initialization is successful, `false` otherwise.
  Future<bool> initProducts();

  /// Adds a product to the list.
  /// Returns `true` if the product is successfully added, `false` otherwise.
  bool addProduct(Product product);

  /// Removes a product from the list.
  /// Returns `true` if the product is successfully removed, `false` otherwise.
  bool removeProduct(Product product);

  /// Removes all selected products from the list.
  /// Returns `true` if the removal is successful, `false` otherwise.
  Future<bool> removeSelectedProducts();

  /// Selects a product in the list.
  /// Returns `true` if the product is successfully selected, `false` otherwise.
  bool selectProduct(Product product);

  /// Selects all products in the list.
  /// Returns `true` if all products are successfully selected, `false` otherwise.
  bool selectAllProducts();

  /// Deselects all products in the list.
  /// Returns `true` if all products are successfully deselected, `false` otherwise.
  bool deselectAllProducts();

  /// Deselects a product in the list.
  /// Returns `true` if the product is successfully deselected, `false` otherwise.
  bool deselectProduct(Product product);

  /// Toggles the search state of the product list.
  /// Returns `true` if the search state is successfully toggled, `false` otherwise.
  bool toggleSearchState();

  /// Updates the list of shown products.
  /// Returns `true` if the update is successful, `false` otherwise.
  bool updateShownProducts(List<Product> shownProducts);
}

/// The implementation of the [ProductController] using the Cubit pattern.
/// It manages the state of the product list and interacts with the [ProductService].
class ProductControllerCubit extends Cubit<ProductListState>
    implements ProductController {
  final service = ProductService.create();
  final channel = Api.client.channel("products_items");

  /// Creates a new instance of [ProductControllerCubit].
  /// It initializes the product list and subscribes to changes in the database.
  ProductControllerCubit() : super(ProductListEmpty()) {
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: "public",
          callback: (payload) {
            unawaited(initProducts());
          },
        )
        .subscribe();
    unawaited(initProducts());
  }

  @override
  Future<void> close() {
    channel.unsubscribe();
    return super.close();
  }

  @override
  Future<bool> initProducts() async {
    emit(ProductListLoading());

    final products = await service.getProducts();
    if (products.isEmpty) {
      emit(ProductListEmpty());
      return false;
    } else {
      emit(ProductListFilled(products));
      return true;
    }
  }

  @override
  bool addProduct(Product product) {
    if (state is ProductListLoading) {
      return false;
    }
    List<Product> products = state.getProducts()..add(product);
    emit(ProductListFilled(products));
    return true;
  }

  @override
  bool removeProduct(Product product) {
    if (state is ProductListLoading) {
      return false;
    }
    List<Product> products = state.getProducts()..remove(product);
    emit(ProductListFilled(products));
    return true;
  }

  @override
  Future<bool> removeSelectedProducts() async {
    if (state is ProductListSelected) {
      await service
          .removeProducts((state as ProductListSelected).selectedProducts);
      await initProducts();
      return true;
    }
    return false;
  }

  @override
  bool selectProduct(Product product) {
    if (state is ProductListLoading || state is ProductSearchedList) {
      return false;
    }
    List<Product> products = state.getProducts();
    if (state is ProductListSelected) {
      emit(ProductListSelected(products,
          (state as ProductListSelected).selectedProducts..add(product)));
    } else {
      emit(ProductListSelected(products, [product]));
    }
    return true;
  }

  @override
  bool selectAllProducts() {
    if (state is ProductListSelected ||
        state is ProductListLoading ||
        state is ProductSearchedList) {
      return false;
    }
    List<Product> products = state.getProducts();
    emit(ProductListSelected(products, products));
    return true;
  }

  @override
  bool deselectAllProducts() {
    emit(ProductListFilled(state.getProducts()));
    return true;
  }

  @override
  bool deselectProduct(Product product) {
    if (state is ProductListSelected) {
      List<Product> selected = (state as ProductListSelected).selectedProducts;
      if (!selected.contains(product)) {
        return false;
      }
      if (selected.length == 1) {
        emit(ProductListFilled(state.getProducts()));
        return true;
      }

      emit(ProductListSelected(
          state.getProducts(),
          (state as ProductListSelected).selectedProducts
            ..remove(product)
            ..toSet()
            ..toList()));
      return true;
    }
    return false;
  }

  @override
  bool toggleSearchState() {
    if (state is ProductSearchedList) {
      emit(ProductListFilled((state.getProducts())));
      return true;
    } else if (state is ProductListFilled || state is ProductListSelected) {
      emit(ProductSearchedList(state.getProducts(), state.getProducts(),
          TextEditingController(), updateShownProducts, ""));
      return true;
    }
    return false;
  }

  @override
  bool updateShownProducts(List<Product> shownProducts) {
    if (state is ProductSearchedList) {
      state.disposeListener();
      emit(ProductSearchedList(
        (state as ProductSearchedList).products,
        shownProducts,
        (state as ProductSearchedList).searchController,
        (state as ProductSearchedList).updateShownProducts,
        (state as ProductSearchedList).lastSearchText,
      ));
      return true;
    }
    return false;
  }
}
