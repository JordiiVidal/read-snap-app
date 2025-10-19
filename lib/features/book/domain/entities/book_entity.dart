import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_entity.freezed.dart';
part 'book_entity.g.dart';

enum BookStatus { toRead, reading, completed }

@freezed
abstract class BookEntity with _$BookEntity {
  const factory BookEntity({
    required String id,
    required String name,
    required String author,
    required int totalPages,
    required BookStatus status,
    required String color,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int currentPage,
    DateTime? finishedAt,
  }) = _BookEntity;

  factory BookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEntityFromJson(json);
}
