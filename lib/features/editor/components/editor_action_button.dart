import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/icon_button.dart';
import 'package:shelf_guardian/common/routes_service.dart';
import 'package:shelf_guardian/features/editor/bloc/editor_controller.dart';
import 'package:shelf_guardian/features/editor/bloc/editor_state.dart';

/// A button that provides actions for the editor screen.
class EditorActionButton extends StatelessWidget {
  const EditorActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorControllerCubit, EditorState>(
        builder: (context, state) {
      final router = GoRouter.of(context);
      final sm = ScaffoldMessenger.of(context);
      Widget cancelBtn = SGIconButton(
        icon: FontAwesomeIcons.squareXmark,
        onPressed: () {
          router.go(NavigationServiceRoutes.homeRouteUri);
        },
      );
      Widget saveBtn = SGIconButton(
        size: 50,
        icon: FontAwesomeIcons.floppyDisk,
        onPressed: () async {
          if (state is! FilledEditorState) {
            return;
          }
          try {
            final controller = context.read<EditorControllerCubit>();
            final p = await controller.save();
            if (p != null) {
              router.go(NavigationServiceRoutes.homeRouteUri);
            } else {
              sm.showSnackBar(const SnackBar(
                  content: Text("Bitte füllen Sie alle Felder aus!")));
            }
          } catch (e) {
            sm.showSnackBar(
                const SnackBar(content: Text("Etwas ist schiefgelaufen!")));
          }
        },
      );
      Widget scanBtn = SGIconButton(
        icon: FontAwesomeIcons.cameraRetro,
        onPressed: () {
          context.pop();
        },
      );
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          cancelBtn,
          const Spacer(flex: 1),
          saveBtn,
          const Spacer(flex: 1),
          scanBtn,
          const Spacer(flex: 1),
        ],
      );
    });
  }
}
