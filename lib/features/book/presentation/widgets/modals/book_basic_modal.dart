import 'package:flutter/material.dart';
import 'package:read_snap/features/book/presentation/widgets/forms/book_basic_form.dart';

class BookBasicModal extends StatelessWidget {
  const BookBasicModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BookBasicForm(({
            required title,
            required author,
            required context,
          }) {
            final data = {'title': title, 'author': author};
            Navigator.of(context).pop(data);
          }),
        ),
      ),
    );
  }

  static Future<Map<String, String>?> show(BuildContext context) {
    return showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const BookBasicModal(),
    );
  }
}
