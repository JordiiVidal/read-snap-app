import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/config/app_colors.dart';
import 'package:read_snap/config/routes/app_routes.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_detail_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/wizard/book_create_wizard.dart';
import 'package:read_snap/shared/utils/custom_snack_bar.dart';

class BookCreatePage extends ConsumerStatefulWidget {
  const BookCreatePage({super.key});

  @override
  ConsumerState<BookCreatePage> createState() => _BookCreatePageState();
}

class _BookCreatePageState extends ConsumerState<BookCreatePage> {
  @override
  Widget build(BuildContext context) {
    final bookAsync = ref.watch(bookCreateNotifierProvider);
    final isLoading = bookAsync.isLoading;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: BookCreateWizard(_handleSubmit)),
          if (isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    try {
      final bookNotifier = ref.read(bookCreateNotifierProvider.notifier);
      final createdBook = await bookNotifier.createBook();

      await ref.read(bookListNotifierProvider.notifier).refreshBooks();
      ref.invalidate(bookDetailNotifierProvider(createdBook.id));

      if (mounted) {
        _navigateToDetail(createdBook);
        bookNotifier.reset();
      }
    } on ArgumentError catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Error: ${e.message}');
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Could not save book');
      }
    }
  }

  void _navigateToDetail(BookEntity book) =>
      AppRoutes.toBookDetailReplacing(context, book.id);

  Widget _buildLoadingOverlay() {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.2),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
