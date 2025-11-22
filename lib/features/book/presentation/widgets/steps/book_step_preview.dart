import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/config/theme/theme.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/book_cover.dart';
import 'package:read_snap/features/language/domain/domain.dart';
import 'package:read_snap/shared/widgets/steps/steps.dart';

class BookStepPreview extends ConsumerWidget {
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const BookStepPreview({
    super.key,
    required this.onBack,
    required this.onSubmit,
  });

  static const double _sectionSpacing = 24.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookCreateNotifierProvider).value!;
    final theme = Theme.of(context);

    return Column(
      spacing: _sectionSpacing,
      children: [
        // Header
        const HeaderStep(
          title: 'Preview',
          subtitle: 'Review the book details before submitting',
        ),

        // Form
        ContentStep.scrollable(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Book cover and title section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  // Book cover image
                  BookCover.medium(imageUrl: book.imageThumbnail),

                  // Title and author
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          book.title,
                          style: theme.textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
              ),

              const SizedBox(height: 24),

              // Details card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status
                    _buildDetailRow(
                      context,
                      label: 'Status',
                      value: _buildStatusBadge(context, book.status),
                    ),

                    _buildSeparator(context),

                    // Total Pages
                    _buildDetailRow(
                      context,
                      label: 'Total Pages',
                      value: Text(
                        book.totalPages.toString(),
                        style: theme.textTheme.labelLarge,
                      ),
                    ),

                    _buildSeparator(context),

                    // Language
                    _buildDetailRow(
                      context,
                      label: 'Language',
                      value: _buildLanguageWithFlag(book.language),
                    ),

                    _buildSeparator(context),

                    // Book Type
                    _buildDetailRow(
                      context,
                      label: 'Type',
                      value: Text(
                        BookUtils.getBookTypeName(book.type),
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Categories section
              _buildCategoriesSection(context, book),
            ],
          ),
        ),

        // Footer
        FooterStep(onAction: onSubmit, label: 'Ready'),
      ],
    );
  }

  Widget _buildSeparator(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Center(
        child: Container(
          height: 1,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required Widget value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        value,
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, BookStatus status) {
    final theme = Theme.of(context);
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case BookStatus.toRead:
        backgroundColor = theme.colorScheme.primary.withValues(alpha: 0.15);
        textColor = theme.colorScheme.primary;
        label = BookUtils.getBookStatusName(BookStatus.toRead);
        break;
      case BookStatus.reading:
        backgroundColor = AppColors.warning.withValues(alpha: 0.15);
        textColor = AppColors.warning;
        label = BookUtils.getBookStatusName(BookStatus.reading);
        break;
      case BookStatus.completed:
        backgroundColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        label = BookUtils.getBookStatusName(BookStatus.completed);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: textColor),
      ),
    );
  }

  Widget _buildLanguageWithFlag(String languageCode) {
    return Text(LanguageUtils.getLanguageFlag(languageCode));
  }

  Widget _buildCategoriesSection(BuildContext context, BookEntity book) {
    final theme = Theme.of(context);

    if (book.categories.isEmpty) {
      return Text(
        'No categories selected',
        style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: book.categories.map((category) {
        return Chip(
          label: Text(category),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        );
      }).toList(),
    );
  }
}
