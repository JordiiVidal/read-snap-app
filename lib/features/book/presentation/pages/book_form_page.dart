import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/features/book/presentation/widgets/form/book_form_extra.dart';

class BookFormPage extends ConsumerStatefulWidget {
  const BookFormPage({super.key});

  @override
  ConsumerState<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends ConsumerState<BookFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(bookFormNotifierProvider);
    final notifier = ref.read(bookFormNotifierProvider.notifier);
    final isLoading = formState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Title
              Text(
                'Add New Book',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Descripiton
              const Text(
                'Add a book to your reading tracker. Fill in the details below.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Form
              BookForm(_formKey),
              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: FormSubmit(
                  isLoading: isLoading,
                  'Add Book',
                  () => _handleSubmit(
                    notifier,
                    Navigator.of(context),
                    ScaffoldMessenger.of(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(
    BookFormNotifier notifier,
    NavigatorState navigator,
    ScaffoldMessengerState scaffoldMessenger,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final result = await _handleExtraFieldsSheet(notifier, context);

      if (!result) {
        return;
      }

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

  Future<bool> _handleExtraFieldsSheet(
    BookFormNotifier notifier,
    BuildContext context,
  ) async {
    final currentBookDraft = notifier.currentBookDraft;

    if (currentBookDraft.status == BookStatus.toRead) {
      return true;
    }

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: BookFormExtra(notifier),
          ),
        );
      },
    );

    return result ?? false;
  }
}
