import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/book_status_selector.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

class BookStepStatus extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const BookStepStatus({super.key, required this.onNext, required this.onBack});
  @override
  ConsumerState<BookStepStatus> createState() => _BookStepStatusState();
}

class _BookStepStatusState extends ConsumerState<BookStepStatus> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late TextEditingController _pagesController;
  late TextEditingController _currentPageController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(bookCreateNotifierProvider).value!;
    _pagesController = TextEditingController(
      text: draft.totalPages > 0 ? draft.totalPages.toString() : '',
    );
    _currentPageController = TextEditingController(
      text: draft.currentPage.toString(),
    );
    _startDateController = TextEditingController(
      text: draft.startedAt != null ? _dateFormat.format(draft.startedAt!) : '',
    );
    _endDateController = TextEditingController(
      text: draft.finishedAt != null
          ? _dateFormat.format(draft.finishedAt!)
          : '',
    );
  }

  @override
  void dispose() {
    _pagesController.dispose();
    _currentPageController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookCreateNotifierProvider).value!;
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final isCompleted = bookState.status == BookStatus.completed;
    final isReading = bookState.status == BookStatus.reading;

    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        children: [
          Text('Details'),
          Text('Provide the reading status and some additional information'),

          // Status Select Button Group
          BookStatusSelector(
            selectedStatus: bookState.status,
            onStatusChanged: bookCreateNotifier.updateStatus,
          ),

          // Total Pages Field
          DynamicFormField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            required: true,
            keyboardType: TextInputType.number,
            controller: _pagesController,
            suffixIcon: NumberControlsFormField(
              controller: _pagesController,
              onValueChanged: bookCreateNotifier.updateTotalPages,
            ),
            readOnly: true,
          ),

          if (isReading)
            DynamicFormField(
              label: 'Current Page',
              hintText: 'Enter current page',
              controller: _currentPageController,
              keyboardType: TextInputType.number,
              suffixText: '/${bookState.totalPages}',
              suffixIcon: NumberControlsFormField(
                controller: _currentPageController,
                onValueChanged: bookCreateNotifier.updateCurrentPage,
              ),
              readOnly: true,
            ),

          if (isReading || isCompleted)
            DynamicFormField(
              label: 'Start Date',
              hintText: 'Enter start date',
              keyboardType: TextInputType.datetime,
              controller: _startDateController,
              prefixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () =>
                    _selectDate(context, bookCreateNotifier.updateStartedAt),
              ),
              onChanged: (value) {
                final date = DateTime.parse(value);
                bookCreateNotifier.updateStartedAt(date);
              },
            ),

          if (isCompleted)
            DynamicFormField(
              label: 'End Date',
              hintText: 'Enter end date',
              keyboardType: TextInputType.datetime,
              controller: _endDateController,
              prefixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () =>
                    _selectDate(context, bookCreateNotifier.updateFinishedAt),
              ),
              onChanged: (value) {
                final date = DateTime.parse(value);
                bookCreateNotifier.updateFinishedAt(date);
              },
            ),

          Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: widget.onNext, child: Text('Next')),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    Function(DateTime) onDateChanged,
  ) async {
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
}
