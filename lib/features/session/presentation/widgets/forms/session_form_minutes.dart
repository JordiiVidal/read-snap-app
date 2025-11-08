import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

class SessionFormMinutes extends StatelessWidget {
  final TextEditingController minutesController;
  final Function(int) onMinutesChanged;

  const SessionFormMinutes(
    this.minutesController,
    this.onMinutesChanged, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        DynamicFormField(
          label: 'Minutes Read',
          hintText: 'Enter duration in minutes',
          controller: minutesController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final minutes = int.tryParse(value) ?? 0;
            onMinutesChanged(minutes);
          },
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 15 min
            ActionChip(
              onPressed: () => onMinutesChanged(15),
              label: const Text('15 min'),
            ),

            // 30 min
            ActionChip(
              onPressed: () => onMinutesChanged(30),
              label: const Text('30 min'),
            ),

            // 45 min
            ActionChip(
              onPressed: () => onMinutesChanged(45),
              label: const Text('45 min'),
            ),

            // 1 h
            ActionChip(
              onPressed: () => onMinutesChanged(60),
              label: const Text('1h'),
            ),
          ],
        ),
      ],
    );
  }
}
