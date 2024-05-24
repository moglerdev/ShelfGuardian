import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';

void main() {
  Moment.setGlobalLocalization(MomentLocalizations.de());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<InventoryItem> items = [
      InventoryItem(
          name: "Käse",
          expire: Moment(DateTime.now()).add(const Duration(days: -365)).date),
      InventoryItem(
          name: "Frischmilch",
          expire: Moment(DateTime.now()).add(const Duration(days: -2)).date),
      InventoryItem(
          name: "Frischmilch",
          expire: Moment(DateTime.now()).add(const Duration(days: 2)).date),
      InventoryItem(
          name: "Eier",
          expire: Moment(DateTime.now()).add(const Duration(days: 2)).date),
      InventoryItem(
          name: "Joghurt",
          expire: Moment(DateTime.now()).add(const Duration(days: 6)).date),
      InventoryItem(
          name: "Pizza",
          expire: Moment(DateTime.now()).add(const Duration(days: 8)).date),
      InventoryItem(
          name: "Hackfleisch",
          expire: Moment(DateTime.now()).add(const Duration(days: 32)).date),
      InventoryItem(
          name: "Gemüse",
          expire: Moment(DateTime.now()).add(const Duration(days: 32)).date),
      InventoryItem(
          name: "Apfel Saft",
          expire: Moment(DateTime.now()).add(const Duration(days: 365)).date),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor:
              const Color(0xFF6C63FF), // Set the app bar color here
        ),
        body: Container(
          color: const Color(0xFFD2BBEA), // Set the background color here
          child: InventoryListWidget(items: items),
        ),
      ),
    );
  }
}

// Models
// #####################################################################################################

@immutable
class InventoryItem {
  final String name;
  final DateTime expire;

  get isExpired => expire.isBefore(DateTime.now());
  get fromNow => expire.toMoment().fromNow();

  const InventoryItem({required this.name, required this.expire});
}

@immutable
class InventoryItemWithIcon extends InventoryItem {
  final FaIcon icon;

  const InventoryItemWithIcon(
      {required super.name, required super.expire, required this.icon});
}

@immutable
class InventoryItemWithImage extends InventoryItem {
  final String imageUrl;

  const InventoryItemWithImage(
      {required super.name, required super.expire, required this.imageUrl});
}

// Widgets
// #####################################################################################################

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final void Function(bool?) onChanged;

  const CheckBoxWidget(
      {super.key, required this.isChecked, required this.onChanged});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(value: widget.isChecked, onChanged: widget.onChanged);
  }
}

class InventoryInheritedWidget extends InheritedWidget {
  final List<InventoryItem> items;

  const InventoryInheritedWidget(
      {super.key, required this.items, required super.child});

  static InventoryInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InventoryInheritedWidget>();
  }

  updateItem(int index, InventoryItem item) {
    items[index] = item;
  }

  @override
  bool updateShouldNotify(covariant InventoryInheritedWidget oldWidget) {
    return items != oldWidget.items;
  }
}

class InventoryItemWidget extends StatelessWidget {
  final InventoryItem item;

  const InventoryItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return Container(
      // height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            item.isExpired ? const Color(0xFFAD0392) : const Color(0xFF5603AD),
      ),
      padding: const EdgeInsets.all(10),
      // color: item.isExpired ? Color(0xFFAD0392) : Color(0xFF5603AD),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: const FaIcon(
            FontAwesomeIcons.cheese,
            color: Color(0xFFFFFFFF),
          ),
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              item.fromNow,
              style: const TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ],
        )),
        Column(
          children: [
            CheckBoxWidget(
                isChecked: false,
                onChanged: (bool? value) {
                  print("Checkbox changed to $value");
                }),
          ],
        )
      ]),
    );
  }
}

class InventoryListWidget extends StatelessWidget {
  final List<InventoryItem> items;
  const InventoryListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return InventoryInheritedWidget(
        items: items,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: InventoryItemWidget(item: item),
                );
              }),
        ));
  }
}
