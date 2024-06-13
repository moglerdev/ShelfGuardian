import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/models/product_model.dart';

class SelectController extends Cubit<List<Product>> {
  SelectController() : super([]);

  void selectProduct(Product product) {
    emit([...state, product]);
  }

  void selectManyProducts(List<Product> products) {
    emit([...state, ...products]);
  }

  void unselectProduct(Product product) {
    emit(state.where((element) => element != product).toList());
  }

  void unselectAllProducts() {
    emit([]);
  }
}
