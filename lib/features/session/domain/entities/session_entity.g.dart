// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) =>
    _SessionEntity(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      startPage: (json['startPage'] as num).toInt(),
      endPage: (json['endPage'] as num).toInt(),
      minutesRead: (json['minutesRead'] as num).toInt(),
      pagesRead: (json['pagesRead'] as num?)?.toInt(),
      sessionDate: DateTime.parse(json['sessionDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SessionEntityToJson(_SessionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'startPage': instance.startPage,
      'endPage': instance.endPage,
      'minutesRead': instance.minutesRead,
      'pagesRead': instance.pagesRead,
      'sessionDate': instance.sessionDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
