// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookEntity _$BookEntityFromJson(Map<String, dynamic> json) => _BookEntity(
  id: json['id'] as String,
  name: json['name'] as String,
  author: json['author'] as String,
  totalPages: (json['totalPages'] as num).toInt(),
  status: $enumDecode(_$BookStatusEnumMap, json['status']),
  color: json['color'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  currentPage: (json['currentPage'] as num).toInt(),
  finishedAt: json['finishedAt'] == null
      ? null
      : DateTime.parse(json['finishedAt'] as String),
);

Map<String, dynamic> _$BookEntityToJson(_BookEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'totalPages': instance.totalPages,
      'status': _$BookStatusEnumMap[instance.status]!,
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'currentPage': instance.currentPage,
      'finishedAt': instance.finishedAt?.toIso8601String(),
    };

const _$BookStatusEnumMap = {
  BookStatus.toRead: 'toRead',
  BookStatus.reading: 'reading',
  BookStatus.completed: 'completed',
};
