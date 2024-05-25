import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<LoadProductsEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(ProductLoadedState(Product.products));
    });
    on<AddProductEvent>((event, emit) {
      if (this.state is! ProductLoadedState) return;
      final state = this.state as ProductLoadedState;
      final products = List<Product>.from(state.products)..add(event.product);
      emit(ProductLoadedState(products));
    });
    on<RemoveSelectedProductEvent>((event, emit) {
      if (this.state is! ProductSelectedState) return;
      final state = this.state as ProductSelectedState;
      final products = List<Product>.from(state.products);
      final selectedProducts = List<Product>.from(state.selectedProducts);
      for (final product in selectedProducts) {
        products.remove(product);
      }
      emit(ProductLoadedState(products));
    });
    on<SelectAllProductsEvent>((event, emit) {
      if (this.state is! ProductLoadedState) return;
      final state = this.state as ProductLoadedState;
      final products = List<Product>.from(state.products);
      emit(ProductSelectedState(products, products));
    });
    on<UnselectAllProductsEvent>((event, emit) {
      if (this.state is! ProductSelectedState) return;
      final state = this.state as ProductSelectedState;
      final products = List<Product>.from(state.products);
      emit(ProductLoadedState(products));
    });
    on<SelectProductEvent>((event, emit) {
      if (this.state is ProductSelectedState) {
        final state = this.state as ProductSelectedState;
        final products = List<Product>.from(state.products);
        final selectedProducts = List<Product>.from(state.selectedProducts);
        if (!selectedProducts.contains(event.product)) {
          selectedProducts.add(event.product);
          emit(ProductSelectedState(products, selectedProducts));
          return;
        }
        selectedProducts.remove(event.product);
        if (selectedProducts.isEmpty) {
          emit(ProductLoadedState(products));
        } else {
          emit(ProductSelectedState(products, selectedProducts));
        }
        return;
      }

      if (this.state is! ProductLoadedState) return;

      final state = this.state as ProductLoadedState;
      final products = List<Product>.from(state.products);
      final selectedProducts = <Product>[event.product];
      emit(ProductSelectedState(products, selectedProducts));
    });
  }
}
