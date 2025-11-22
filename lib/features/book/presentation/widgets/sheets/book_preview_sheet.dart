import 'package:flutter/material.dart';
import 'package:read_snap/config/app_colors.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/widgets/book_cover.dart';

class BookPreviewSheet extends StatelessWidget {
  final BookEntity book;
  final VoidCallback onConfirm;

  const BookPreviewSheet({
    super.key,
    required this.book,
    required this.onConfirm,
  });

  static Future<bool?> show(BuildContext context, BookEntity book) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BookPreviewSheet(
        book: book,
        onConfirm: () => Navigator.pop(context, true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Cover Image
              if (book.imageThumbnail != null)
                BookCover.large(imageUrl: book.imageThumbnail),
              const SizedBox(height: 16),

              // Title
              Text(
                book.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Author
              Text(
                book.author,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FilledButton.tonal(
                      onPressed: () => Navigator.pop(context, false),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: FilledButton(
                      onPressed: onConfirm,
                      child: const Text('Use this Book'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
