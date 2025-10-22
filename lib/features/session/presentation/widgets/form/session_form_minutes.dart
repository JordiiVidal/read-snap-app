import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormMinutes extends StatelessWidget {
  final SessionFormNotifier notifier;
  final TextEditingController minutesController;

  const SessionFormMinutes(this.notifier, this.minutesController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelField('Minutes Read'),
        Row(
          spacing: 8,
          children: [
            // Minutes Read Field
            Expanded(
              child: FormDynamicField(
                hintText: 'Enter duration in minutes',
                controller: minutesController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final minutes = int.tryParse(value) ?? 0;
                  notifier.updateMinutesRead(minutes);
                },
              ),
            ),

            // 30 min
            ElevatedButton(
              onPressed: () => notifier.updateMinutesRead(30),
              child: const Text('30 min'),
            ),

            // 1 h
            ElevatedButton(
              onPressed: () => notifier.updateMinutesRead(60),
              child: const Text('1h'),
            ),
          ],
        ),
      ],
    );
  }
}
