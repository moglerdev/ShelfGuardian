import 'package:flutter/widgets.dart';
import 'package:shelf_guardian/models/inventory.dart';

class InventoryProviderWidget extends InheritedWidget {
  final List<InventoryItem> items;
  final List<InventoryItem> selectedItems = [];

  InventoryProviderWidget(
      {super.key, required this.items, required super.child});

  static InventoryProviderWidget of(BuildContext context) {
    var x =
        context.dependOnInheritedWidgetOfExactType<InventoryProviderWidget>();
    if (x == null) {
      throw Exception("No InventoryProviderWidget found in context");
    }
    return x;
  }

  updateItem(int index, InventoryItem item) {
    items[index] = item;
  }

  selectItem(InventoryItem item) {
    selectedItems.add(item);
  }

  unselectItem(InventoryItem item) {
    selectedItems.remove(item);
  }

  @override
  bool updateShouldNotify(covariant InventoryProviderWidget oldWidget) {
    return true;
  }
}
