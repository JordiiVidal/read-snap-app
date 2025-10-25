import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookCreatePage extends ConsumerStatefulWidget {
  const BookCreatePage({super.key});

  @override
  ConsumerState<BookCreatePage> createState() => _BookCreatePageState();
}

class _BookCreatePageState extends ConsumerState<BookCreatePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookFormAsync = ref.watch(bookFormNotifierProvider);
    final bookFormNotifier = ref.read(bookFormNotifierProvider.notifier);
    final isLoading = bookFormAsync.maybeWhen(
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
                    bookFormNotifier,
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

  Future<bool> _handleExtraFieldsSheet(BookFormNotifier notifier) async {
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
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BookFormExtra(notifier),
        );
      },
    );

    return result ?? false;
  }

  Future<void> _handleSubmit(
    BookFormNotifier notifier,
    ScaffoldMessengerState scaffoldMessenger,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final result = await _handleExtraFieldsSheet(notifier);

      if (!result) {
        return;
      }

      await notifier.saveBook();
      await ref.read(bookListNotifierProvider.notifier).refreshBooks();

      if (!mounted) return;
      Navigator.of(context).pop();
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
