import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/shared/widgets/forms/form_page_scaffold.dart';

class BookCreatePage extends ConsumerStatefulWidget {
  const BookCreatePage({super.key});

  @override
  ConsumerState<BookCreatePage> createState() => _BookCreatePageState();
}

class _BookCreatePageState extends ConsumerState<BookCreatePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookCreateAsync = ref.watch(bookCreateNotifierProvider);
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final isLoading = bookCreateAsync.isLoading;

    return FormPageScaffold(
      title: 'Add New Book',
      subtitle:
          'Add a book to your reading tracker. Fill in the details below.',
      isLoading: isLoading,
      submitButtonText: 'Add Book',
      form: BookFormCreate(_formKey),
      onSubmit: () => _handleSubmit(bookCreateNotifier),
    );
  }

  Future<void> _handleSubmit(BookCreateNotifier notifier) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final createdBook = await notifier.createBook();

      if (createdBook.status != BookStatus.toRead && mounted) {
        await _showExtraFieldsSheet(createdBook);
      }

      await ref.read(bookListNotifierProvider.notifier).refreshBooks();
      if (mounted) Navigator.of(context).pop();
    } on ArgumentError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Could not save book')),
        );
      }
    }
  }

  Future<bool> _showExtraFieldsSheet(BookEntity book) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BookFormUpdateExtra(book),
      ),
    );

    return result ?? false;
  }
}
