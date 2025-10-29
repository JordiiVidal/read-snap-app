import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';

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
      spacing: 15,
      children: [
        FormDynamicField(
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
          spacing: 15,
          children: [
            // 30 min
            Expanded(
              child: ElevatedButton(
                onPressed: () => onMinutesChanged(30),
                child: const Text('30 min'),
              ),
            ),

            // 1 h
            Expanded(
              child: ElevatedButton(
                onPressed: () => onMinutesChanged(60),
                child: const Text('1h'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
