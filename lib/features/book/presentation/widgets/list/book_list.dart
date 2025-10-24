import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookList extends ConsumerWidget {
  final ProviderBase<AsyncValue<List<BookEntity>>> statusProvider;

  const BookList(this.statusProvider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListState = ref.watch(statusProvider);

    return bookListState.when(
      loading: () => BookListSkeleton(),
      error: (err, stack) => Center(child: Text('An error occurred: $err')),
      data: (books) {
        // Empty
        if (books.isEmpty) {
          return BookListEmpty();
        }

        // Data
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length + 1,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            // Empty
            if (index == books.length) {
              return BookListEmptyItem();
            }

            // Book Card
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: BookListItem(books[index]),
            );
          },
        );
      },
    );
  }
}
