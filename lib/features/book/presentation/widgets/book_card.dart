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
    final accentColor = Color(int.parse(book.color.replaceFirst('#', '0xFF')));

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      color: Colors.white30,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap?.call(book.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image, Title and Author
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

              // Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Progress', style: TextStyle(color: Colors.grey)),
                  Text(
                    '${book.currentPage}/${book.totalPages}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progressPercentage,
                minHeight: 6,
                borderRadius: BorderRadius.circular(5),
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                color: accentColor,
              ),
              const SizedBox(height: 8),

              // Status and Progress Percentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.status.name.capitalize(),
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${(progressPercentage * 100).round()}%'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
