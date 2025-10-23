import 'package:flutter/material.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookCard extends StatelessWidget {
  final BookEntity book;
  final void Function(String)? onTap;

  const BookCard(this.book, {super.key, this.onTap});

  double get progressPercentage {
    if (book.totalPages == 0) return 0.0;
    return (book.currentPage / book.totalPages).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final bookBaseColor = Color(
      int.parse(book.color.replaceFirst('#', '0xFF')),
    );

    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16),
      decoration: BoxDecoration(
        color: bookBaseColor.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
        border: Border(left: BorderSide(color: bookBaseColor, width: 20)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap?.call(book.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status
            Align(
              alignment: Alignment.topRight,
              child: Text(
                book.status.name.capitalize(),
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              book.name,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Author
            Text(
              book.author,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 18),

            const Spacer(),

            // Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(progressPercentage * 100).round()}%',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  '${book.currentPage}/${book.totalPages}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Progress Bar
            LinearProgressIndicator(
              value: progressPercentage,
              minHeight: 8,
              borderRadius: BorderRadius.circular(5),
              backgroundColor: Colors.white24,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
