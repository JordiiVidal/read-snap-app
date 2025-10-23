import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({super.key});

  void _navigateToCreate(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookFormPage()));
  }

  void _navigateToDetails(String bookId, BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BookDetailPage(bookId)));
  }

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
      body: SizedBox(
        height: 350,
        child: bookListState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('An error occurred: $err')),
          data: (books) {
            if (books.isEmpty) {
              return Center(
                child: ListView(
                  children: [
                    EmptyState(
                      title: 'No books yet',
                      message:
                          'Start tracking your reading by adding your first book',
                      buttonText: 'Add Book',
                      onPressed: () => _navigateToCreate(context),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final book = books[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: BookCard(
                    book,
                    onTap: (bookId) => _navigateToDetails(bookId, context),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
