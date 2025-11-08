import 'package:flutter/material.dart';

class SubmitForm extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const SubmitForm(
    this.label,
    this.onPressed, {
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    return FilledButton(
      onPressed: effectiveOnPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.0,
              ),
            )
          : Text(label),
    );
  }
}
