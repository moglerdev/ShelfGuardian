import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/editor/bloc/editor_state.dart';
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
        emit(FilledEditorState.createEmpty());
        return;
      }
      final p = await service.getProductByBarcode(state.barcode);
      if (p != null) {
        emit(FilledEditorState(
          p.name,
          p.expiredAt,
          barcode: state.barcode,
          id: p.id,
          price: p.priceInCents,
        ));
      } else {
        emit(FilledEditorState.createEmpty().copyWith(barcode: state.barcode));
      }
      // load meta data, because id is not set
    } else {
      final p = await service.getProduct(state.id);
      if (p != null) {
        emit(FilledEditorState(
          p.name,
          p.expiredAt,
          barcode: p.barcode,
          id: p.id,
          price: p.priceInCents,
        ));
      } else {
        emit(FilledEditorState.createEmpty().copyWith(id: state.id));
      }
      // load data from database
    }
  }

  void setBarcode(String barcode) {
    if (state is FilledEditorState) {
      emit((state as FilledEditorState).copyWith(barcode: barcode));
    }
  }

  void setName(String name) {
    if (state is FilledEditorState) {
      emit((state as FilledEditorState).copyWith(name: name));
    }
  }

  void setPrice(int price) {
    if (state is FilledEditorState) {
      emit((state as FilledEditorState).copyWith(price: price));
    }
  }

  void setExpiryDate(DateTime expiryDate) {
    if (state is FilledEditorState) {
      emit((state as FilledEditorState).copyWith(expiryDate: expiryDate));
    }
  }

  void save() {
    if (state is FilledEditorState) {
      // final p = state as FilledEditorState;
      // service.saveProduct(Product(
      //   id: p.id,
      //   name: p.name,
      //   priceInCents: p.price,
      //   expiredAt: p.expiryDate,
      // ));
    }
  }
}
