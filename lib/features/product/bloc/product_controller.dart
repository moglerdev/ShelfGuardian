import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/product/models/product_model.dart';
import 'package:shelf_guardian/features/product/bloc/product_state.dart';
import 'package:shelf_guardian/service/product_service.dart';
import 'package:shelf_guardian/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductController {
  Future<bool> initProducts();

  bool addProduct(Product product);

  bool removeProduct(Product product);

  Future<bool> removeSelectedProducts();

  bool selectProduct(Product product);

  bool selectAllProducts();

  bool deselectAllProducts();

  bool deselectProduct(Product product);

  bool toggleSearchState();

  bool updateShownProducts(List<Product> shownProducts);
}

//TODO: Outsource Supabase logic in a service class and inject it into the controller
class ProductControllerCubit extends Cubit<ProductListState>
    implements ProductController {
  final service = ProductService.create();
  final channel = Api.client.channel("products_items");

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
    // TODO: read filter options from local storage (Service Filter)
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
