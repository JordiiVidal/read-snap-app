import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/providers/reading_limit_status_provider.dart';

class ReadingLimitCounter extends ConsumerWidget {
  final TextStyle? textStyle;

  const ReadingLimitCounter({super.key, this.textStyle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(readingLimitStatusProvider);

    return statusAsync.when(
      loading: () => const Text('/', style: TextStyle(fontSize: 14)),
      error: (e, st) =>
          const Text('Error', style: TextStyle(color: Colors.red)),
      data: (status) {
        return Text(
          status.displayString,
          style:
              textStyle ??
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        );
      },
    );
  }
}
