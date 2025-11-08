import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookSearchDelegate extends SearchDelegate<BookEntity?> {
  final String initialQuery;
  final Set<String> existingExternalIds;
  bool _hasInitialized = false;

  BookSearchDelegate(this.initialQuery, this.existingExternalIds) : super();

  void _initializeQuery() {
    if (!_hasInitialized && initialQuery.isNotEmpty) {
      super.query = initialQuery;
      _hasInitialized = true;
    }
  }

  bool _isBookAlreadyAdded(BookEntity book) {
    return book.externalId != null &&
        existingExternalIds.contains(book.externalId);
  }

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
      IconButton(
        icon: const Icon(Icons.clear),
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
      return const Center(
        child: Text('Introduce un título o autor para buscar.'),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final searchRepository = ref.read(bookSearchRepositoryProvider);
        return FutureBuilder<List<BookEntity>>(
          future: searchRepository.searchBooks(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error al buscar libros: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encontraron resultados.'));
            }

            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isAlreadyAdded = _isBookAlreadyAdded(book);

                Widget leadingWidget;

                if (book.imageThumbnail != null &&
                    book.imageThumbnail!.isNotEmpty) {
                  leadingWidget = ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      book.imageThumbnail!,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 40);
                      },
                    ),
                  );
                } else {
                  leadingWidget = const Icon(Icons.book, size: 40);
                }

                return ListTile(
                  enabled: !isAlreadyAdded,
                  leading: leadingWidget,
                  title: Text(book.title),
                  subtitle: Text(
                    book.author,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  trailing: isAlreadyAdded
                      ? Icon(Icons.check_circle, color: Colors.orange.shade700)
                      : null,
                  onTap: isAlreadyAdded
                      ? null
                      : () {
                          close(context, book);
                        },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _initializeQuery();

    if (query.isEmpty) {
      return const Center(child: Text('Busca por título, autor o ISBN.'));
    }

    return buildResults(context);
  }
}
