import 'package:read_snap/features/book/domain/domain.dart';

class BookMapper {
  static const String table = 'books';

  static const String id = 'id';
  static const String title = 'title';
  static const String author = 'author';
  static const String totalPages = 'total_pages';
  static const String currentPage = 'current_page';
  static const String categories = 'categories';
  static const String language = 'language';
  static const String status = 'status';
  static const String type = 'type';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String identifiers = 'identifiers';
  static const String googleExternalId = 'google_external_id';
  static const String imageThumbnail = 'image_thumbnail';
  static const String finishedAt = 'finished_at';
  static const String startedAt = 'started_at';

  static const BookStatus defaultStatus = BookStatus.toRead;
  static const BookType defaultType = BookType.paper;

  static Map<String, dynamic> toMap(BookEntity entity) {
    return {
      id: entity.id,
      title: entity.title,
      author: entity.author,
      totalPages: entity.totalPages,
      currentPage: entity.currentPage,
      categories: entity.categories.join(';'),
      language: entity.language,
      status: entity.status.name,
      type: entity.type.name,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
      identifiers: entity.identifiers?.join(';'),
      googleExternalId: entity.googleExternalId,
      imageThumbnail: entity.imageThumbnail,
      finishedAt: entity.finishedAt?.millisecondsSinceEpoch,
      startedAt: entity.startedAt?.millisecondsSinceEpoch,
    };
  }

  static BookEntity fromMap(Map<String, dynamic> map) {
    final statusValue = BookStatus.values.firstWhere(
      (e) => e.name == map[status],
      orElse: () => defaultStatus,
    );
    final typeValue = BookType.values.firstWhere(
      (e) => e.name == map[type],
      orElse: () => defaultType,
    );
    final List<String> categoriesList = (map[categories] as String).split(';');
    final List<String> identifiersList = (map[identifiers] as String).split(
      ';',
    );

    return BookEntity(
      id: map[id] as String,
      title: map[title] as String,
      author: map[author] as String,
      totalPages: map[totalPages] as int,
      currentPage: map[currentPage] as int,
      categories: categoriesList,
      language: map[language] as String,
      status: statusValue,
      type: typeValue,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt] as int),
      identifiers: identifiersList,
      googleExternalId: map[googleExternalId] as String?,
      imageThumbnail: map[imageThumbnail] as String?,
      finishedAt: map[finishedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[finishedAt] as int)
          : null,
      startedAt: map[startedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[startedAt] as int)
          : null,
    );
  }
}
