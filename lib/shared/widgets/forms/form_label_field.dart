import 'package:flutter/material.dart';

class FormLabelField extends StatelessWidget {
  final String label;
  final double marginBottom;

  const FormLabelField(this.label, {this.marginBottom = 8, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
