import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelf_guardian/scanner/bloc/scanner_controller.dart';
import 'package:shelf_guardian/scanner/components/scanner_action_button.dart';
import 'package:shelf_guardian/common/routes_service.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  late final StreamSubscription<Object?>? _subscription;
  bool pause = false;

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (mounted && !pause) {
      pause = true;
      await _controller.stop();
      _subscription?.pause();
      pause = true;
      final barcode = barcodes.barcodes.firstOrNull;
      barcodes.barcodes.clear();
      if (barcode != null) {
        // TODO: On navigate back to scanner page, reactivate camera;
        // TODO: disable camera when navigating to editor page;
        await context.push(NavigationServiceRoutes.createWithBarcodeRouteUri
            .replaceAll(":barcode",
                "${barcode.displayValue}")); // Future gets resolved when back button is pressed
      }
      _subscription?.resume();
      await _controller.start();
      pause = false;
    }
  }

  Future<void> _tryStart() async {
    try {
      _subscription = _controller.barcodes.listen(_handleBarcode);
      return await _controller.start();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _tryStop() async {
    try {
      await _subscription?.cancel();
      await _controller.stop();
    } catch (e) {
      debugPrint('Error: $e');
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
        try {
          unawaited(_tryStart());
        } catch (e) {
          debugPrint('Error: $e');
        }
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_tryStop());
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
                context.push(NavigationServiceRoutes.createRouteUri);
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
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Finally, start the scanner itself.
    unawaited(_tryStart());
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    await _tryStop();
    _controller.dispose();
  }

  @override
  void reassemble() {
    unawaited(_tryStop());
    super.reassemble();
  }
}
