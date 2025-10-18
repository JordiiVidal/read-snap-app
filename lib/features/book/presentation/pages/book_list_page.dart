import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListState = ref.watch(bookListNotifierProvider);

    void navigateToCreate() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const BookFormPage()));
    }

    void navigateToDetails(String bookId) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => BookDetailPage(bookId)));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadSnap'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Book',
            onPressed: navigateToCreate,
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
                onPressed: navigateToCreate,
              ),
            );
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return InkWell(
                onTap: () => navigateToDetails(book.id),
                child: BookCard(book),
              );
            },
          );
        },
      ),
    );
  }
}
