import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookFormPage extends ConsumerStatefulWidget {
  const BookFormPage({super.key});

  @override
  ConsumerState<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends ConsumerState<BookFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(bookFormNotifierProvider.notifier);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form Body
            Expanded(
              child: SingleChildScrollView(child: BookFormBody(_formKey)),
            ),
            const SizedBox(height: 16),

            // Submit Button
            SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: BookFormSubmit(
                  'Add Book',
                  () => _handleSubmit(notifier, navigator, scaffoldMessenger),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit(
    BookFormNotifier notifier,
    NavigatorState navigator,
    ScaffoldMessengerState scaffoldMessenger,
  ) async {
    if (_formKey.currentState!.validate()) {
      try {
        await notifier.saveBook();
        await ref.read(bookListNotifierProvider.notifier).refreshBooks();
        if (!mounted) return;
        navigator.pop();
      } catch (e) {
        if (!mounted) return;
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e is ArgumentError ? e.message : 'Could not save book'}',
            ),
          ),
        );
      }
    }
  }
}
