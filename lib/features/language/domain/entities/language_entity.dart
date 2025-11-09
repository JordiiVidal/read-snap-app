import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_entity.freezed.dart';
part 'language_entity.g.dart';

@freezed
abstract class LanguageEntity with _$LanguageEntity {
  const LanguageEntity._();

  const factory LanguageEntity({
    required String id,
    required String code,
    required String name,
    required String nativeName,
    required String flag,
    required bool selectedByUser,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LanguageEntity;

  factory LanguageEntity.fromJson(Map<String, dynamic> json) =>
      _$LanguageEntityFromJson(json);
}
