import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookList extends ConsumerWidget {
  const BookList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListAsync = ref.watch(readingBooksProvider);
    final limitStatusAsync = ref.watch(readingLimitStatusProvider);

    return bookListAsync.when(
      loading: () => BookListLoading(),
      error: (err, stack) => Center(child: Text('An error occurred: $err')),
      data: (books) {
        final isMaxedOut = limitStatusAsync.value?.isMaxedOut ?? false;
        final itemCount = books.length + (isMaxedOut ? 0 : 1);

        // Empty
        if (books.isEmpty) {
          return BookListEmpty();
        }

        // Data
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (context, index) => const SizedBox(width: 16.0),
          itemBuilder: (context, index) {
            if (index == books.length && !isMaxedOut) {
              return BookListEmptyItem();
            }
            return BookListItem(books[index]);
          },
        );
      },
    );
  }
}
