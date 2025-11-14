import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/config/routes/app_routes.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_detail_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/wizard/book_create_wizard.dart';

class BookCreatePage extends ConsumerStatefulWidget {
  const BookCreatePage({super.key});

  @override
  ConsumerState<BookCreatePage> createState() => _BookCreatePageState();
}

class _BookCreatePageState extends ConsumerState<BookCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BookCreateWizard(_handleSubmit)));
  }

  void _handleSubmit() async {
    try {
      final createdBook = await ref
          .read(bookCreateNotifierProvider.notifier)
          .createBook();
      await ref.read(bookListNotifierProvider.notifier).refreshBooks();
      ref.invalidate(bookDetailNotifierProvider(createdBook.id));
      ref.read(bookCreateNotifierProvider.notifier).reset();
      if (mounted) _navigateToDetail(createdBook);
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

  void _navigateToDetail(BookEntity book) =>
      AppRoutes.toBookDetailReplacing(context, book.id);
}
