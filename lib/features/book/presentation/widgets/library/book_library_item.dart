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
    return ListTile(
      onTap: () => _navigateToDetails(context),
      leading: Icon(Icons.book, size: 24),
      title: Text(
        book.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        book.author,
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
