import 'package:flutter/material.dart';

class FooterStep extends StatelessWidget {
  final VoidCallback onAction;
  final String label;

  const FooterStep({super.key, required this.onAction, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(onPressed: onAction, child: Text(label)),
    );
  }
}
