import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookCardProgress extends StatelessWidget {
  final BookEntity book;

  const BookCardProgress(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Progress'),
          Icon(Icons.timeline_sharp, size: 14),
        ],
      ),
      footer: Text('${book.currentPage} / ${book.totalPages} pages'),
      children: [
        Text(
          '${book.progressPercentage}%',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
