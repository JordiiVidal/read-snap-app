import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookStepPreview extends ConsumerWidget {
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const BookStepPreview({
    super.key,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Preview'),
        Text('Review the book details before creating it'),
        Spacer(),

        SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onSubmit, child: Text('Submit')),
        ),
      ],
    );
  }
}
