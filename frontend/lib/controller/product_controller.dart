import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/models/product_model.dart';

abstract class ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;

  ProductListLoaded(this.products);
}

class ProductListSelected extends ProductListState {
  final List<Product> products;
  final List<Product> selectedProducts;

  ProductListSelected(this.products, this.selectedProducts);
}

abstract class ProductController {
  void initProducts(List<Product> products);

  void addProduct(Product product);

  void removeProduct(Product product);

  void removeSelectedProducts();

  void selectProduct(Product product);

  void selectAllProducts();

  void deselectAllProducts();

  void deselectProduct(Product product);
}

class ProductControllerCubit extends Cubit<ProductListState>
    implements ProductController {
  ProductControllerCubit() : super(ProductListLoading()) {}

  @override
  void initProducts(List<Product> products) {
    emit(ProductListLoaded(products));
  }

  @override
  void addProduct(Product product) {
    if (state is ProductListLoading) {
      emit(ProductListLoaded([product]));
      return;
    }
  }

  @override
  void removeProduct(Product product) {
    if (state is ProductListLoading) {
      return;
    }
    emit(ProductListLoaded((state as ProductListLoaded)
        .products
        .where((element) => element != product)
        .toList()));
  }

  @override
  void removeSelectedProducts() {
    if (state is ProductListLoading) {
      return;
    }
    emit(ProductListLoaded((state as ProductListLoaded)
        .products
        .where((element) =>
            !(state as ProductListSelected).selectedProducts.contains(element))
        .toList()));
  }

  @override
  void selectProduct(Product product) {
    if (state is ProductListLoading) {
      return;
    }
    emit(ProductListSelected(
        (state as ProductListLoaded).products,
        (state as ProductListSelected).selectedProducts
          ..add(product)
          ..toSet()
          ..toList()));
  }

  @override
  void selectAllProducts() {
    if (state is ProductListLoading) {
      return;
    }
    emit(ProductListSelected(
        (state as ProductListLoaded).products,
        (state as ProductListLoaded)
            .products
            .toSet()
            .difference((state as ProductListSelected).selectedProducts.toSet())
            .toList()));
  }

  @override
  void deselectAllProducts() {
    if (state is ProductListLoading) {
      return;
    }
    emit(ProductListSelected((state as ProductListLoaded).products, []));
  }

  @override
  void deselectProduct(Product product) {
    if (state is ProductListLoading) {
      return;
    }
    emit(ProductListSelected(
        (state as ProductListLoaded).products,
        (state as ProductListSelected).selectedProducts
          ..remove(product)
          ..toSet()
          ..toList()));
  }
}
