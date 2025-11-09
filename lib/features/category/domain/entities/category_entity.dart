import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const CategoryEntity._();

  const factory CategoryEntity({
    required String id,
    required String name,
    required bool selectedByUser,
    String? iconEmoji,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<String> aliases,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  bool matches(String value) {
    final normalized = value.toLowerCase().trim();

    if (name.toLowerCase() == normalized) return true;

    if (aliases.any((alias) => alias.toLowerCase() == normalized)) {
      return true;
    }

    if (name.toLowerCase().contains(normalized) ||
        normalized.contains(name.toLowerCase())) {
      return true;
    }

    return false;
  }
}
