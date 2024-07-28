import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelf_guardian/features/scanner/bloc/scanner_controller.dart';
import 'package:shelf_guardian/features/scanner/components/scanner_action_button.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/service/easter_egg_service.dart';

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
    final router = GoRouter.of(context);
    if (mounted && !pause) {
      pause = true;
      await _controller.stop();
      _subscription?.pause();
      pause = true;
      final barcode = barcodes.barcodes.firstOrNull;
      barcodes.barcodes.clear();
      if (barcode != null && barcode.displayValue!.isNotEmpty) {
        final strCode = barcode.displayValue!;
        // our little easter egg ;)
        if (EasterEggService.instance.isRickRoll(strCode) &&
            await EasterEggService.instance.openRickRoll()) {
          router.go(NavigationServiceRoutes.homeRouteUri);
          return;
        }
        final code = Uri.encodeComponent(barcode.displayValue!);
        await router.push(NavigationServiceRoutes.createWithBarcodeRouteUri
            .replaceAll(":barcode",
                code)); // Future gets resolved when back button is pressed
      }
      try {
        _subscription?.resume();
        await _controller.start();
        pause = false;
      } catch (e) {
        router.go(NavigationServiceRoutes.homeRouteUri);
      }
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
