import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/config/routes/app_routes.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_detail_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/book_header.dart';
import 'package:read_snap/features/book/presentation/widgets/cards/book_card_progress.dart';
import 'package:read_snap/features/book/presentation/widgets/cards/book_card_status.dart';
import 'package:read_snap/features/session/presentation/widgets/cards/session_card_reading.dart';
import 'package:read_snap/features/session/presentation/widgets/lists/session_list.dart';
import 'package:read_snap/shared/widgets/common/async_value_widget.dart';
import 'package:read_snap/shared/widgets/dialogs/dialogs.dart';

class BookDetailPage extends ConsumerWidget {
  final String bookId;

  const BookDetailPage(this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));

    return AsyncValueWidget<BookEntity>(
      value: bookAsync,
      data: (book) => _BookDetailContent(book: book, bookId: bookId),
    );
  }
}

// Separar el contenido en widget privado
class _BookDetailContent extends ConsumerStatefulWidget {
  final BookEntity book;
  final String bookId;

  const _BookDetailContent({required this.book, required this.bookId});

  @override
  ConsumerState<_BookDetailContent> createState() => _BookDetailContentState();
}

class _BookDetailContentState extends ConsumerState<_BookDetailContent> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: _isDeleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_outline),
            onPressed: _isDeleting ? null : _handleDelete,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: BookHeader(widget.book),
          ),
          const SizedBox(height: 16),

          // Cards (Stats)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              spacing: 12,
              children: [
                BookCardProgress(widget.book),
                SessionCardReading(widget.bookId),
                BookCardStatus(widget.book),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Button
          if (widget.book.status != BookStatus.completed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: FilledButton.icon(
                onPressed: _navigateToCreateSession,
                icon: const Icon(Icons.access_time),
                label: const Text('Record Session'),
              ),
            ),
          const SizedBox(height: 16),

          // Sessions List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SessionList(
                bookId: widget.bookId,
                onEmptyActionTap: _navigateToCreateSession,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateSession() =>
      AppRoutes.toSessionCreate(context, widget.bookId);

  Future<void> _handleDelete() async {
    final confirmed = await showDeleteConfirmationDialog(
      context: context,
      title: 'Confirm Deletion',
      message:
          'Are you sure you want to delete this book? This action cannot be undone.',
    );

    if (!confirmed || !mounted) return;

    setState(() => _isDeleting = true);

    try {
      final notifier = ref.read(
        bookDetailNotifierProvider(widget.bookId).notifier,
      );
      await notifier.deleteBook();
      await ref.read(bookListNotifierProvider.notifier).refreshBooks();

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete book: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }
}
