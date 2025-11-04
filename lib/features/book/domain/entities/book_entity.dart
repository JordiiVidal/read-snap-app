import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_entity.freezed.dart';
part 'book_entity.g.dart';

enum BookStatus { toRead, reading, completed }

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

mixin BookColorLogic {
  String get color;

  Color get flutterColor {
    final hexCode = color.replaceFirst('#', '0xFF');
    final intColor = int.tryParse(hexCode);

    if (intColor == null) {
      return Colors.grey;
    }
    return Color(intColor);
  }
}

@freezed
abstract class BookEntity with _$BookEntity, BookProgressLogic, BookColorLogic {
  const BookEntity._();
  const factory BookEntity({
    required String id,
    String? externalId,
    required String title,
    String? subtitle,
    String? description,
    required String author,
    String? publisher,
    String? publishedDate,
    List<String>? categories,
    required int totalPages,
    required BookStatus status,
    String? imageThumbnail,
    String? language,
    required String color,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int currentPage,
    DateTime? finishedAt,
    DateTime? startedAt,
  }) = _BookEntity;

  factory BookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEntityFromJson(json);

  factory BookEntity.fromGoogleBooksJson(Map<String, dynamic> json) {
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
