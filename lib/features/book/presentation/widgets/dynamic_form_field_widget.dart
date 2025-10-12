import 'package:flutter/material.dart';

class DynamicFormField extends StatelessWidget {
  final String label;
  final bool required;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const DynamicFormField({
    required this.label,
    required this.hintText,
    this.required = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (required && (value == null || value.isEmpty)) {
              return '$label is required.';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
