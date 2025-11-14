import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/providers/book_list_selectors_provider.dart';
import 'package:read_snap/features/book/presentation/widgets/search/book_search_delegate.dart';
import 'package:read_snap/features/book/presentation/widgets/forms/book_basic_form.dart';
import 'package:read_snap/features/book/presentation/widgets/steps/ui/book_step_header.dart';

class BookStepSearch extends ConsumerWidget {
  final VoidCallback onNext;

  const BookStepSearch({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // HEADER
        BookStepHeader(
          title: 'Add a new Book',
          subtitle: 'Find a book or enter the details manually',
          icon: Icons.book,
          alignment: CrossAxisAlignment.center,
        ),

        const SizedBox(height: 30),
        // Actions
        FilledButton.icon(
          onPressed: () => _handleSearch(context, ref),
          icon: const Icon(Icons.search),
          label: const Text('Search for a book'),
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () => _showBasicFormDialog(context, ref),
          icon: const Icon(Icons.edit),
          label: const Text('Add manually'),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> _showBasicFormDialog(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(modalContext).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BookBasicForm(({
              required title,
              required author,
              required context,
            }) {
              final data = {'title': title, 'author': author};
              Navigator.of(context).pop(data);
            }),
          ),
        ),
      ),
    );

    if (result != null) {
      final notifier = ref.read(bookCreateNotifierProvider.notifier);

      notifier.updateTitle(result['title']!);
      notifier.updateAuthor(result['author']!);

      onNext();
    }
  }

  Future<void> _handleSearch(BuildContext context, WidgetRef ref) async {
    final allBooksAsync = ref.read(allBooksProvider);
    final Set<String> existingExternalIds =
        allBooksAsync.valueOrNull
            ?.map((book) => book.externalId ?? '')
            .toSet() ??
        {};

    final selectedBook = await showSearch<BookEntity?>(
      context: context,
      delegate: BookSearchDelegate('', existingExternalIds),
    );

    if (selectedBook != null && context.mounted) {
      ref
          .read(bookCreateNotifierProvider.notifier)
          .updateFromSearch(selectedBook);

      onNext();
    }
  }
}
