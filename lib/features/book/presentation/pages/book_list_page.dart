import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/book/presentation/pages/book_form_page.dart';
import 'package:read_snap/features/book/presentation/pages/book_page.dart';
import 'package:read_snap/features/book/presentation/widgets/book_card_widget.dart';
import 'package:read_snap/features/book/presentation/widgets/empty_state_widget.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({super.key});

  void _navigateToCreate(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookFormPage()));
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookPage()));
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
      body: bookListState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('An error occurred: $err')),
        data: (books) {
          if (books.isEmpty) {
            return EmptyStateWidget(
              onPressed: () => _navigateToCreate(context),
            );
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return InkWell(
                onTap: () => _navigateToDetails(context),
                child: BookCardWidget(book: book),
              );
            },
          );
        },
      ),
    );
  }
}
