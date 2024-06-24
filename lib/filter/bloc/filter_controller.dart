import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';

abstract class FilterController {
  void saveFilter();
  void deleteFilter();
  bool isDecending();
  void toggleSorting();
}

class FilterControllerCubit extends Cubit<ProductListState>
    implements FilterController {
  FilterControllerCubit() : super(ProductListEmpty());

  @override
  void saveFilter() {
    //TODO: implement saveFilter
    print("TODO: implement saveFilter");
  }

  @override
  void deleteFilter() {
    //TODO: implement deleteFilter
    print("TODO: implement deleteFilter");
  }

  @override
  bool isDecending() {
    //TODO: implement isDecending
    return true;
  }

  void toggleSorting() {
    //TODO: implement toggleSorting
  }
}
