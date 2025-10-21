import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/notifiers/session_stats_notifier.dart';

class SessionReadingTimeCard extends ConsumerWidget {
  final String bookId;

  const SessionReadingTimeCard(this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionCountAsync = ref.watch(sessionCountProvider(bookId));
    final totalTimeAsync = ref.watch(totalTimeProvider(bookId));

    return totalTimeAsync.when(
      loading: () => const SkeletonCard(),
      error: (e, st) => const Text('Error'),
      data: (totalMinutes) {
        final formattedTime = formatMinutesToTime(totalMinutes);
        final sessionCount = sessionCountAsync.when(
          data: (count) => count,
          loading: () => 0,
          error: (e, st) => 0,
        );

        return CustomCard(
          header: const Text('Readings Time'),
          footer: Text('$sessionCount sessions.'),
          children: [
            SizedBox(
              width: double.infinity,
              child: TimeDisplay(timeParts: formattedTime),
            ),
          ],
        );
      },
    );
  }
}
