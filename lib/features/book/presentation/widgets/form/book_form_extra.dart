import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookFormExtra extends StatelessWidget {
  final BookFormNotifier notifier;

  const BookFormExtra(this.notifier, {super.key});

  void _handleFinish(BuildContext context) {
    try {
      // TODO: Implement validation
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is ArgumentError ? e.message! : 'Error desconocido.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookState = notifier.currentBookDraft;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        const Text(
          'This book will be added as completed.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'You can optionally pick a start / finish date to keep your reading history accurate',
          style: TextStyle(fontSize: 14, color: Colors.black45),
        ),
        const SizedBox(height: 20),

        // Current Page
        if (bookState.status == BookStatus.reading) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8,
            children: [
              Expanded(
                child: FormDynamicField(
                  label: 'Current Page',
                  hintText: 'Enter current page',
                  initialValue: '0',
                  keyboardType: TextInputType.number,
                  suffixText: '/${bookState.totalPages}',
                  onChanged: (value) {
                    final pages = int.tryParse(value) ?? 0;
                    notifier.updateCurrentPage(pages);
                  },
                ),
              ),
              ActionChip(
                label: Text('First'),
                onPressed: () {
                  notifier.updateCurrentPage(1);
                },
              ),
              ActionChip(
                label: Text('Middle'),
                onPressed: () {
                  notifier.updateCurrentPage(bookState.totalPages ~/ 2);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],

        // Start Date
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 8,
          children: [
            Expanded(
              child: FormDynamicField(
                label: 'Start Date',
                hintText: 'Enter start date',
                disabled: bookState.status == BookStatus.toRead,
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  final date = DateTime.parse(value);
                  notifier.updateStartedAt(date);
                },
              ),
            ),
            ActionChip(
              label: Text('Now'),
              onPressed: () {
                final now = DateTime.now();
                notifier.updateStartedAt(now);
              },
            ),
            ActionChip(
              label: Text('Yesterday'),
              onPressed: () {
                final yesterday = DateTime.now().subtract(
                  const Duration(days: 1),
                );
                notifier.updateStartedAt(yesterday);
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        // End Date
        if (bookState.status == BookStatus.completed) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8,
            children: [
              Expanded(
                child: FormDynamicField(
                  label: 'End Date',
                  hintText: 'Enter end date',
                  disabled: bookState.status != BookStatus.completed,
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    final date = DateTime.parse(value);
                    notifier.updateFinishedAt(date);
                  },
                ),
              ),
              ActionChip(
                label: Text('Now'),
                onPressed: () {
                  final now = DateTime.now();
                  notifier.updateFinishedAt(now);
                },
              ),
              ActionChip(
                label: Text('Yesterday'),
                onPressed: () {
                  final yesterday = DateTime.now().subtract(
                    const Duration(days: 1),
                  );
                  notifier.updateFinishedAt(yesterday);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],

        // Submit Button
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 140,
            child: FormSubmit('Confirm', () => _handleFinish(context)),
          ),
        ),
      ],
    );
  }
}
