/// Represents the abstract base class for the different states of the editor.
abstract class EditorState {
  final String barcode;
  final int id;

  const EditorState({
    required this.barcode,
    required this.id,
  });
}

/// Represents the state when the editor is in a loading state.
class LoadingEditorState implements EditorState {
  @override
  final String barcode;
  @override
  final int id;

  const LoadingEditorState({
    required this.barcode,
    required this.id,
  });
}

/// Represents the state when the editor is filled with data.
class FilledEditorState implements EditorState {
  @override
  final String barcode;
  @override
  final int id;
  final String name;
  final DateTime? expiryDate;
  final int price;

  const FilledEditorState(
    this.name,
    this.expiryDate, {
    required this.barcode,
    required this.id,
    required this.price,
  });

  /// Creates an empty [FilledEditorState] with default values.
  static FilledEditorState createEmpty() {
    return const FilledEditorState(
      '',
      null,
      barcode: '',
      id: -1,
      price: 0,
    );
  }

  /// Creates a copy of the current [FilledEditorState] with optional updated values.
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
