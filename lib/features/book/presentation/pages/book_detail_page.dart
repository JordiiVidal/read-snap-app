import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

final _isDeletingProvider = StateProvider.autoDispose<bool>((ref) => false);

class BookDetailPage extends ConsumerWidget {
  final String bookId;

  const BookDetailPage(this.bookId, {super.key});

  void _navigateToCreateSession(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => SessionCreatePage(bookId)));
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text(
          'Are you sure you want to delete this book? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (!context.mounted) return;

    if (confirm == true) {
      await _handleDelete(context, ref);
    }
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(bookDetailNotifierProvider(bookId).notifier);
    final isDeletingController = ref.read(_isDeletingProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);

    isDeletingController.state = true;

    try {
      await notifier.deleteBook();
      await ref.read(bookListNotifierProvider.notifier).refreshBooks();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Failed to delete book: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isDeletingController.state = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));
    final isDeleting = ref.watch(_isDeletingProvider);

    return bookAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      ),

      error: (e, st) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Error loading book: ${e.toString()}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),

      data: (book) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              onPressed: isDeleting ? null : () => _confirmDelete(context, ref),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            BookHeader(book),
            const SizedBox(height: 16),

            // Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(width: 16),
                  BookCardProgress(book),
                  SessionReadingTimeCard(bookId, book.flutterColor),
                  BookCardStatus(book),
                  SizedBox(width: 16),
                ],
              ),
            ),

            // Action Button
            if (book.status != BookStatus.completed)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: book.flutterColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _navigateToCreateSession(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 8),
                      Text('Record Session'),
                    ],
                  ),
                ),
              ),

            // Sessions List
            Expanded(
              child: SessionList(
                bookId,
                createAction: () => _navigateToCreateSession(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
