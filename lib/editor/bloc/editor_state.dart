abstract class EditorState {
  final String barcode;
  final int id;

  const EditorState({
    required this.barcode,
    required this.id,
  });
}

class LoadingEditorState implements EditorState {
  final String barcode;
  final int id;

  const LoadingEditorState({
    required this.barcode,
    required this.id,
  });
}

class FilledEditorState implements EditorState {
  final String barcode;
  final int id;
  final String name;
  final DateTime expiryDate;
  final int price;

  const FilledEditorState(
    this.name,
    this.expiryDate, {
    required this.barcode,
    required this.id,
    required this.price,
  });

  static FilledEditorState createEmpty() {
    return FilledEditorState(
      '',
      DateTime.now(),
      barcode: '',
      id: -1,
      price: 0,
    );
  }

  EditorState copyWith({
    String? name,
    DateTime? expiryDate,
    String? barcode,
    int? id,
    int? price,
  }) {
    return FilledEditorState(
      name ?? this.name,
      expiryDate ?? this.expiryDate,
      barcode: barcode ?? this.barcode,
      id: id ?? this.id,
      price: price ?? this.price,
    );
  }
}
