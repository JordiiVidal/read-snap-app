import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/providers/google_books_api_provider.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';

class BookSearchDelegate extends SearchDelegate<BookEntity?> {
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
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Introduce un título o autor para buscar.'),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final api = ref.watch(googleBooksApiProvider);
        return FutureBuilder<List<BookEntity>>(
          future: api.searchBooks(query),
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
                  leading: leadingWidget,
                  title: Text(book.title),
                  subtitle: Text(
                    book.author,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  onTap: () {
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
    if (query.isEmpty) {
      return const Center(child: Text('Busca por título, autor o ISBN.'));
    }

    // TODO LIVE SEARCH
    return buildResults(context);
  }
}
