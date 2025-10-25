import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/form/form_label_field.dart';

class FormDynamicField extends StatelessWidget {
  final String? label;
  final bool required;
  final String hintText;
  final String? initialValue;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final bool disabled;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onPrefixPressed;
  final String? suffixText;

  const FormDynamicField({
    this.label,
    required this.hintText,
    this.required = false,
    this.keyboardType = TextInputType.text,
    this.disabled = false,
    this.onChanged,
    this.onPrefixPressed,
    this.initialValue,
    this.controller,
    this.prefixIcon,
    this.suffixText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) FormLabelField(label!),
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
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
              prefixIcon: prefixIcon != null
                  ? GestureDetector(
                      onTap: onPrefixPressed,
                      child: Icon(prefixIcon),
                    )
                  : null,
              suffixText: suffixText,
              suffixStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFDDDDDD),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 1.2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
              ),
            ),

            validator: (value) {
              if (required && (value == null || value.isEmpty)) {
                return '$label is required.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
