import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';

class SessionFormPageStart extends StatelessWidget {
  final TextEditingController startPageController;
  final Function(String) onPageChanged;

  const SessionFormPageStart(
    this.startPageController,
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
            LabelFormField('Start Page'),

            // Action Button
            TextButton(
              onPressed: () {
                onPageChanged('0');
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
        DynamicFormField(
          hintText: 'Enter start page',
          disabled: true,
          controller: startPageController,
          keyboardType: TextInputType.number,
          onChanged: onPageChanged,
        ),
      ],
    );
  }
}
