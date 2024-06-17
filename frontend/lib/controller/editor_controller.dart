import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/models/product_model.dart';

class EditorViewModel {}

class EditorController extends Cubit<EditorViewModel> {
  EditorController(Product product) : super(EditorViewModel());
}
