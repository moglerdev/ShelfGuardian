import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/models/product_model.dart';

class FilterViewModel {}

class FilterController extends Cubit<FilterViewModel> {
  FilterController(Product product) : super(FilterViewModel());
}
