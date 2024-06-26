import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/editor/bloc/editor_controller.dart';
import 'package:shelf_guardian/editor/bloc/editor_state.dart';
import 'package:shelf_guardian/editor/components/editor_action_button.dart';
import 'package:shelf_guardian/editor/views/editor_view.dart';

class EditorPage extends StatefulWidget {
  final String code;
  final int id;

  const EditorPage({super.key, required this.code, required this.id});

  @override
  State createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditorControllerCubit(widget.code, widget.id),
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.id < 0 ? 'Create' : 'Edit'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: const EditorActionButton(),
            // floatingActionButton: const ProductActionButton(),
            body: BlocBuilder<EditorControllerCubit, EditorState>(
              builder: (_, state) {
                if (state is FilledEditorState) {
                  return EditorView(code: widget.code, id: widget.id);
                }
                return const Center(child: CircularProgressIndicator());
              },
            )));
  }
}
