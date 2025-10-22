import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormDate extends StatelessWidget {
  final SessionFormNotifier notifier;
  final DateTime sessionDate;

  const SessionFormDate(this.notifier, this.sessionDate, {super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sessionDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      notifier.updateSessionDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${sessionDate.day}/${sessionDate.month}/${sessionDate.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelField('Session Date'),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.today),
              onPressed: () => _selectDate(context),
            ),

            if (formattedDate.isNotEmpty) Text(formattedDate),

            // Today Button
            ElevatedButton(
              onPressed: () => notifier.today(),
              child: const Text('Today'),
            ),

            // Yesterday Button
            ElevatedButton(
              onPressed: () => notifier.yesterday(),
              child: const Text('Yesterday'),
            ),
          ],
        ),
      ],
    );
  }
}
