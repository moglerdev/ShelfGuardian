import 'package:flutter/cupertino.dart';
import 'package:shelf_guardian/features/product/models/product_model.dart';

/// Abstract class representing the state of a product list.
abstract class ProductListState {
  /// Returns a list of all products.
  List<Product> getProducts();

  /// Returns a list of searched products.
  List<Product> getSearchedProducts() => [];

  /// Disposes the listener.
  void disposeListener() {}
}

/// Represents the state when the product list is empty.
class ProductListEmpty extends ProductListState {
  @override
  List<Product> getProducts() => [];
}

/// Represents the state when the product list is loading.
class ProductListLoading extends ProductListState {
  @override
  List<Product> getProducts() => [];
}

/// Represents the state when the product list is filled with products.
class ProductListFilled extends ProductListState {
  final List<Product> products;

  ProductListFilled(this.products);

  @override
  List<Product> getProducts() => products;
}

/// Represents the state when some products in the list are selected.
class ProductListSelected extends ProductListState {
  final List<Product> products;
  final List<Product> selectedProducts;

  ProductListSelected(this.products, this.selectedProducts);

  @override
  List<Product> getProducts() => products;
}

/// Represents the state when the product list is filtered based on a search query.
class ProductSearchedList extends ProductListState {
  final List<Product> products;
  final List<Product> shownProducts;
  final TextEditingController searchController;
  void Function(List<Product>) updateShownProducts;
  String lastSearchText;

  ProductSearchedList(this.products, this.shownProducts, this.searchController,
      this.updateShownProducts, this.lastSearchText) {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (lastSearchText != searchController.text) {
      lastSearchText = searchController.text;
      searchProducts(searchController.text);
    }
  }

  void searchProducts(String query) {
    if (searchController.text.isEmpty) {
      updateShownProducts(products);
    } else {
      updateShownProducts(
          products.where((product) => product.name.contains(query)).toList());
    }
  }

  @override
  List<Product> getProducts() => products;

  @override
  List<Product> getSearchedProducts() => shownProducts;

  @override
  void disposeListener() {
    // Don't forget to remove the listener to avoid memory leaks
    searchController.removeListener(_onSearchChanged);
  }
}
