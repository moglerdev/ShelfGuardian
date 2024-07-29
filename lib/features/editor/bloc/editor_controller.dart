import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/features/editor/bloc/editor_state.dart';
import 'package:shelf_guardian/features/product/models/product_model.dart';
import 'package:shelf_guardian/service/product_service.dart';

/// The controller class for the editor feature.
///
/// This class extends the `Cubit` class from the `flutter_bloc` package and
/// manages the state of the editor feature. It provides methods to load, update,
/// and save product data.
abstract class EditorController {
  /// Loads the product data based on the current state.
  ///
  /// If the state's [id] is less than 0, it checks if the [barcode] is empty.
  /// If it is empty, it emits a [FilledEditorState] with empty values.
  /// If the [barcode] is not empty, it calls the [getProductByBarcode] method
  /// from the [ProductService] to get the product data. If the product exists,
  /// it emits a [FilledEditorState] with the product data. If the product does
  /// not exist, it emits a [FilledEditorState] with empty values and the same
  /// [barcode].
  ///
  /// If the state's [id] is greater than or equal to 0, it calls the [getProduct]
  /// method from the [ProductService] to get the product data. If the product
  /// exists, it emits a [FilledEditorState] with the product data. If the product
  /// does not exist, it emits a [FilledEditorState] with empty values and the
  /// same [id].
  Future<void> load();

  /// Updates the product data in the state.
  ///
  /// The [barcode], [name], [price], and [expiryDate] parameters are used to
  /// update the corresponding fields in the state. If the state is a [FilledEditorState],
  /// it emits a new state with the updated values.
  void update({
    String? barcode,
    String? name,
    double? price,
    DateTime? expiryDate,
  });

  /// Saves the product data.
  ///
  /// The method first retrieves the current state and emits a [LoadingEditorState]
  /// with the same [barcode] and [id]. If the state is a [FilledEditorState], it
  /// checks if the [name] and [expiryDate] fields are empty. If they are not empty,
  /// it calls the [saveProduct] method from the [ProductService] to save the product
  /// data. If the save operation is successful, it emits the same state with the
  /// updated [id]. If the save operation fails, it emits the same state without
  /// any changes.
  Future<Product?> save();
}

class EditorControllerCubit extends Cubit<EditorState>
    implements EditorController {
  final service = ProductService.create();

  /// Constructs an instance of [EditorControllerCubit].
  ///
  /// The [barcode] and [id] parameters are used to initialize the initial state
  /// of the editor. The [load] method is called to load the product data.
  EditorControllerCubit(String barcode, int id)
      : super(LoadingEditorState(barcode: barcode, id: id)) {
    unawaited(load());
  }

  @override
  Future<void> load() async {
    if (state.id < 0) {
      if (state.barcode.isEmpty) {
        return emit(FilledEditorState.createEmpty());
      }
      final p = await service.getProductByBarcode(state.barcode);
      if (p != null) {
        return emit(FilledEditorState(
          p.name,
          null,
          barcode: state.barcode,
          id: p.id,
          price: p.priceInCents,
        ));
      } else {
        return emit(
            FilledEditorState.createEmpty().copyWith(barcode: state.barcode));
      }
      // load meta data, because id is not set
    } else {
      final p = await service.getProduct(state.id);
      if (p != null) {
        return emit(FilledEditorState(
          p.name,
          p.expiredAt,
          barcode: p.barcode,
          id: p.id,
          price: p.priceInCents,
        ));
      } else {
        return emit(FilledEditorState.createEmpty().copyWith(id: state.id));
      }
      // load data from database
    }
  }

  @override
  void update({
    String? barcode,
    String? name,
    double? price,
    DateTime? expiryDate,
  }) {
    if (state is FilledEditorState) {
      final priceInCents = price == null ? 0 : (price * 100).toInt();
      emit((state as FilledEditorState).copyWith(
        barcode: barcode,
        name: name,
        price: priceInCents,
        expiryDate: expiryDate,
      ));
    }
  }

  @override
  Future<Product?> save() async {
    final p = state;
    emit(LoadingEditorState(barcode: state.barcode, id: state.id));
    if (p is FilledEditorState) {
      if (p.name.isEmpty) {
        return null;
      }
      if (p.expiryDate == null) {
        return null;
      }
      try {
        final result = service.saveProduct(Product(
          id: p.id,
          barcode: p.barcode,
          name: p.name,
          priceInCents: p.price,
          description: '',
          image: '',
          expiredAt: p.expiryDate ?? DateTime.now(),
        ));
        emit(p.copyWith(id: p.id));
        return result;
      } catch (e) {
        emit(p.copyWith());
        return null;
      }
    }
    emit(
        FilledEditorState.createEmpty().copyWith(id: p.id, barcode: p.barcode));
    return null;
  }
}
