import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookUpdateFormExtra extends ConsumerStatefulWidget {
  final BookEntity book;

  const BookUpdateFormExtra(this.book, {super.key});

  @override
  ConsumerState<BookUpdateFormExtra> createState() =>
      _BookUpdateFormExtraState();
}

class _BookUpdateFormExtraState extends ConsumerState<BookUpdateFormExtra> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late final TextEditingController _currentPageController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final BookUpdateNotifier _initialNotifier;

  @override
  void initState() {
    super.initState();
    _initialNotifier = ref.read(
      bookUpdateNotifierProvider(widget.book).notifier,
    );
    final initialDraft = _initialNotifier.currentBookDraft;

    _currentPageController = TextEditingController(
      text: initialDraft.currentPage.toString(),
    );
    _startDateController = TextEditingController(
      text: initialDraft.startedAt != null
          ? _dateFormat.format(initialDraft.startedAt!)
          : '',
    );
    _endDateController = TextEditingController(
      text: initialDraft.finishedAt != null
          ? _dateFormat.format(initialDraft.finishedAt!)
          : '',
    );
  }

  @override
  void dispose() {
    _currentPageController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _handleQuickAction(
    TextEditingController controller,
    String newValue,
    void Function() updateNotifier,
  ) {
    updateNotifier();

    controller.value = controller.value.copyWith(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookAsync = ref.watch(bookUpdateNotifierProvider(widget.book));
    final BookEntity bookState = bookAsync.value ?? widget.book;
    final updateNotifier = ref.read(
      bookUpdateNotifierProvider(widget.book).notifier,
    );

    final isCompleted = bookState.status == BookStatus.completed;
    final mediaQuery = MediaQuery.of(context);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          32,
          16,
          mediaQuery.padding.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 20),

            // Current Page Field
            if (!isCompleted) ...[
              FormDynamicField(
                label: 'Current Page',
                hintText: 'Enter current page',
                controller: _currentPageController,
                keyboardType: TextInputType.number,
                suffixText: '/${widget.book.totalPages}',
                onChanged: (value) {
                  final pages = int.tryParse(value) ?? 0;
                  updateNotifier.updateCurrentPage(pages);
                },
              ),
              SizedBox(height: 5),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  ActionChip(
                    label: Text('First'),
                    onPressed: () {
                      final newValue = '1';
                      _handleQuickAction(
                        _currentPageController,
                        newValue,
                        () => updateNotifier.updateCurrentPage(1),
                      );
                    },
                  ),
                  ActionChip(
                    label: Text('Middle'),
                    onPressed: () {
                      final pages = widget.book.totalPages ~/ 2;
                      final newValue = pages.toString();
                      _handleQuickAction(
                        _currentPageController,
                        newValue,
                        () => updateNotifier.updateCurrentPage(pages),
                      );
                    },
                  ),
                ],
              ),
            ],

            // Start Date Field
            FormDynamicField(
              label: 'Start Date',
              hintText: 'Enter start date',
              keyboardType: TextInputType.datetime,
              controller: _startDateController,
              prefixIcon: Icons.calendar_today,
              onPrefixPressed: () =>
                  _selectDate(context, updateNotifier.updateStartedAt),
              onChanged: (value) {
                final date = DateTime.parse(value);
                updateNotifier.updateStartedAt(date);
              },
            ),
            SizedBox(height: 5),

            // Actions
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionChip(
                  label: Text('Today'),
                  onPressed: () {
                    final now = DateTime.now();
                    final newValue = _dateFormat.format(now);
                    _handleQuickAction(
                      _startDateController,
                      newValue,
                      () => updateNotifier.updateStartedAt(now),
                    );
                  },
                ),
                ActionChip(
                  label: Text('Yesterday'),
                  onPressed: () {
                    final yesterday = DateTime.now().subtract(
                      const Duration(days: 1),
                    );
                    final newValue = _dateFormat.format(yesterday);
                    _handleQuickAction(
                      _startDateController,
                      newValue,
                      () => updateNotifier.updateStartedAt(yesterday),
                    );
                  },
                ),
              ],
            ),

            // End Date Field
            if (isCompleted) ...[
              FormDynamicField(
                label: 'End Date',
                hintText: 'Enter end date',
                keyboardType: TextInputType.datetime,
                controller: _endDateController,
                prefixIcon: Icons.calendar_today,
                onPrefixPressed: () =>
                    _selectDate(context, updateNotifier.updateFinishedAt),
                onChanged: (value) {
                  final date = DateTime.parse(value);
                  updateNotifier.updateFinishedAt(date);
                },
              ),
              SizedBox(height: 5),

              // Actions
              Row(
                spacing: 10,
                children: [
                  ActionChip(
                    label: Text('Now'),
                    onPressed: () {
                      final now = DateTime.now();
                      final newValue = _dateFormat.format(now);
                      _handleQuickAction(
                        _endDateController,
                        newValue,
                        () => updateNotifier.updateFinishedAt(now),
                      );
                    },
                  ),
                  ActionChip(
                    label: Text('Yesterday'),
                    onPressed: () {
                      final yesterday = DateTime.now().subtract(
                        const Duration(days: 1),
                      );
                      final newValue = _dateFormat.format(yesterday);
                      _handleQuickAction(
                        _endDateController,
                        newValue,
                        () => updateNotifier.updateFinishedAt(yesterday),
                      );
                    },
                  ),
                ],
              ),
            ],

            // Submit Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: FormSubmit(
                'Confirm',
                () => _handleConfirm(updateNotifier),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleConfirm(BookUpdateNotifier notifier) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await notifier.updateBook();

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e is ArgumentError ? e.message! : 'Error desconocido al guardar.',
          ),
        ),
      );
    }
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
