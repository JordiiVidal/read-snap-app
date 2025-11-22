import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool enabled;

  const DatePickerField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onDateSelected,
    required this.firstDate,
    required this.lastDate,
    this.enabled = true,
    super.key,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
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
              color: widget.enabled 
                  ? Theme.of(context).colorScheme.primary 
                  : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
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
