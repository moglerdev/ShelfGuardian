import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/models/product_model.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/service/product_service.dart';

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
  final service = ProductService.create();

  ProductControllerCubit() : super(ProductListEmpty()) {
    unawaited(initProducts());
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
