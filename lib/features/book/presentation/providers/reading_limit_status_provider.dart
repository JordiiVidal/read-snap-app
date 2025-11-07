import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class ReadingLimitStatus {
  final int count;
  final int limit;

  ReadingLimitStatus(this.count)
    : limit = CheckReadingLimitUseCase.maxReadingBooks;

  String get displayString => '$count/$limit';
  bool get isMaxedOut => count >= limit;
}

final readingLimitStatusProvider = Provider<AsyncValue<ReadingLimitStatus>>((
  ref,
) {
  final booksAsync = ref.watch(readingBooksProvider);

  return booksAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (books) {
      final status = ReadingLimitStatus(books.length);
      return AsyncValue.data(status);
    },
  );
});
