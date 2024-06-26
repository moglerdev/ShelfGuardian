import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/models/product_model.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/supabase.dart';

abstract class ProductController {
  Future<bool> initProducts();

  bool addProduct(Product product);

  bool removeProduct(Product product);

  bool removeSelectedProducts();

  bool selectProduct(Product product);

  bool selectAllProducts();

  bool deselectAllProducts();

  bool deselectProduct(Product product);
}

//TODO: Outsource Supabase logic in a service class and inject it into the controller
class ProductControllerCubit extends Cubit<ProductListState>
    implements ProductController {
  ProductControllerCubit() : super(ProductListEmpty()) {
    unawaited(initProducts());
  }

  @override
  Future<bool> initProducts() async {
    // TODO: read filter options from local storage (Service Filter)
    emit(ProductListLoading());
    var result = await SBClient.supabaseClient
        .from("products_items")
        .select(
            "id, meta_id, price_in_cents, expired_at, created_at, products_meta(id, barcode, name, description, created_at)")
        .order("expired_at", ascending: true);
    if (result.isEmpty) {
      emit(ProductListEmpty());
      return false;
    } else {
      List<Product> products = result.map((e) {
        var meta =
            DbProductMeta.fromJson(e["products_meta"] as Map<String, dynamic>);
        var item = DbProductItem.fromJson(e);
        return Product(
            name: meta.name ?? "Unknown",
            description: meta.description ?? "Unknown",
            priceInCents: item.priceInCents ?? 0,
            image: "https://via.placeholder.com/150",
            expiredAt: item.expiredAt ?? DateTime.now());
      }).toList();
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
  bool removeSelectedProducts() {
    if (state is ProductListSelected) {
      List<Product> products = (state as ProductListSelected)
          .products
          .where((element) => !(state as ProductListSelected)
              .selectedProducts
              .contains(element))
          .toList();
      emit(ProductListFilled(products));
      return true;
    }
    return false;
  }

  @override
  bool selectProduct(Product product) {
    if (state is ProductListLoading) {
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
    if (state is ProductListSelected || state is ProductListLoading) {
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
}
