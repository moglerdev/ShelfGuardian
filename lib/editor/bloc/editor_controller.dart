import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/editor/bloc/editor_state.dart';
import 'package:shelf_guardian/product/models/product_model.dart';
import 'package:shelf_guardian/service/product_service.dart';

class EditorControllerCubit extends Cubit<EditorState> {
  final service = ProductService.create();

  EditorControllerCubit(String barcode, int id)
      : super(LoadingEditorState(barcode: barcode, id: id)) {
    unawaited(load());
  }

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
