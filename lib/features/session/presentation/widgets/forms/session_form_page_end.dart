import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

class SessionFormPageEnd extends StatelessWidget {
  final TextEditingController endPageController;
  final Function(String) onPageChanged;
  final int totalPages;

  const SessionFormPageEnd(
    this.endPageController,
    this.totalPages,
    this.onPageChanged, {
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
                onPageChanged(totalPages.toString());
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
          onChanged: onPageChanged,
        ),
      ],
    );
  }
}
