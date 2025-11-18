import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/book_status_selector.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';
import 'package:read_snap/shared/widgets/steps/steps.dart';

class BookStepStatus extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const BookStepStatus({super.key, required this.onNext, required this.onBack});

  @override
  ConsumerState<BookStepStatus> createState() => _BookStepStatusState();
}

class _BookStepStatusState extends ConsumerState<BookStepStatus> {
  static const double _fieldSpacing = 20.0;
  static const String _dateFormatPattern = 'dd/MM/yyyy';

  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat(_dateFormatPattern);

  late TextEditingController _pagesController;
  late TextEditingController _currentPageController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
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
    final book = ref.watch(bookCreateNotifierProvider).value!;
    final bookNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final isCompleted = book.status == BookStatus.completed;
    final isReading = book.status == BookStatus.reading;

    return Column(
      children: [
        // Header
        const HeaderStep(
          title: 'Status',
          subtitle:
              'Provide the reading status and some additional information',
        ),

        // Form
        ContentStep.scrollable(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: _fieldSpacing,
              children: [
                // Status Select Button Group
                BookStatusSelector(
                  selectedStatus: book.status,
                  onStatusChanged: bookNotifier.updateStatus,
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
                    onValueChanged: bookNotifier.updateTotalPages,
                  ),
                ),

                if (isReading)
                  DynamicFormField(
                    label: 'Current Page',
                    hintText: 'Enter current page',
                    controller: _currentPageController,
                    keyboardType: TextInputType.number,
                    suffixIcon: NumberControlsFormField(
                      controller: _currentPageController,
                      maxValue: book.totalPages,
                      onValueChanged: bookNotifier.updateCurrentPage,
                    ),
                  ),

                // Start Date Field
                if (isReading || isCompleted)
                  DatePickerField(
                    label: 'Start Date',
                    hintText: 'Select start date',
                    controller: _startDateController,
                    onDateSelected: (date) {
                      _startDateController.text = _dateFormat.format(date);
                      bookNotifier.updateStartedAt(date);
                    },
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  ),

                // End Date Field
                if (isCompleted)
                  DatePickerField(
                    label: 'End Date',
                    hintText: 'Select end date',
                    controller: _endDateController,
                    enabled: book.startedAt != null,
                    onDateSelected: (date) {
                      _endDateController.text = _dateFormat.format(date);
                      bookNotifier.updateFinishedAt(date);
                    },
                    firstDate: book.startedAt ?? DateTime(2000),
                    lastDate: DateTime.now(),
                  ),
              ],
            ),
          ),
        ),

        // Footer
        FooterStep(onAction: _handleNext, label: 'Next'),
      ],
    );
  }

  void _initializeControllers() {
    final draft = ref.read(bookCreateNotifierProvider).valueOrNull;

    if (draft == null) {
      _pagesController = TextEditingController();
      _currentPageController = TextEditingController();
      _startDateController = TextEditingController();
      _endDateController = TextEditingController();
      return;
    }

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

  void _handleNext() {
    if (_formKey.currentState?.validate() ?? false) {
      final book = ref.read(bookCreateNotifierProvider).value!;
      final error = BookStatusValidatorService.validateBookStatus(book);

      if (error != null) {
        _showErrorSnackBar(error);
        return;
      }

      widget.onNext();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
