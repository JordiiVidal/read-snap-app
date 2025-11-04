// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookEntity _$BookEntityFromJson(Map<String, dynamic> json) => _BookEntity(
  id: json['id'] as String,
  externalId: json['externalId'] as String?,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  author: json['author'] as String,
  publisher: json['publisher'] as String?,
  publishedDate: json['publishedDate'] as String?,
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  totalPages: (json['totalPages'] as num).toInt(),
  status: $enumDecode(_$BookStatusEnumMap, json['status']),
  imageThumbnail: json['imageThumbnail'] as String?,
  language: json['language'] as String?,
  color: json['color'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  currentPage: (json['currentPage'] as num).toInt(),
  finishedAt: json['finishedAt'] == null
      ? null
      : DateTime.parse(json['finishedAt'] as String),
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
);

Map<String, dynamic> _$BookEntityToJson(_BookEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'author': instance.author,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'categories': instance.categories,
      'totalPages': instance.totalPages,
      'status': _$BookStatusEnumMap[instance.status]!,
      'imageThumbnail': instance.imageThumbnail,
      'language': instance.language,
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'currentPage': instance.currentPage,
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
    };

const _$BookStatusEnumMap = {
  BookStatus.toRead: 'toRead',
  BookStatus.reading: 'reading',
  BookStatus.completed: 'completed',
};
