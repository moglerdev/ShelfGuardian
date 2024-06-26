import 'package:flutter_bloc/flutter_bloc.dart';

class EditorState {
  final String barcode;
  final int id;
  final String name;
  final DateTime expiryDate;
  final int price;

  const EditorState(
    this.name,
    this.expiryDate, {
    required this.barcode,
    required this.id,
    required this.price,
  });

  EditorState copyWith({
    String? name,
    DateTime? expiryDate,
    String? barcode,
    int? id,
    int? price,
  }) {
    return EditorState(
      name ?? this.name,
      expiryDate ?? this.expiryDate,
      barcode: barcode ?? this.barcode,
      id: id ?? this.id,
      price: price ?? this.price,
    );
  }
}

class EditorControllerCubit extends Cubit<EditorState> {
  EditorControllerCubit(String barcode, int id)
      : super(EditorState('', DateTime.now(),
            barcode: barcode, id: id, price: 0));

  void updateBarcode(String barcode) {
    emit(state.copyWith(barcode: barcode));
  }

  void updateId(int id) {
    emit(state.copyWith(id: id));
  }

  void save() {
    // TODO: Save data
  }
}
