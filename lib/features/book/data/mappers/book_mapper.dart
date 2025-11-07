import 'package:read_snap/features/book/domain/domain.dart';

class BookMapper {
  static const String table = 'books';

  static const String id = 'id';
  static const String externalId = 'external_id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String description = 'description';
  static const String author = 'author';
  static const String publisher = 'publisher';
  static const String publishedDate = 'published_date';
  static const String categories = 'categories';
  static const String totalPages = 'total_pages';
  static const String status = 'status';
  static const String color = 'color';
  static const String currentPage = 'current_page';
  static const String imageThumbnail = 'image_thumbnail';
  static const String language = 'language';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String finishedAt = 'finished_at';
  static const String startedAt = 'started_at';

  static const BookStatus defaultStatus = BookStatus.toRead;

  static Map<String, dynamic> toMap(BookEntity entity) {
    return {
      id: entity.id,
      externalId: entity.externalId,
      title: entity.title,
      subtitle: entity.subtitle,
      description: entity.description,
      author: entity.author,
      publisher: entity.publisher,
      publishedDate: entity.publishedDate,
      totalPages: entity.totalPages,
      imageThumbnail: entity.imageThumbnail,
      language: entity.language,
      categories: entity.categories?.join(';'),
      currentPage: entity.currentPage,
      status: entity.status.name,
      color: entity.color,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
      finishedAt: entity.finishedAt?.millisecondsSinceEpoch,
      startedAt: entity.startedAt?.millisecondsSinceEpoch,
    };
  }

  static BookEntity fromMap(Map<String, dynamic> map) {
    final statusValue = BookStatus.values.firstWhere(
      (e) => e.name == map[status],
      orElse: () => defaultStatus,
    );
    final List<String>? categoriesList = (map[categories] as String?)?.split(
      ';',
    );

    return BookEntity(
      id: map[id] as String,
      title: map[title] as String,
      author: map[author] as String,
      totalPages: map[totalPages] as int,
      currentPage: map[currentPage] as int,
      status: statusValue,
      color: map[color] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt] as int),
      externalId: map[externalId] as String?,
      subtitle: map[subtitle] as String?,
      description: map[description] as String?,
      publisher: map[publisher] as String?,
      publishedDate: map[publishedDate] as String?,
      imageThumbnail: map[imageThumbnail] as String?,
      language: map[language] as String?,
      categories: categoriesList,
      finishedAt: map[finishedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[finishedAt] as int)
          : null,
      startedAt: map[startedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[startedAt] as int)
          : null,
    );
  }
}
