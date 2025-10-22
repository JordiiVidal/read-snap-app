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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 20,
      children: [
        // End Page Field
        Expanded(
          child: FormDynamicField(
            label: 'End Page',
            hintText: 'Enter end page',
            suffixText: '/ $totalPages',
            controller: endPageController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateEndPage(pages);
            },
          ),
        ),

        // Action Button
        ElevatedButton(
          onPressed: () {
            notifier.markAsFinished();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 10,
            children: [const Icon(Icons.check), const Text('Finish Book')],
          ),
        ),
      ],
    );
  }
}
