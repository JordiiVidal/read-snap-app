import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/session/presentation/notifiers/session_stats_notifier.dart';
import 'package:read_snap/shared/utils/utils.dart';
import 'package:read_snap/shared/widgets/cards/card_stat.dart';
import 'package:read_snap/shared/widgets/display/display.dart';
import 'package:read_snap/shared/widgets/loading/loading.dart';

class SessionCardReading extends ConsumerWidget {
  final String bookId;

  const SessionCardReading(this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionCountAsync = ref.watch(sessionCountProvider(bookId));
    final totalTimeAsync = ref.watch(totalTimeProvider(bookId));

    return totalTimeAsync.when(
      loading: () => const LoadingCard(),
      error: (e, st) => const Text('Error'),
      data: (totalMinutes) {
        final formattedTime = formatMinutesToTime(totalMinutes);
        final sessionCount = sessionCountAsync.when(
          data: (count) => count,
          loading: () => 0,
          error: (e, st) => 0,
        );

        return CardStat(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Readings Time'),
              Icon(Icons.timelapse_outlined, size: 14),
            ],
          ),
          footer: Text('$sessionCount sessions.'),
          children: [
            SizedBox(width: double.infinity, child: DisplayTime(formattedTime)),
          ],
        );
      },
    );
  }
}
