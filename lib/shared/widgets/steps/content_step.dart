import 'package:flutter/material.dart';

class ContentStep extends StatelessWidget {
  final Widget child;
  final bool scrollable;

  const ContentStep._({
    super.key,
    required this.child,
    required this.scrollable,
  });

  const ContentStep.centered({Key? key, required Widget child})
    : this._(key: key, child: child, scrollable: false);

  const ContentStep.scrollable({Key? key, required Widget child})
    : this._(key: key, child: child, scrollable: true);

  @override
  Widget build(BuildContext context) {
    return scrollable
        ? Expanded(child: SingleChildScrollView(child: child))
        : Center(child: child);
  }
}
