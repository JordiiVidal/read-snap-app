import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookLibraryItem extends StatelessWidget {
  final BookEntity book;

  const BookLibraryItem(this.book, {super.key});

  void _navigateToDetails(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => BookDetailPage(book.id)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetails(context),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              book.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            // Author
            Text(
              book.author,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
