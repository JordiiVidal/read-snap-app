import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

class DynamicFormField extends StatelessWidget {
  final String? label;
  final bool required;
  final String hintText;
  final String? initialValue;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool disabled;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? suffixText;
  final Widget? suffixIcon;
  final double borderRadius;

  const DynamicFormField({
    this.label,
    required this.hintText,
    this.required = false,
    this.keyboardType = TextInputType.text,
    this.disabled = false,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.prefixIcon,
    this.suffixText,
    this.suffixIcon,
    this.borderRadius = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) LabelFormField(label!),
        TextFormField(
          enabled: !disabled,
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14),

          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: prefixIcon,
            suffixText: suffixText,
            suffixIcon: suffixIcon,
            suffixStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
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
