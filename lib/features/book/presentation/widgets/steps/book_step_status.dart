import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/config/app_colors.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/book_status_selector.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';
import 'package:read_snap/shared/widgets/wizard/wizard.dart';

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
    final bookState = ref.watch(bookCreateNotifierProvider).value!;
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final isCompleted = bookState.status == BookStatus.completed;
    final isReading = bookState.status == BookStatus.reading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: _fieldSpacing,
        children: [
          const StepHeaderWizard(
            title: 'Status',
            subtitle:
                'Provide the reading status and some additional information',
          ),

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
          ),

          if (isReading)
            DynamicFormField(
              label: 'Current Page',
              hintText: 'Enter current page',
              controller: _currentPageController,
              keyboardType: TextInputType.number,
              suffixIcon: NumberControlsFormField(
                controller: _currentPageController,
                maxValue: bookState.totalPages,
                onValueChanged: bookCreateNotifier.updateCurrentPage,
              ),
            ),

          // Start Date Field
          if (isReading || isCompleted)
            _DatePickerField(
              label: 'Start Date',
              hintText: 'Select start date',
              controller: _startDateController,
              onDateSelected: (date) {
                _startDateController.text = _dateFormat.format(date);
                bookCreateNotifier.updateStartedAt(date);
              },
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            ),

          // End Date Field
          if (isCompleted)
            _DatePickerField(
              label: 'End Date',
              hintText: 'Select end date',
              controller: _endDateController,
              enabled: bookState.startedAt != null,
              onDateSelected: (date) {
                _endDateController.text = _dateFormat.format(date);
                bookCreateNotifier.updateFinishedAt(date);
              },
              firstDate: bookState.startedAt ?? DateTime(2000),
              lastDate: DateTime.now(),
            ),

          const Spacer(),

          // Next Button
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: _handleNext, child: Text('Next')),
          ),
        ],
      ),
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
      final bookState = ref.read(bookCreateNotifierProvider).value!;
      final error = BookStatusValidatorService.validateBookStatus(bookState);

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

class _DatePickerField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool enabled;

  const _DatePickerField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onDateSelected,
    required this.firstDate,
    required this.lastDate,
    this.enabled = true,
  });

  @override
  State<_DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<_DatePickerField> {
  late FocusNode _focusNode;
  bool _isPickerOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (!widget.enabled || _isPickerOpen) return;
    _focusNode.requestFocus();
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    _openDatePicker();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AbsorbPointer(
        child: DynamicFormField(
          label: widget.label,
          hintText: widget.hintText,
          disabled: !widget.enabled,
          keyboardType: TextInputType.datetime,
          controller: widget.controller,
          readOnly: true,
          focusNode: _focusNode,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Icon(
              Icons.calendar_today,
              color: widget.enabled ? AppColors.primary : Colors.grey,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openDatePicker() async {
    if (!widget.enabled || _isPickerOpen) return;

    _isPickerOpen = true;

    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _getInitialDate(),
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
      );

      if (!mounted) return;

      if (picked != null) {
        widget.onDateSelected(picked);
      }

      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to select date: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        _isPickerOpen = false;
      }
    }
  }

  DateTime _getInitialDate() {
    if (widget.controller.text.isNotEmpty) {
      try {
        final format = DateFormat('dd/MM/yyyy');
        final parsed = format.parse(widget.controller.text);
        if (parsed.isAfter(
              widget.firstDate.subtract(const Duration(days: 1)),
            ) &&
            parsed.isBefore(widget.lastDate.add(const Duration(days: 1)))) {
          return parsed;
        }
      } catch (_) {
        // If parsing fails, use fallback
      }
    }

    final today = DateTime.now();
    if (today.isAfter(widget.firstDate.subtract(const Duration(days: 1))) &&
        today.isBefore(widget.lastDate.add(const Duration(days: 1)))) {
      return today;
    }
    return widget.firstDate;
  }
}
