import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_detail_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/book_header.dart';

class BookDetailPage extends ConsumerWidget {
  final String bookId;

  const BookDetailPage(this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));
    final notifier = ref.read(bookDetailNotifierProvider(bookId).notifier);

    Future<void> confirmDelete(BuildContext context) async {
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

      if (confirm == true) {
        await notifier.deleteBook();
        await ref.read(bookListNotifierProvider.notifier).refreshBooks();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }

    return bookAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error loading book: $e')),
      ),
      data: (book) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookHeader(book: book),
              actions(confirmDelete, context),
              cards(book),
            ],
          ),
        ),
      ),
    );
  }

  Widget cards(BookEntity book) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            // Progress Card
            InfoCard(
              header: 'Progress',
              title: ((book.currentPage ?? 0) / book.totalPages).toString(),
              content: LinearProgressIndicator(
                value: (book.currentPage ?? 0) / book.totalPages,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(int.parse(book.color.replaceFirst('#', '0xFF'))),
                ),
              ),
              footer: '${book.currentPage ?? 0} / ${book.totalPages} pages',
            ),

            // Reading Time Card
            const InfoCard(
              header: 'Reading Time',
              title: '0 minutes',
              content: Text('---'),
              footer: '0 minutes',
            ),

            // Status Card
            InfoCard(
              header: 'Status',
              title: book.status.name.toUpperCase(),
              content: Text(book.status.name.toUpperCase()),
              footer: 'Started 13/10/2025',
            ),
          ],
        ),
      ),
    );
  }

  Widget actions(
    Future<void> Function(BuildContext context) confirmDelete,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionButton(
          icon: Icons.access_time,
          label: 'Record Session',
          onPressed: () {},
        ),
        ActionButton(
          icon: Icons.delete_outline,
          label: 'Delete Book',
          color: Colors.red,
          onPressed: () => confirmDelete(context),
        ),
      ],
    );
  }
}
