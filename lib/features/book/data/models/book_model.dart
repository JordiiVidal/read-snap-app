import 'package:read_snap/features/book/domain/entities/book_entity.dart';

const String tableBooks = 'books';
const BookStatus defaultStatus = BookStatus.toRead;

class BookModel {
  // Columns
  static const String id = 'id';
  static const String name = 'name';
  static const String author = 'author';
  static const String totalPages = 'total_pages';
  static const String status = 'status';
  static const String color = 'color';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String currentPage = 'current_page';

  Map<String, dynamic> toMap(BookEntity entity) {
    return {
      id: entity.id,
      name: entity.name,
      author: entity.author,
      totalPages: entity.totalPages,
      currentPage: entity.currentPage,
      status: entity.status.name,
      color: entity.color,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
    };
  }

  BookEntity fromMap(Map<String, dynamic> map) {
    final status = BookStatus.values.firstWhere(
      (e) => e.name == map[BookModel.status],
      orElse: () => defaultStatus,
    );

    return BookEntity(
      id: map[id] as String,
      name: map[name] as String,
      author: map[author] as String,
      totalPages: map[totalPages] as int,
      currentPage: map[currentPage] as int?,
      status: status,
      color: map[color] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[updatedAt] as int),
    );
  }
}
