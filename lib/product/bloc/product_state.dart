import 'package:flutter/cupertino.dart';
import 'package:shelf_guardian/product/models/product_model.dart';

abstract class ProductListState {
  List<Product> getProducts();
  void dispose() {}
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
  final List<Product> shownProducts;
  final TextEditingController searchController;
  void Function(List<Product>) updateShownProducts;
  String lastSearchText;

  ProductSearchedList(this.products, this.shownProducts, this.searchController, this.updateShownProducts, this.lastSearchText) {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (lastSearchText != searchController.text) {
      print("searching" + searchController.text);
      print("last text" + lastSearchText);
      lastSearchText = searchController.text;
      searchProducts(searchController.text);
    }
  }

  void searchProducts(String query) {
    if(searchController.text.isEmpty) {
      updateShownProducts(products);
    } else {
      updateShownProducts(products.where((product) => product.name.contains(query)).toList());
      print("huhu" + shownProducts.toString());
    }
  }

  @override
  List<Product> getProducts() => shownProducts;

  @override
  void dispose() {
    // Vergessen Sie nicht, den Listener zu entfernen, um Speicherlecks zu vermeiden
    searchController.removeListener(_onSearchChanged);
  }
}
