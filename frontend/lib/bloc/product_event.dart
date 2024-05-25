part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;

  const AddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class SelectProductEvent extends ProductEvent {
  final Product product;

  const SelectProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class SelectAllProductsEvent extends ProductEvent {}

class UnselectAllProductsEvent extends ProductEvent {}

class RemoveSelectedProductEvent extends ProductEvent {
  const RemoveSelectedProductEvent();

  @override
  List<Object> get props => [];
}
