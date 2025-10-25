import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookLibrary extends ConsumerWidget {
  final ProviderBase<AsyncValue<List<BookEntity>>> statusProvider;

  const BookLibrary(this.statusProvider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookLibraryState = ref.watch(statusProvider);

    return bookLibraryState.when(
      loading: () => BookLibraryLoading(),
      error: (err, stack) => Center(child: Text('An error occurred: $err')),
      data: (books) {
        // Empty
        if (books.isEmpty) {
          return BookLibraryEmpty();
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: books.length + 1,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (ctx, i) {
            if (i == books.length) {
              return BookLibraryEmptyItem();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: BookLibraryItem(books[i]),
            );
          },
        );
      },
    );
  }
}
