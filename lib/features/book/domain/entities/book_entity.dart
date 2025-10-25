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
    required String name,
    required String author,
    required int totalPages,
    required BookStatus status,
    required String color,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int currentPage,
    DateTime? finishedAt,
    DateTime? startedAt,
  }) = _BookEntity;

  factory BookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEntityFromJson(json);
}
