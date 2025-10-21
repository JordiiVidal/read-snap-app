import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/notifiers/session_stats_notifier.dart';

class ReadingTimeCard extends ConsumerWidget {
  final String bookId;

  const ReadingTimeCard(this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionCountAsync = ref.watch(sessionCountProvider(bookId));
    final totalTimeAsync = ref.watch(totalTimeProvider(bookId));

    return totalTimeAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => const Text('Error'),
      data: (totalMinutes) {
        final formattedTime = formatMinutesToTime(totalMinutes);
        final sessionCount = sessionCountAsync.when(
          data: (count) => count,
          loading: () => 0,
          error: (e, st) => 0,
        );

        return InfoCard(
          header: 'Readings Time',
          title: formattedTime,
          content: const Text('Total reading time recorded.'),
          footer: '$sessionCount sessions.',
        );
      },
    );
  }
}
