import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookFormExtra extends StatelessWidget {
  final BookFormNotifier notifier;

  const BookFormExtra(this.notifier, {super.key});

  @override
  Widget build(BuildContext context) {
    final bookState = notifier.currentBookDraft;
    final isCompleted = bookState.status == BookStatus.completed;
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 32, 16, mediaQuery.padding.bottom + 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                'This book will be added as ${isCompleted ? 'completed' : 'reading'}.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'You can optionally pick a ${isCompleted ? 'start / finish' : 'current page / start'} date to keep your reading history accurate',
                style: TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ],
          ),

          // Current Page Field
          if (!isCompleted) ...[
            FormActionRow(
              inputField: FormDynamicField(
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
              quickActions: {
                'First': () {
                  notifier.updateCurrentPage(1);
                },
                'Middle': () {
                  notifier.updateCurrentPage(bookState.totalPages ~/ 2);
                },
              },
            ),
            // TODO: Add estimated time dedicated
          ],

          // Start Date Field
          FormActionRow(
            inputField: FormDynamicField(
              label: 'Start Date',
              hintText: 'Enter start date',
              keyboardType: TextInputType.datetime,
              onChanged: (value) {
                final date = DateTime.parse(value);
                notifier.updateStartedAt(date);
              },
            ),
            quickActions: {
              'Now': () {
                final now = DateTime.now();
                notifier.updateStartedAt(now);
              },
              'Yesterday': () {
                final yesterday = DateTime.now().subtract(
                  const Duration(days: 1),
                );
                notifier.updateStartedAt(yesterday);
              },
            },
          ),

          // End Date Field
          if (isCompleted)
            FormActionRow(
              inputField: FormDynamicField(
                label: 'End Date',
                hintText: 'Enter end date',
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  final date = DateTime.parse(value);
                  notifier.updateFinishedAt(date);
                },
              ),
              quickActions: {
                'Now': () {
                  final now = DateTime.now();
                  notifier.updateFinishedAt(now);
                },
                'Yesterday': () {
                  final yesterday = DateTime.now().subtract(
                    const Duration(days: 1),
                  );
                  notifier.updateFinishedAt(yesterday);
                },
              },
            ),

          // Submit Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            child: FormSubmit('Confirm', () => _handleConfirm(context)),
          ),
        ],
      ),
    );
  }

  void _handleConfirm(BuildContext context) {
    try {
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is ArgumentError ? e.message! : 'Error desconocido.'),
        ),
      );
    }
  }
}
