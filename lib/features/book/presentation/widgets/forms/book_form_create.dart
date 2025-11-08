import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/providers/book_list_selectors_provider.dart';
import 'package:read_snap/features/book/presentation/widgets/book_search_delegate.dart';
import 'package:read_snap/features/book/presentation/widgets/book_selector_category.dart';
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
  late FocusNode _pagesFocusNode;

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
    _pagesFocusNode = FocusNode();
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
    _pagesFocusNode.dispose();
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
          DynamicFormField(
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
          DynamicFormField(
            label: 'Author',
            hintText: 'Enter author name',
            controller: _authorController,
            required: true,
            onChanged: bookCreateNotifier.updateAuthor,
          ),

          // Total Pages Field
          DynamicFormField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            controller: _pagesController,
            focusNode: _pagesFocusNode,
            required: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              bookCreateNotifier.updateTotalPages(pages);
            },
            suffixIcon: NumberControlsFormField(
              controller: _pagesController,
              onValueChanged: bookCreateNotifier.updateTotalPages,
              focusNode: _pagesFocusNode,
            ),
            readOnly: true,
          ),

          // Language Selector
          LabelFormField('Language', marginBottom: 0),
          LangauageSelector((language) {
            FocusScope.of(context).unfocus();
            bookCreateNotifier.updateLanguage(language);
          }, selectedLanguage: bookState.language),

          // Categories Selector
          BookSelectorCategory(
            selectedCategories: bookState.categories,
            onCategoriesChanged: (categories) {
              FocusScope.of(context).unfocus();
              bookCreateNotifier.updateCategories(categories);
            },
          ),
        ],
      ),
    );
  }
}
