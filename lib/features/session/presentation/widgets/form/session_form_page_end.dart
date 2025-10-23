import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormPageEnd extends StatelessWidget {
  final SessionFormNotifier notifier;
  final TextEditingController endPageController;
  final int totalPages;

  const SessionFormPageEnd(
    this.notifier,
    this.endPageController,
    this.totalPages, {
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
            FormLabelField('End Page'),

            // Action Button
            TextButton(
              onPressed: () {
                notifier.markAsFinished();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 10,
                children: [Icon(Icons.check), Text('Finish Book')],
              ),
            ),
          ],
        ),

        // End Page Field
        FormDynamicField(
          hintText: 'Enter end page',
          suffixText: '/ $totalPages',
          controller: endPageController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final pages = int.tryParse(value) ?? 0;
            notifier.updateEndPage(pages);
          },
        ),
      ],
    );
  }
}
