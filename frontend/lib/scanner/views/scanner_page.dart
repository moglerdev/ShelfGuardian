import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelf_guardian/scanner/bloc/scanner_controller.dart';
import 'package:shelf_guardian/scanner/components/scanner_action_button.dart';

class BarcodeScanner extends StatefulWidget {
  final void Function(Barcode) onScanned;

  const BarcodeScanner({super.key, required this.onScanned});

  @override
  State createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with WidgetsBindingObserver {
  late final StreamSubscription<Object?>? _subscription;
  final MobileScannerController _controller = MobileScannerController();

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      final barcode = barcodes.barcodes.firstOrNull;
      if (barcode != null) {
        widget.onScanned(barcode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: _controller,
      errorBuilder: (context, error, child) {
        return Text('Error: $error');
      },
      fit: BoxFit.contain,
    );
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to the barcode events.
    _subscription = _controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(_controller.start());
  }
}

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ScannerControllerCubit(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Scanner'),
            ),
            floatingActionButton: const ScannerActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: BarcodeScanner(
              onScanned: (barcode) {
                context.go("/editor/${barcode.displayValue}");
              },
            )));
  }
}
