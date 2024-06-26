import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/editor/bloc/editor_controller.dart';

class InputField extends StatefulWidget {
  final String label;

  const InputField({super.key, required this.label});

  @override
  State createState() => _InputState();
}

class _InputState extends State<InputField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Bar Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.purple[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: TextEditingController(text: '4 337256 366533'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({super.key});

  @override
  State createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  final TextEditingController _dateController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = Moment(picked).format("L");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      decoration: const InputDecoration(
        labelText: 'Enter Date',
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}

class EditorPage extends StatefulWidget {
  final String code;
  final int id;

  const EditorPage({super.key, required this.code, required this.id});

  @override
  State createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditorControllerCubit(widget.code, widget.id),
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.id == -1 ? 'Create' : 'Edit'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // floatingActionButton: const ProductActionButton(),
            body: const EditorView()));
  }
}

class EditorView extends StatelessWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorControllerCubit, EditorState>(
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                  ),
                  controller: TextEditingController(text: state.barcode),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  controller: TextEditingController(text: state.name),
                ),
                const DatePickerTextField(),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Preis',
                  ),
                  controller: TextEditingController(text: "${state.price}"),
                ),
              ],
            ));
      },
    );
  }
}
