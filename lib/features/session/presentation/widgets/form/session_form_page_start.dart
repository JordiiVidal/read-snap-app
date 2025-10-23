import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormPageStart extends StatelessWidget {
  final SessionFormNotifier notifier;
  final TextEditingController startPageController;

  const SessionFormPageStart(
    this.notifier,
    this.startPageController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Label
            FormLabelField('Start Page'),

            // Action Button
            TextButton(
              onPressed: () {
                notifier.restart();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 10,
                children: [Icon(Icons.refresh), Text('Restart Book')],
              ),
            ),
          ],
        ),

        // Start Page Field
        FormDynamicField(
          hintText: 'Enter start page',
          disabled: true,
          controller: startPageController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final pages = int.tryParse(value) ?? 0;
            notifier.updateStartPage(pages);
          },
        ),
      ],
    );
  }
}
