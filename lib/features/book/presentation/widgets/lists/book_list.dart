import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/widgets/lists/book_list_item.dart';

class BookList extends ConsumerWidget {
  final ProviderListenable<AsyncValue<List<BookEntity>>> booksProvider;
  final Axis scrollDirection;
  final BookListItemVariant itemVariant;
  final void Function(BookEntity book)? onBookTap;
  final VoidCallback? onAddTap;
  final bool showAddButton;

  const BookList({
    super.key,
    required this.booksProvider,
    this.scrollDirection = Axis.vertical,
    this.itemVariant = BookListItemVariant.card,
    this.onBookTap,
    this.onAddTap,
    this.showAddButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);

    return booksAsync.when(
      loading: () => _buildLoading(context),
      error: (err, stack) => _buildError(context, err),
      data: (books) =>
          books.isEmpty ? _buildEmpty(context) : _buildList(context, books),
    );
  }

  // ========== Loading State ==========
  Widget _buildLoading(BuildContext context) {
    if (scrollDirection == Axis.horizontal) {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (_, _) => const SizedBox(width: 16),
          itemBuilder: (ctx, _) => _buildLoadingSkeleton(ctx),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (ctx, _) => _buildLoadingSkeleton(ctx),
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    if (itemVariant == BookListItemVariant.card) {
      return Container(
        width: 200,
        height: 180,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey.shade300),
      title: Container(
        height: 16,
        width: double.infinity,
        color: Colors.grey.shade300,
      ),
      subtitle: Container(height: 12, width: 100, color: Colors.grey.shade300),
    );
  }

  // ========== Empty State ==========
  Widget _buildEmpty(BuildContext context) {
    if (scrollDirection == Axis.horizontal) {
      return SizedBox(
        height: 200,
        child: Center(child: _AddBookButton(onTap: onAddTap)),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.book_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No books found',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  // ========== Error State ==========
  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading books',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ========== Data State ==========
  Widget _buildList(BuildContext context, List<BookEntity> books) {
    final itemCount = books.length + (showAddButton ? 1 : 0);

    if (scrollDirection == Axis.horizontal) {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (_, _) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            if (index == books.length && showAddButton) {
              return _AddBookButton(onTap: onAddTap);
            }
            return BookListItem(
              book: books[index],
              variant: itemVariant,
              onTap: onBookTap != null ? () => onBookTap!(books[index]) : null,
            );
          },
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: BookListItem(
            book: books[index],
            variant: itemVariant,
            onTap: onBookTap != null ? () => onBookTap!(books[index]) : null,
          ),
        );
      },
    );
  }
}

// ========== Add Button Component ==========
class _AddBookButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _AddBookButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 140,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400, width: 2),
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Icon(Icons.add, color: Colors.grey.shade600, size: 32),
        ),
      ),
    );
  }
}
