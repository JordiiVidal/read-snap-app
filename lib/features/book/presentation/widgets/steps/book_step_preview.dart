import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/widgets/steps/ui/book_step_header.dart';

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
        BookStepHeader(
          title: 'Preview',
          subtitle: 'Review the book details before submitting',
        ),

        Spacer(),

        SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onSubmit, child: Text('Submit')),
        ),
      ],
    );
  }
}
