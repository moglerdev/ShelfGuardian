import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/editor/bloc/editor_controller.dart';
import 'package:shelf_guardian/editor/bloc/editor_state.dart';
import 'package:shelf_guardian/editor/components/date_picker.dart';

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

        return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                  ),
                  controller: barcodeController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  controller: nameController,
                ),
                DatePickerTextField(
                  state.expiryDate,
                  onDateSelected: (p0) {
                    context
                        .read<EditorControllerCubit>()
                        .update(expiryDate: p0);
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Preis',
                  ),
                  controller: priceController,
                ),
              ],
            ));
      },
    );
  }
}
