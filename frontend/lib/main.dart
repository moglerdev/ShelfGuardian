import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/inventory/list.dart';
import 'package:shelf_guardian/models/inventory.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                backgroundColor:
                    const WidgetStatePropertyAll(Color(0xFF6C63FF)),
                iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF))),
            onPressed: () {},
            iconSize: 50.0,
            icon: const Icon(
              FontAwesomeIcons.gear,
              shadows: [
                Shadow(
                    color: Color.fromARGB(97, 0, 0, 0),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0)
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: const WidgetStatePropertyAll(Color(0xFF6C63FF)),
              iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
            ),
            onPressed: () {},
            iconSize: 50.0,
            icon: const Icon(
              FontAwesomeIcons.filter,
              shadows: [
                Shadow(
                    color: Color.fromARGB(97, 0, 0, 0),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0)
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              backgroundColor: const WidgetStatePropertyAll(Color(0xFF6C63FF)),
              iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
            ),
            onPressed: () {},
            iconSize: 70.0,
            icon: const Icon(
              FontAwesomeIcons.plus,
              shadows: [
                Shadow(
                    color: Color.fromARGB(97, 0, 0, 0),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0)
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: const WidgetStatePropertyAll(Color(0xFF6C63FF)),
              iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
            ),
            onPressed: () {},
            iconSize: 50.0,
            icon: const Icon(
              FontAwesomeIcons.checkDouble,
              shadows: [
                Shadow(
                    color: Color.fromARGB(97, 0, 0, 0),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0)
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: const WidgetStatePropertyAll(Color(0xFF6C63FF)),
              iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
            ),
            onPressed: () {},
            iconSize: 50.0,
            icon: const Icon(
              FontAwesomeIcons.searchengin,
              shadows: [
                Shadow(
                    color: Color.fromARGB(97, 0, 0, 0),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
