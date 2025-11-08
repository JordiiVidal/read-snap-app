import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/providers/book_list_selectors_provider.dart';
import 'package:read_snap/features/book/presentation/widgets/book_search_delegate.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';
import 'package:read_snap/shared/widgets/selectors/selectors.dart';

class BookFormCreate extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const BookFormCreate(this.formKey, {super.key});

  @override
  ConsumerState<BookFormCreate> createState() => _BookFormCreateState();
}

class _BookFormCreateState extends ConsumerState<BookFormCreate> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _pagesController;
  late final BookCreateNotifier _initialNotifier;

  @override
  void initState() {
    super.initState();
    _initialNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final initialDraft = _initialNotifier.currentBookDraft;

    _titleController = TextEditingController(text: initialDraft.title);
    _authorController = TextEditingController(text: initialDraft.author);
    _pagesController = TextEditingController(
      text: initialDraft.totalPages.toString(),
    );
  }

  @override
  void didUpdateWidget(covariant BookFormCreate oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newBookState = ref.read(bookCreateNotifierProvider).value!;

    if (_titleController.text != newBookState.title) {
      _titleController.text = newBookState.title;
    }
    if (_authorController.text != newBookState.author) {
      _authorController.text = newBookState.author;
    }

    final newPagesString = newBookState.totalPages > 0
        ? newBookState.totalPages.toString()
        : '';
    if (_pagesController.text != newPagesString) {
      _pagesController.text = newPagesString;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(
    BuildContext context,
    WidgetRef ref,
    String initialQuery,
  ) async {
    final allBooksAsync = ref.read(allBooksProvider);
    final Set<String> existingExternalIds =
        allBooksAsync.valueOrNull
            ?.map((book) => book.externalId ?? '')
            .toSet() ??
        {};
    final BookEntity? selectedBook = await showSearch<BookEntity?>(
      context: context,
      delegate: BookSearchDelegate(initialQuery, existingExternalIds),
    );

    if (selectedBook != null) {
      ref
          .read(bookCreateNotifierProvider.notifier)
          .updateFromSearch(selectedBook);
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  Widget _buildIncrementButton({
    required IconData icon,
    required bool isIncrement,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      onLongPress: () {
        if (context.mounted) {
          FocusScope.of(context).unfocus();
        }
        final currentValue = int.tryParse(_pagesController.text) ?? 0;
        final increment = isIncrement ? 10 : -10;
        final newValue = (currentValue + increment).clamp(0, 9999);
        _pagesController.text = newValue.toString();
        ref
            .read(bookCreateNotifierProvider.notifier)
            .updateTotalPages(newValue);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookCreateAsync = ref.watch(bookCreateNotifierProvider);
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final BookEntity bookState = bookCreateAsync.value!;

    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Select Button Group
          SelectButtonGroup(
            label: 'Status',
            required: true,
            options: {
              BookStatus.reading.name: 'Reading',
              BookStatus.completed.name: 'Completed',
              BookStatus.toRead.name: 'To Read',
            },
            selectedValues: [bookState.status.name],
            onSelectionChanged: (values) {
              final statusName = values.first;
              final status = BookStatus.values.byName(statusName);
              bookCreateNotifier.updateStatus(status);
            },
          ),

          // Title Field
          FormDynamicField(
            label: 'Title',
            hintText: 'Enter book title',
            controller: _titleController,
            required: true,
            onChanged: bookCreateNotifier.updateTitle,
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  _handleSearch(context, ref, _titleController.text),
            ),
          ),

          // Author Field
          FormDynamicField(
            label: 'Author',
            hintText: 'Enter author name',
            controller: _authorController,
            required: true,
            onChanged: bookCreateNotifier.updateAuthor,
          ),

          // Total Pages Field
          FormDynamicField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            controller: _pagesController,
            required: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              bookCreateNotifier.updateTotalPages(pages);
            },
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIncrementButton(
                  icon: Icons.remove,
                  isIncrement: false,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    final currentValue =
                        int.tryParse(_pagesController.text) ?? 0;
                    if (currentValue > 0) {
                      final newValue = currentValue - 1;
                      _pagesController.text = newValue.toString();
                      bookCreateNotifier.updateTotalPages(newValue);
                    }
                  },
                ),
                const SizedBox(width: 4),
                _buildIncrementButton(
                  icon: Icons.add,
                  isIncrement: true,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    final currentValue =
                        int.tryParse(_pagesController.text) ?? 0;
                    final newValue = currentValue + 1;
                    _pagesController.text = newValue.toString();
                    bookCreateNotifier.updateTotalPages(newValue);
                  },
                ),
              ],
            ),
          ),

          // Language Selector
          FormLabelField('Language', marginBottom: 0),
          SelectorLangauge((language) {
            bookCreateNotifier.updateLanguage(language);
          }, selectedLanguage: bookState.language),
        ],
      ),
    );
  }
}
