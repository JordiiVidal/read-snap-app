import 'dart:async';

import 'package:flutter/material.dart';

class NumberControlsFormField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<int> onValueChanged;
  final int minValue;
  final int maxValue;
  final int step;
  final int longPressStep;
  final int initialRepeatDelay;
  final int minRepeatDelay;
  final FocusNode? focusNode;

  const NumberControlsFormField({
    super.key,
    required this.controller,
    required this.onValueChanged,
    this.focusNode,
    this.minValue = 0,
    this.maxValue = 9999,
    this.step = 1,
    this.longPressStep = 1,
    this.initialRepeatDelay = 150,
    this.minRepeatDelay = 50,
  });

  @override
  State<NumberControlsFormField> createState() =>
      _NumberControlsFormFieldState();
}

class _NumberControlsFormFieldState extends State<NumberControlsFormField> {
  Timer? _repeatTimer;
  int _currentRepeatDelay = 0;

  @override
  void dispose() {
    _cancelRepeat();
    super.dispose();
  }

  int get _currentValue =>
      int.tryParse(widget.controller.text) ?? widget.minValue;

  void _updateValue(int newValue) {
    final clampedValue = newValue.clamp(widget.minValue, widget.maxValue);
    widget.controller.text = clampedValue.toString();
    widget.onValueChanged(clampedValue);
  }

  void _handleFocus() {
    if (!mounted) return;

    if (widget.focusNode != null) {
      widget.focusNode!.requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void _stepValue(int delta) {
    if (!mounted) return;
    _handleFocus();
    _updateValue(_currentValue + delta);
  }

  void _startRepeat(int delta) {
    if (!mounted) return;
    _handleFocus();
    _currentRepeatDelay = widget.initialRepeatDelay;

    _stepValue(delta);

    _repeatTimer = Timer.periodic(Duration(milliseconds: _currentRepeatDelay), (
      timer,
    ) {
      if (!mounted) {
        _cancelRepeat();
        return;
      }

      _stepValue(delta);

      if (_currentRepeatDelay > widget.minRepeatDelay) {
        _currentRepeatDelay = (_currentRepeatDelay * 0.85).round();
        _cancelRepeat();
        _startRepeat(delta); // Reiniciar con nuevo delay
      }
    });
  }

  void _cancelRepeat() {
    _repeatTimer?.cancel();
    _repeatTimer = null;
  }

  Widget _buildControlButton({required IconData icon, required int delta}) {
    return GestureDetector(
      onTap: () => _stepValue(delta),
      onLongPressStart: (_) => _startRepeat(delta),
      onLongPressEnd: (_) => _cancelRepeat(),
      onLongPressCancel: _cancelRepeat,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlButton(icon: Icons.remove, delta: -widget.longPressStep),
        _buildControlButton(icon: Icons.add, delta: widget.longPressStep),
      ],
    );
  }
}
