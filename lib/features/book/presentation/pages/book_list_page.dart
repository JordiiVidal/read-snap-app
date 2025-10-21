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
    final bookListNotifier = ref.read(bookListNotifierProvider.notifier);

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
      body: RefreshIndicator(
        onRefresh: bookListNotifier.refreshBooks,
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
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return BookCard(
                  book,
                  onTap: (bookId) => _navigateToDetails(bookId, context),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
