import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;

  const BookCard(this.book, {super.key});

  double get progressPercentage {
    if (book.totalPages == 0 || book.currentPage == null) return 0.0;
    return (book.currentPage! / book.totalPages).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Color(int.parse(book.color.replaceFirst('#', '0xFF')));

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    book.name.isNotEmpty ? book.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        book.author,
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Progress', style: TextStyle(color: Colors.grey)),
                Text('${book.currentPage ?? 0}/${book.totalPages}'),
              ],
            ),
            LinearProgressIndicator(
              value: progressPercentage,
              color: accentColor,
              backgroundColor: accentColor.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  book.status.name.toUpperCase(),
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${(progressPercentage * 100).round()}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
