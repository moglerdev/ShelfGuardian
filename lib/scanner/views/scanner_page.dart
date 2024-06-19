import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelf_guardian/scanner/bloc/scanner_controller.dart';
import 'package:shelf_guardian/scanner/components/scanner_action_button.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  late final StreamSubscription<Object?>? _subscription;
  bool _isPaused = false;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (_isPaused) {
      return;
    }
    if (mounted) {
      _isPaused = true;
      final barcode = barcodes.barcodes.firstOrNull;
      if (barcode != null) {
        context.pushReplacement('/editor/${barcode.displayValue}');
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!_controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = _controller.barcodes.listen(_handleBarcode);

        unawaited(_controller.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ScannerControllerCubit(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Scanner'),
            ),
            floatingActionButton: ScannerActionButton(
              controller: _controller,
              onEdit: () {
                context.pushReplacement('/editor');
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: MobileScanner(
              controller: _controller,
              errorBuilder: (context, error, child) {
                return Text('Error: $error');
              },
            )));
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    await _subscription?.cancel();
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
