import 'package:read_snap/features/book/domain/domain.dart';

class GoogleBooksMapper {
  static BookEntity fromGoogleBooksJson(Map<String, dynamic> json) {
    final String externalId = json['id'] as String? ?? '';
    final volumeInfo = json['volumeInfo'];
    final String title = volumeInfo['title'] as String? ?? 'Title Not Found';
    final List<dynamic>? authorsRaw = volumeInfo['authors'] as List<dynamic>?;
    final List<String> authors = authorsRaw?.cast<String>().toList() ?? [];
    final int totalPages = volumeInfo['pageCount'] as int? ?? 0;
    final String? subtitle = volumeInfo['subtitle'] as String?;
    final String? description = volumeInfo['description'] as String?;
    final String? publisher = volumeInfo['publisher'] as String?;
    final String? publishedDate = volumeInfo['publishedDate'] as String?;
    final String? language = volumeInfo['language'] as String?;
    final List<dynamic>? categoriesRaw =
        volumeInfo['categories'] as List<dynamic>?;
    final List<String> categories =
        categoriesRaw?.cast<String>().toList() ?? [];
    final Map<String, dynamic>? imageLinks =
        volumeInfo['imageLinks'] as Map<String, dynamic>?;
    final String? imageThumbnail =
        imageLinks?['large'] ??
        imageLinks?['medium'] ??
        imageLinks?['thumbnail'];

    final now = DateTime.now();

    return BookEntity(
      id: '',
      externalId: externalId,
      createdAt: now,
      updatedAt: now,
      title: title,
      author: authors.join(', '),
      totalPages: totalPages,
      publisher: publisher,
      publishedDate: publishedDate,
      categories: categories,
      description: description,
      subtitle: subtitle,
      imageThumbnail: imageThumbnail,
      currentPage: 0,
      status: BookStatus.toRead,
      language: language,
      color: '#A0A0A0',
      startedAt: null,
      finishedAt: null,
    );
  }
}
