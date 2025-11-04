import 'package:flutter/material.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListItem extends StatelessWidget {
  final BookEntity book;

  const BookListItem(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetail(book.id, context),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: book.flutterColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(4),
          border: Border(left: BorderSide(color: book.flutterColor, width: 10)),
          gradient: LinearGradient(
            colors: [Color(0xFF9A8CFF), Color(0xFF7B6DFF)],
          ),
          boxShadow: [
            BoxShadow(
              color: book.flutterColor.withValues(alpha: .2),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Text(
                  book.status.name.capitalize(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Title
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Author
            Text(
              book.author,
              style: const TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
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
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
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

  void _navigateToDetail(String bookId, BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BookDetailPage(bookId)));
  }
}
