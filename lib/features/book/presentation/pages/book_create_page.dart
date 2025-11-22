import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookCreateNotifierProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: BookCreateWizard(_handleSubmit)),
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);

    try {
      final bookNotifier = ref.read(bookCreateNotifierProvider.notifier);
      final createdBook = await bookNotifier.createBook();

      await ref.read(bookListNotifierProvider.notifier).refreshBooks();
      ref.invalidate(bookDetailNotifierProvider(createdBook.id));

      await Future.delayed(const Duration(milliseconds: 2000));

      if (mounted) {
        _navigateToDetail(createdBook);
      }
    } on ArgumentError catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Error: ${e.message}');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, 'Could not save book');
        setState(() => _isLoading = false);
      }
    }
  }

  void _navigateToDetail(BookEntity book) =>
      AppRoutes.toBookDetailReplacing(context, book.id);

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.2),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
