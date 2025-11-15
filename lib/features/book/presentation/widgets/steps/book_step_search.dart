import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/config/app_colors.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/providers/book_list_selectors_provider.dart';
import 'package:read_snap/features/book/presentation/widgets/modals/book_basic_modal.dart';
import 'package:read_snap/features/book/presentation/widgets/search/book_search_delegate.dart';
import 'package:read_snap/shared/widgets/wizard/wizard.dart';

class BookStepSearch extends ConsumerWidget {
  final VoidCallback onNext;

  static const double _headerSpacing = 30.0;
  static const double _buttonSpacing = 20.0;

  const BookStepSearch({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        const StepHeaderWizard(
          title: 'Add a new Book',
          subtitle: 'Find a book or enter the details manually',
          icon: Icons.book,
          iconSemanticLabel: 'Book icon',
          alignment: StepHeaderAlignment.center,
        ),
        const SizedBox(height: _headerSpacing),

        // Search for a book
        _SearchButton(onPressed: () => _handleSearch(context, ref)),
        const SizedBox(height: _buttonSpacing),

        // Add manually
        _ManualEntryButton(onPressed: () => _showBasicFormDialog(context, ref)),
      ],
    );
  }

  Future<void> _showBasicFormDialog(BuildContext context, WidgetRef ref) async {
    try {
      final result = await BookBasicModal.show(context);

      if (!context.mounted) return;

      if (result != null) {
        final title = result['title'];
        final author = result['author'];

        if (title == null || author == null) {
          _showErrorSnackBar(context, 'Invalid book data received');
          return;
        }

        final notifier = ref.read(bookCreateNotifierProvider.notifier);
        notifier.updateTitle(title);
        notifier.updateAuthor(author);

        onNext();
      }
    } catch (e) {
      if (!context.mounted) return;
      _showErrorSnackBar(context, 'Failed to add book: ${e.toString()}');
    }
  }

  Future<void> _handleSearch(BuildContext context, WidgetRef ref) async {
    try {
      final allBooksAsync = ref.read(allBooksProvider);
      final existingExternalIds =
          allBooksAsync.valueOrNull
              ?.where((book) => book.googleExternalId != null)
              .map((book) => book.googleExternalId!)
              .toSet() ??
          <String>{};

      final selectedBook = await showSearch<BookEntity?>(
        context: context,
        delegate: BookSearchDelegate('', existingExternalIds),
      );

      if (!context.mounted) return;

      if (selectedBook != null) {
        ref
            .read(bookCreateNotifierProvider.notifier)
            .updateFromSearch(selectedBook);

        onNext();
      }
    } catch (e) {
      if (!context.mounted) return;
      _showErrorSnackBar(context, 'Search failed: ${e.toString()}');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SearchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.search),
      label: const Center(child: Text('Search for a book')),
    );
  }
}

class _ManualEntryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ManualEntryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: const Icon(Icons.edit),
      label: const Center(child: Text('Add manually')),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
