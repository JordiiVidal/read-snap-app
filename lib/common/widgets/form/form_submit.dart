import 'package:flutter/material.dart';

class FormSubmit extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const FormSubmit(
    this.label,
    this.onPressed, {
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    return FilledButton(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
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
