import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/form/form_label_field.dart';

class FormDynamicField extends StatelessWidget {
  final String? label;
  final bool required;
  final String hintText;
  final String? initialValue;
  final String? suffixText;
  final TextEditingController? controller;
  final bool disabled;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const FormDynamicField({
    this.label,
    required this.hintText,
    this.required = false,
    this.keyboardType = TextInputType.text,
    this.disabled = false,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.suffixText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) FormLabelField(label!),
        TextFormField(
          enabled: !disabled,
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            suffixText: suffixText,
            suffixStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
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
