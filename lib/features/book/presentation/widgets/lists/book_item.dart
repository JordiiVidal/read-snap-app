import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/presentation/extensions/book_ui_extensions.dart';
import 'package:read_snap/shared/utils/utils.dart';

enum BookListItemVariant { card, listTile }

class BookListItem extends StatelessWidget {
  final BookEntity book;
  final BookListItemVariant variant;
  final VoidCallback? onTap;

  const BookListItem({
    super.key,
    required this.book,
    this.variant = BookListItemVariant.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      BookListItemVariant.card => _buildCard(context),
      BookListItemVariant.listTile => _buildListTile(context),
    };
  }

  // ========== Card Variant (Horizontal) ==========
  Widget _buildCard(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border(left: BorderSide(color: book.flutterColor, width: 6)),
          gradient: LinearGradient(
            colors: [
              book.flutterColor.withValues(alpha: 0.8),
              book.flutterColor.withValues(alpha: 0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: book.flutterColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Text(
                  book.status.name.capitalize(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              book.title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Author
            Text(
              book.author,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            // Progress Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${book.progressPercentage}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '${book.currentPage}/${book.totalPages}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Progress Bar
            LinearProgressIndicator(
              value: book.progressValue,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
              backgroundColor: Colors.white24,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // ========== ListTile Variant (Vertical) ==========
  Widget _buildListTile(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: book.flutterColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.book, color: book.flutterColor),
      ),
      title: Text(
        book.title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        book.author,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontStyle: FontStyle.italic,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
