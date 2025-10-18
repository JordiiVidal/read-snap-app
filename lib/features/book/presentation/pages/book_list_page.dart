import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListState = ref.watch(bookListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadSnap'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Book',
            onPressed: () => _navigateToCreate(context),
          ),
        ],
      ),
      body: bookListState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('An error occurred: $err')),
        data: (books) {
          if (books.isEmpty) {
            return Center(
              child: EmptyState(
                title: 'No books yet',
                message:
                    'Start tracking your reading by adding your first book',
                buttonText: 'Add Book',
                onPressed: () => _navigateToCreate(context),
              ),
            );
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return InkWell(
                onTap: () => _navigateToDetails(context, book.id),
                child: BookCard(book),
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToCreate(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookFormPage()));
  }

  void _navigateToDetails(BuildContext context, String bookId) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BookDetailPage(bookId)));
  }
}
