import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/models/product_model.dart';

class ProductController extends Cubit<List<Product>> {
  ProductController() : super(Product.products);

  void addProduct(Product product) {
    emit(state..add(product));
  }

  void removeProduct(Product product) {
    emit(state..remove(product));
  }
}
