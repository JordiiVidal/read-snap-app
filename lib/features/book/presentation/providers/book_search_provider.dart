import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

final bookSearchProvider = FutureProvider.family<List<BookEntity>, String>((
  ref,
  query,
) async {
  if (query.trim().isEmpty) {
    return [];
  }

  await Future.delayed(const Duration(milliseconds: 500));

  if (ref.state.isRefreshing) {
    return ref.state.value ?? [];
  }

  final repository = ref.read(bookSearchRepositoryProvider);
  return await repository.searchBooks(query);
});
