import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookHeader extends StatelessWidget {
  final BookEntity book;

  const BookHeader(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Image
        Container(
          width: 50,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(int.parse(book.color.replaceFirst('#', '0xFF'))),
          ),
        ),
        const SizedBox(width: 12),

        //Title and Author
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(book.author, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
