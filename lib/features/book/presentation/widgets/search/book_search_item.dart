import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/widgets/book_cover.dart';
import 'package:read_snap/features/language/domain/domain.dart';

class BookSearchItem extends StatelessWidget {
  final BookEntity book;
  final bool isAlreadyAdded;
  final VoidCallback? onTap;

  const BookSearchItem({
    super.key,
    required this.book,
    required this.isAlreadyAdded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isAlreadyAdded ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAlreadyAdded ? Colors.grey.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isAlreadyAdded ? Colors.grey.shade200 : Colors.grey.shade100,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            BookCover.small(imageUrl: book.imageThumbnail),
            const SizedBox(width: 16),

            // Book Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Author
                  Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Pages and Language
                  _buildMetadata(context),

                  // Already Added Badge
                  if (isAlreadyAdded) ...[
                    const SizedBox(height: 8),
                    _buildAlreadyAddedBadge(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    final hasPages = book.totalPages > 0;
    final hasLanguage = book.language.isNotEmpty;

    if (!hasPages && !hasLanguage) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (hasPages) ...[
          Text(
            '${book.totalPages} pages',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          if (hasLanguage) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text('•', style: TextStyle(color: Colors.grey.shade400)),
            ),
          ],
        ],
        if (hasLanguage)
          Text(
            LanguageUtils.getLanguageName(book.language),
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
      ],
    );
  }

  Widget _buildAlreadyAddedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 14, color: Colors.green.shade700),
          const SizedBox(width: 4),
          Text(
            'Already Added',
            style: TextStyle(
              color: Colors.green.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
