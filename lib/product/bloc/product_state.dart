import 'package:shelf_guardian/product/models/product_model.dart';

abstract class ProductListState {
  List<Product> getProducts();
}

class ProductListEmpty extends ProductListState {
  @override
  List<Product> getProducts() => [];
}

class ProductListLoading extends ProductListState {
  @override
  List<Product> getProducts() => [];
}

class ProductListFilled extends ProductListState {
  final List<Product> products;

  @override
  List<Product> getProducts() => products;

  ProductListFilled(this.products);
}

class ProductListSelected extends ProductListState {
  final List<Product> products;
  final List<Product> selectedProducts;

  @override
  List<Product> getProducts() => products;

  ProductListSelected(this.products, this.selectedProducts);
}


// TODO: Implement ProductSearchedList
class ProductSearchedList extends ProductListState {
  final List<Product> products;
  final String search;
  final List<Product> shownProducts;

  @override
  List<Product> getProducts() => products;

  ProductSearchedList(this.products, this.search, this.shownProducts);
}
