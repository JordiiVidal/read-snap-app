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
      spacing: 15,
      children: [
        FormDynamicField(
          label: 'Session Date',
          hintText: 'Enter session date',
          controller: TextEditingController(text: formattedDate),
          keyboardType: TextInputType.datetime,
          prefixIcon: Icons.calendar_today,
          onPrefixPressed: () => _selectDate(context),
          onChanged: (value) {
            final date = DateTime.parse(value);
            notifier.updateSessionDate(date);
          },
        ),
        Row(
          spacing: 15,
          children: [
            // Today Button
            Expanded(
              child: ElevatedButton(
                onPressed: () => notifier.today(),
                child: const Text('Today'),
              ),
            ),

            // Yesterday Button
            Expanded(
              child: ElevatedButton(
                onPressed: () => notifier.yesterday(),
                child: const Text('Yesterday'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
