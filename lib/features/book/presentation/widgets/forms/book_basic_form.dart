import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';

class BookBasicForm extends StatefulWidget {
  final Function({
    required String title,
    required String author,
    required BuildContext context,
  })
  onSubmit;

  const BookBasicForm(this.onSubmit, {super.key});

  @override
  State<BookBasicForm> createState() => BookBasicFormState();
}

class BookBasicFormState extends State<BookBasicForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          // Title Field
          DynamicFormField(
            label: 'Title',
            hintText: 'Enter book title',
            required: true,
            controller: _titleController,
          ),

          // Author Field
          DynamicFormField(
            label: 'Author',
            hintText: 'Enter author name',
            required: true,
            controller: _authorController,
          ),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _handleSubmit(context),
              child: const Text('Add Book'),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        context: context,
      );
    }
  }
}
