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
      spacing: 5,
      children: [
        FormDynamicField(
          label: 'Session Date',
          hintText: 'Enter session date',
          controller: dateController,
          keyboardType: TextInputType.datetime,
          prefixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          onChanged: (value) {
            final date = DateTime.parse(value);
            onDateChanged(date);
          },
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Today Action
            ActionChip(
              onPressed: () => onDateChanged(DateTime.now()),
              label: const Text('Today'),
            ),

            // Yesterday Action
            ActionChip(
              onPressed: () => onDateChanged(
                DateTime.now().subtract(const Duration(days: 1)),
              ),
              label: const Text('Yesterday'),
            ),
          ],
        ),
      ],
    );
  }
}
