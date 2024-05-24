import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shelf_guardian/inventory/checkbox.dart';
import 'package:shelf_guardian/inventory/item.dart';
import 'package:shelf_guardian/inventory/provider.dart';
import 'package:shelf_guardian/models/inventory.dart';

class InventoryListWidget extends StatefulWidget {
  final List<InventoryItem> items;
  final List<InventoryItem> selectedItems = [];

  InventoryListWidget({super.key, required this.items});

  @override
  State<InventoryListWidget> createState() => _InventoryListWidgetState();
}

class _InventoryListWidgetState extends State<InventoryListWidget> {
  void _onChanged(bool isChecked, InventoryItem item) {
    isChecked
        ? widget.selectedItems.add(item)
        : widget.selectedItems.remove(item);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InventoryProviderWidget(
        items: widget.items,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: InventoryItemWidget(
                      item: item,
                      checkBoxWidget: CheckBoxWidget(
                        isChecked: widget.selectedItems.contains(item),
                        onChanged: (isChecked) {
                          _onChanged(isChecked!, item);
                        },
                      )),
                );
              }),
        ));
  }
}
