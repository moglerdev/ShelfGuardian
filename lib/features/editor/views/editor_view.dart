import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/components/date_field.dart';
import 'package:shelf_guardian/components/input_field.dart';
import 'package:shelf_guardian/editor/bloc/editor_controller.dart';
import 'package:shelf_guardian/editor/bloc/editor_state.dart';

class EditorView extends StatefulWidget {
  final String code;
  final int id;

  const EditorView({super.key, required this.code, required this.id});

  @override
  State createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorControllerCubit, EditorState>(
      builder: (context, state) {
        if (state is LoadingEditorState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is! FilledEditorState) {
          return const Center(child: Text('Something went wrong'));
        }
        if (isLoaded == false) {
          isLoaded = true;
          barcodeController.text = state.barcode;
          barcodeController.addListener(() {
            context
                .read<EditorControllerCubit>()
                .update(barcode: barcodeController.text);
          });
          nameController.text = state.name;
          nameController.addListener(() {
            context
                .read<EditorControllerCubit>()
                .update(name: nameController.text);
          });
          priceController.text = "${state.price / 100}";
          priceController.addListener(() {
            context
                .read<EditorControllerCubit>()
                .update(price: double.tryParse(priceController.text));
          });
        }

        return ListView(
          children: [
            InputField(
              name: "Bar Code",
              value: barcodeController.text,
              controller: barcodeController,
            ),
            InputField(
              name: "Name",
              value: nameController.text,
              controller: nameController,
            ),
            DateField(
              name: "Mindesthaltbarkeitsdatum",
              date: state.expiryDate,
              setDate: (p0) {
                context.read<EditorControllerCubit>().update(expiryDate: p0);
              },
            ),
            InputField(
              name: "Preis",
              value: priceController.text,
              controller: priceController,
            ),
          ],
        );
      },
    );
  }
}
