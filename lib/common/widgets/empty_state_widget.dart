import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onPressed;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.buttonText,
    this.onPressed,
  }) : assert(
         !((buttonText == null) ^ (onPressed == null)),
         'Both buttonText and onPressed must be provided together.',
       );

  @override
  Widget build(BuildContext context) {
    final showButton = buttonText != null && onPressed != null;
    final showIcon = icon != null;

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon
            if (showIcon) ...[
              Icon(icon, size: 64, color: Colors.grey),
              const SizedBox(height: 20),
            ],

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            // Button
            if (showButton) ...[
              const SizedBox(height: 20),
              ElevatedButton(onPressed: onPressed, child: Text(buttonText!)),
            ],
          ],
        ),
      ),
    );
  }
}
