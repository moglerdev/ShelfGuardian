import 'package:flutter/material.dart';
import 'package:shelf_guardian/routes.dart';
import 'package:shelf_guardian/views/scanner_view.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: ScannerView(),
    );
  }
}
