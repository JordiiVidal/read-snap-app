import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/shared/widgets/custom_card.dart';

class BookCardProgress extends StatelessWidget {
  final BookEntity book;

  const BookCardProgress(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Progress', style: theme.textTheme.titleSmall),
          const Icon(Icons.timeline_sharp, size: 16),
        ],
      ),
      footer: Text(
        '${book.currentPage} / ${book.totalPages} pages',
        style: theme.textTheme.bodySmall,
      ),
      children: [
        Text(
          '${book.progressPercentage}%',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: book.progressValue,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
          backgroundColor: Colors.grey.withValues(alpha: 0.2),
        ),
      ],
    );
  }
}
