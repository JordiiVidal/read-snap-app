// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookEntity _$BookEntityFromJson(Map<String, dynamic> json) => _BookEntity(
  id: json['id'] as String,
  title: json['title'] as String,
  author: json['author'] as String,
  totalPages: (json['totalPages'] as num).toInt(),
  currentPage: (json['currentPage'] as num).toInt(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  language: json['language'] as String,
  status: $enumDecode(_$BookStatusEnumMap, json['status']),
  type: $enumDecode(_$BookTypeEnumMap, json['type']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  identifiers: (json['identifiers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  googleExternalId: json['googleExternalId'] as String?,
  imageThumbnail: json['imageThumbnail'] as String?,
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
      'title': instance.title,
      'author': instance.author,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'categories': instance.categories,
      'language': instance.language,
      'status': _$BookStatusEnumMap[instance.status]!,
      'type': _$BookTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'identifiers': instance.identifiers,
      'googleExternalId': instance.googleExternalId,
      'imageThumbnail': instance.imageThumbnail,
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
    };

const _$BookStatusEnumMap = {
  BookStatus.toRead: 'toRead',
  BookStatus.reading: 'reading',
  BookStatus.completed: 'completed',
};

const _$BookTypeEnumMap = {
  BookType.paper: 'paper',
  BookType.digital: 'digital',
};
