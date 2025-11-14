import 'package:flutter/material.dart';

class BodyWizard extends StatelessWidget {
  final Widget child;
  const BodyWizard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(child: child),
            ),
          );
        },
      ),
    );
  }
}
