import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelf_guardian/components/icon_button.dart';
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
      Widget toggleCamBtn = SwitchCameraButton(controller: controller);
      Widget toggleLightBtn = ToggleFlashlightButton(
        controller: controller,
      );
      Widget editorBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.penToSquare,
        onPressed: () {
          onEdit();
        },
      );
      Widget cancelBtn = SGIconButton(
        icon: FontAwesomeIcons.squareXmark,
        onPressed: () {
          context.pop();
        },
      );
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          toggleCamBtn,
          const SizedBox(width: 10),
          toggleLightBtn,
          const Spacer(flex: 1),
          editorBtn,
          const Spacer(flex: 1),
          const SizedBox(width: 25),
          cancelBtn,
          const SizedBox(width: 25),
          const Spacer(flex: 1),
        ],
      );
    });
  }
}
