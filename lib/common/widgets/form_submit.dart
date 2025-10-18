import 'package:flutter/material.dart';

class FormSubmit extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const FormSubmit(this.label, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
