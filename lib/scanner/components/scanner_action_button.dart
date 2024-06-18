import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelf_guardian/components/button.dart';
import 'package:shelf_guardian/scanner/bloc/scanner_controller.dart';

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return SGIconButton(
              icon: FontAwesomeIcons.lightbulb,
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.off:
            return SGIconButton(
              icon: FontAwesomeIcons.lightbulb,
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.on:
            return SGIconButton(
              icon: FontAwesomeIcons.lightbulb,
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.unavailable:
            return SGIconButton(
              icon: FontAwesomeIcons.slash,
              onPressed: () {},
            );
        }
      },
    );
  }
}

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }
        return SGIconButton(
          icon: FontAwesomeIcons.cameraRotate,
          onPressed: () async {
            await controller.switchCamera();
          },
        );
      },
    );
  }
}

class ScannerActionButton extends StatelessWidget {
  final MobileScannerController controller;
  final void Function() onEdit;
  const ScannerActionButton(
      {super.key, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerControllerCubit, ScannerState>(
        builder: (context, state) {
      List<Widget> leftBtns = [
        SwitchCameraButton(controller: controller),
        const SizedBox(width: 10),
      ];
      Widget mainBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.penToSquare,
        onPressed: () {
          onEdit();
        },
      );
      List<Widget> rightBtns = [
        const SizedBox(width: 10),
        ToggleFlashlightButton(
          controller: controller,
        ),
      ];
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [...leftBtns, mainBtn, ...rightBtns],
      );
    });
  }
}
