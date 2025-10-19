import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/dominio/entities/session_entity.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormBody extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final SessionEntity session;
  final SessionFormNotifier notifier;

  const SessionFormBody(this.formKey, this.session, this.notifier, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: session.sessionDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        notifier.updateSessionDate(picked);
      }
    }

    final formattedDate =
        '${session.sessionDate.day}/${session.sessionDate.month}/${session.sessionDate.year}';

    return Form(
      key: formKey,
      child: ListView(
        children: [
          // Start Page Field
          FormDynamicField(
            label: 'Start Page',
            hintText: 'Enter start page',
            disabled: true,
            initialValue: session.startPage.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateStartPage(pages);
            },
          ),
          const SizedBox(height: 20),

          // End Page Field
          FormDynamicField(
            label: 'End Page',
            hintText: 'Enter end page',
            initialValue: session.endPage.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateEndPage(pages);
            },
          ),
          const SizedBox(height: 20),

          // Minutes Read Field
          FormDynamicField(
            label: 'Minutes Read',
            hintText: 'Enter duration in minutes',
            initialValue: session.startPage.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final minutes = int.tryParse(value) ?? 0;
              notifier.updateMinutesRead(minutes);
            },
          ),
          const SizedBox(height: 20),

          // Session Date Selector
          Row(
            children: [
              const Text('Session Date:', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              TextButton.icon(
                onPressed: selectDate,
                icon: const Icon(Icons.calendar_today, size: 18),
                label: Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
