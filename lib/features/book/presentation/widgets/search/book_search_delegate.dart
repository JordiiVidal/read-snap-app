import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/providers/book_search_provider.dart';
import 'package:read_snap/features/book/presentation/widgets/sheets/book_preview_sheet.dart';
import 'package:read_snap/features/book/presentation/widgets/search/book_search_item.dart';

class BookSearchDelegate extends SearchDelegate<BookEntity?> {
  final String initialQuery;
  final Set<String> existingExternalIds;
  final ProviderContainer _providerContainer;
  bool _hasInitialized = false;

  BookSearchDelegate(
    this.initialQuery,
    this.existingExternalIds,
    this._providerContainer,
  );

  @override
  void dispose() {
    _providerContainer.invalidate(bookSearchProvider);
    super.dispose();
  }

  void _initializeQuery() {
    if (!_hasInitialized && initialQuery.isNotEmpty) {
      super.query = initialQuery;
      _hasInitialized = true;
    }
  }

  bool _isBookAlreadyAdded(BookEntity book) {
    return book.googleExternalId != null &&
        existingExternalIds.contains(book.googleExternalId!);
  }

  void _showBookPreview(BuildContext context, BookEntity book) async {
    final result = await BookPreviewSheet.show(context, book);

    if (result == true && context.mounted) {
      close(context, book);
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(elevation: 0),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search by title, author, or ISBN.';

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    _initializeQuery();

    if (query.isEmpty) {
      return _buildEmptyState(context);
    }

    return Consumer(
      builder: (context, ref, child) {
        final searchAsync = ref.watch(bookSearchProvider(query.trim()));

        return searchAsync.when(
          data: (books) {
            if (books.isEmpty) {
              return _buildNoResultsState(context);
            }

            return ListView.builder(
              key: ValueKey(query),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isAlreadyAdded = _isBookAlreadyAdded(book);

                return BookSearchItem(
                  book: book,
                  isAlreadyAdded: isAlreadyAdded,
                  onTap: () => _showBookPreview(context, book),
                );
              },
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (error, stack) => _buildErrorState(context, error),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _initializeQuery();

    if (query.trim().isEmpty) {
      return _buildEmptyState(context);
    }

    return buildResults(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search,
                size: 56,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Find Your Next Read',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Start typing to search for books by title,\nauthor, or ISBN.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object? error) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Error searching books', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text('No results found', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
