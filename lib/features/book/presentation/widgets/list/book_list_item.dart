import 'package:flutter/material.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListItem extends StatelessWidget {
  final BookEntity book;

  const BookListItem(this.book, {super.key});

  void _navigateToDetails(String bookId, BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BookDetailPage(bookId)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetails(book.id, context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16),
        decoration: BoxDecoration(
          color: book.flutterColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          border: Border(left: BorderSide(color: book.flutterColor, width: 20)),
        ),
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
                  '${book.progressPercentage}%',
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
              value: book.progressValue,
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
