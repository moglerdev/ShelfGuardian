part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitialState extends ProductState {}

final class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductSelectedState extends ProductState {
  final List<Product> products;
  final List<Product> selectedProducts;

  const ProductSelectedState(this.products, this.selectedProducts);

  @override
  List<Object> get props => [products, selectedProducts];
}
