import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';

final totalTimeProvider = FutureProvider.family<int, String>((
  ref,
  bookId,
) async {
  final useCase = ref.watch(getTotalReadingTimeUseCaseProvider);
  return useCase.call(bookId);
});

final sessionCountProvider = FutureProvider.family<int, String>((
  ref,
  bookId,
) async {
  final useCase = ref.watch(getSessionsByBookUseCaseProvider);
  final sessions = await useCase.call(bookId);
  return sessions.length;
});
