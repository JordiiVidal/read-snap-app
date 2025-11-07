import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';

final readingBooksProvider = Provider<AsyncValue<List<BookEntity>>>((ref) {
  return ref
      .watch(bookListNotifierProvider)
      .when(
        loading: () => const AsyncValue.loading(),
        error: (e, st) => AsyncValue.error(e, st),
        data: (allBooks) {
          final filtered = allBooks
              .where((b) => b.status == BookStatus.reading)
              .toList();
          return AsyncValue.data(filtered);
        },
      );
});

final notReadingProvider = Provider<AsyncValue<List<BookEntity>>>((ref) {
  return ref
      .watch(bookListNotifierProvider)
      .when(
        loading: () => const AsyncValue.loading(),
        error: (e, st) => AsyncValue.error(e, st),
        data: (allBooks) {
          final filtered = allBooks
              .where((b) => b.status != BookStatus.reading)
              .toList();
          return AsyncValue.data(filtered);
        },
      );
});

final allBooksProvider = Provider<AsyncValue<List<BookEntity>>>((ref) {
  return ref.watch(
    bookListNotifierProvider,
  ); // Devuelve el AsyncValue original sin filtrar
});
