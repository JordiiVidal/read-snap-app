import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';

class SessionFormDate extends StatelessWidget {
  final TextEditingController dateController;
  final Function(DateTime) onDateChanged;

  const SessionFormDate(this.dateController, this.onDateChanged, {super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        FormDynamicField(
          label: 'Session Date',
          hintText: 'Enter session date',
          controller: dateController,
          keyboardType: TextInputType.datetime,
          prefixIcon: Icons.calendar_today,
          onPrefixPressed: () => _selectDate(context),
          onChanged: (value) {
            final date = DateTime.parse(value);
            onDateChanged(date);
          },
        ),
        Row(
          spacing: 15,
          children: [
            // Today Button
            Expanded(
              child: ElevatedButton(
                onPressed: () => onDateChanged(DateTime.now()),
                child: const Text('Today'),
              ),
            ),

            // Yesterday Button
            Expanded(
              child: ElevatedButton(
                onPressed: () => onDateChanged(
                  DateTime.now().subtract(const Duration(days: 1)),
                ),
                child: const Text('Yesterday'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
