import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';

class BookHeader extends StatelessWidget {
  final BookEntity book;

  const BookHeader(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.network(
            book.imageThumbnail!,
            fit: BoxFit.cover,
            width: 60,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 40);
            },
          ),
        ),
        const SizedBox(width: 12),

        // Title and Author
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                book.author,
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
