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
    final theme = Theme.of(context);
    return InkWell(
      onTap: isAlreadyAdded ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAlreadyAdded 
              ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
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
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Author
                  Text(
                    book.author,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Pages and Language
                  _buildMetadata(context),

                  // Already Added Badge
                  if (isAlreadyAdded) ...[
                    const SizedBox(height: 8),
                    _buildAlreadyAddedBadge(context),
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
    final theme = Theme.of(context);
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
            style: theme.textTheme.bodySmall,
          ),
          if (hasLanguage) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '•',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ],
        if (hasLanguage)
          Text(
            LanguageUtils.getLanguageName(book.language),
            style: theme.textTheme.bodySmall,
          ),
      ],
    );
  }

  Widget _buildAlreadyAddedBadge(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 14,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(width: 4),
          Text(
            'Already Added',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
