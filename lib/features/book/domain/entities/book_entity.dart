import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_entity.freezed.dart';
part 'book_entity.g.dart';

enum BookStatus { toRead, reading, completed }

enum BookType { paper, digital }

mixin BookProgressLogic {
  int get currentPage;
  int get totalPages;

  double get progressValue {
    if (totalPages <= 0) return 0.0;
    final value = currentPage / totalPages;
    return value.clamp(0.0, 1.0).toDouble();
  }

  int get progressPercentage {
    return (progressValue * 100).round();
  }
}

@freezed
abstract class BookEntity with _$BookEntity, BookProgressLogic {
  const BookEntity._();
  const factory BookEntity({
    required String id,
    required String title,
    required String author,
    required int totalPages,
    required int currentPage,
    required List<String> categories,
    required String language,
    required BookStatus status,
    required BookType type,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<String>? identifiers,
    String? googleExternalId,
    String? imageThumbnail,
    DateTime? finishedAt,
    DateTime? startedAt,
  }) = _BookEntity;

  factory BookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEntityFromJson(json);
}
