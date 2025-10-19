import 'package:flutter/material.dart';

class FormDynamicField extends StatelessWidget {
  final String label;
  final bool required;
  final String hintText;
  final String? initialValue;
  final bool disabled;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const FormDynamicField({
    required this.label,
    required this.hintText,
    this.required = false,
    this.keyboardType = TextInputType.text,
    this.disabled = false,
    this.onChanged,
    this.initialValue,
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
          enabled: !disabled,
          initialValue: initialValue,
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
      ],
    );
  }
}
