import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookList extends ConsumerWidget {
  final ProviderBase<AsyncValue<List<BookEntity>>> bookListProvider;

  const BookList(this.bookListProvider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListAsync = ref.watch(bookListProvider);

    return bookListAsync.when(
      loading: () => BookListLoading(),
      error: (err, stack) => Center(child: Text('An error occurred: $err')),
      data: (books) {
        // Empty
        if (books.isEmpty) {
          return BookListEmpty();
        }

        // Data
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: books.length + 1,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (context, index) => const SizedBox(width: 16.0),
          itemBuilder: (context, index) {
            if (index == books.length) {
              return BookListEmptyItem();
            }
            return BookListItem(books[index]);
          },
        );
      },
    );
  }
}
