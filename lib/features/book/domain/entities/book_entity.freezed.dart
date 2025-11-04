// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookEntity {

 String get id; String? get externalId; String get title; String? get subtitle; String? get description; String get author; String? get publisher; String? get publishedDate; List<String>? get categories; int get totalPages; BookStatus get status; String? get imageThumbnail; String? get language; String get color; DateTime get createdAt; DateTime get updatedAt; int get currentPage; DateTime? get finishedAt; DateTime? get startedAt;
/// Create a copy of BookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookEntityCopyWith<BookEntity> get copyWith => _$BookEntityCopyWithImpl<BookEntity>(this as BookEntity, _$identity);

  /// Serializes this BookEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.status, status) || other.status == status)&&(identical(other.imageThumbnail, imageThumbnail) || other.imageThumbnail == imageThumbnail)&&(identical(other.language, language) || other.language == language)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,externalId,title,subtitle,description,author,publisher,publishedDate,const DeepCollectionEquality().hash(categories),totalPages,status,imageThumbnail,language,color,createdAt,updatedAt,currentPage,finishedAt,startedAt]);

@override
String toString() {
  return 'BookEntity(id: $id, externalId: $externalId, title: $title, subtitle: $subtitle, description: $description, author: $author, publisher: $publisher, publishedDate: $publishedDate, categories: $categories, totalPages: $totalPages, status: $status, imageThumbnail: $imageThumbnail, language: $language, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, currentPage: $currentPage, finishedAt: $finishedAt, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $BookEntityCopyWith<$Res>  {
  factory $BookEntityCopyWith(BookEntity value, $Res Function(BookEntity) _then) = _$BookEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? externalId, String title, String? subtitle, String? description, String author, String? publisher, String? publishedDate, List<String>? categories, int totalPages, BookStatus status, String? imageThumbnail, String? language, String color, DateTime createdAt, DateTime updatedAt, int currentPage, DateTime? finishedAt, DateTime? startedAt
});




}
/// @nodoc
class _$BookEntityCopyWithImpl<$Res>
    implements $BookEntityCopyWith<$Res> {
  _$BookEntityCopyWithImpl(this._self, this._then);

  final BookEntity _self;
  final $Res Function(BookEntity) _then;

/// Create a copy of BookEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? externalId = freezed,Object? title = null,Object? subtitle = freezed,Object? description = freezed,Object? author = null,Object? publisher = freezed,Object? publishedDate = freezed,Object? categories = freezed,Object? totalPages = null,Object? status = null,Object? imageThumbnail = freezed,Object? language = freezed,Object? color = null,Object? createdAt = null,Object? updatedAt = null,Object? currentPage = null,Object? finishedAt = freezed,Object? startedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String?,publishedDate: freezed == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookStatus,imageThumbnail: freezed == imageThumbnail ? _self.imageThumbnail : imageThumbnail // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookEntity].
extension BookEntityPatterns on BookEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? externalId,  String title,  String? subtitle,  String? description,  String author,  String? publisher,  String? publishedDate,  List<String>? categories,  int totalPages,  BookStatus status,  String? imageThumbnail,  String? language,  String color,  DateTime createdAt,  DateTime updatedAt,  int currentPage,  DateTime? finishedAt,  DateTime? startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that.id,_that.externalId,_that.title,_that.subtitle,_that.description,_that.author,_that.publisher,_that.publishedDate,_that.categories,_that.totalPages,_that.status,_that.imageThumbnail,_that.language,_that.color,_that.createdAt,_that.updatedAt,_that.currentPage,_that.finishedAt,_that.startedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? externalId,  String title,  String? subtitle,  String? description,  String author,  String? publisher,  String? publishedDate,  List<String>? categories,  int totalPages,  BookStatus status,  String? imageThumbnail,  String? language,  String color,  DateTime createdAt,  DateTime updatedAt,  int currentPage,  DateTime? finishedAt,  DateTime? startedAt)  $default,) {final _that = this;
switch (_that) {
case _BookEntity():
return $default(_that.id,_that.externalId,_that.title,_that.subtitle,_that.description,_that.author,_that.publisher,_that.publishedDate,_that.categories,_that.totalPages,_that.status,_that.imageThumbnail,_that.language,_that.color,_that.createdAt,_that.updatedAt,_that.currentPage,_that.finishedAt,_that.startedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? externalId,  String title,  String? subtitle,  String? description,  String author,  String? publisher,  String? publishedDate,  List<String>? categories,  int totalPages,  BookStatus status,  String? imageThumbnail,  String? language,  String color,  DateTime createdAt,  DateTime updatedAt,  int currentPage,  DateTime? finishedAt,  DateTime? startedAt)?  $default,) {final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that.id,_that.externalId,_that.title,_that.subtitle,_that.description,_that.author,_that.publisher,_that.publishedDate,_that.categories,_that.totalPages,_that.status,_that.imageThumbnail,_that.language,_that.color,_that.createdAt,_that.updatedAt,_that.currentPage,_that.finishedAt,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookEntity extends BookEntity {
  const _BookEntity({required this.id, this.externalId, required this.title, this.subtitle, this.description, required this.author, this.publisher, this.publishedDate, final  List<String>? categories, required this.totalPages, required this.status, this.imageThumbnail, this.language, required this.color, required this.createdAt, required this.updatedAt, required this.currentPage, this.finishedAt, this.startedAt}): _categories = categories,super._();
  factory _BookEntity.fromJson(Map<String, dynamic> json) => _$BookEntityFromJson(json);

@override final  String id;
@override final  String? externalId;
@override final  String title;
@override final  String? subtitle;
@override final  String? description;
@override final  String author;
@override final  String? publisher;
@override final  String? publishedDate;
 final  List<String>? _categories;
@override List<String>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int totalPages;
@override final  BookStatus status;
@override final  String? imageThumbnail;
@override final  String? language;
@override final  String color;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  int currentPage;
@override final  DateTime? finishedAt;
@override final  DateTime? startedAt;

/// Create a copy of BookEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookEntityCopyWith<_BookEntity> get copyWith => __$BookEntityCopyWithImpl<_BookEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.status, status) || other.status == status)&&(identical(other.imageThumbnail, imageThumbnail) || other.imageThumbnail == imageThumbnail)&&(identical(other.language, language) || other.language == language)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,externalId,title,subtitle,description,author,publisher,publishedDate,const DeepCollectionEquality().hash(_categories),totalPages,status,imageThumbnail,language,color,createdAt,updatedAt,currentPage,finishedAt,startedAt]);

@override
String toString() {
  return 'BookEntity(id: $id, externalId: $externalId, title: $title, subtitle: $subtitle, description: $description, author: $author, publisher: $publisher, publishedDate: $publishedDate, categories: $categories, totalPages: $totalPages, status: $status, imageThumbnail: $imageThumbnail, language: $language, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, currentPage: $currentPage, finishedAt: $finishedAt, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$BookEntityCopyWith<$Res> implements $BookEntityCopyWith<$Res> {
  factory _$BookEntityCopyWith(_BookEntity value, $Res Function(_BookEntity) _then) = __$BookEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? externalId, String title, String? subtitle, String? description, String author, String? publisher, String? publishedDate, List<String>? categories, int totalPages, BookStatus status, String? imageThumbnail, String? language, String color, DateTime createdAt, DateTime updatedAt, int currentPage, DateTime? finishedAt, DateTime? startedAt
});




}
/// @nodoc
class __$BookEntityCopyWithImpl<$Res>
    implements _$BookEntityCopyWith<$Res> {
  __$BookEntityCopyWithImpl(this._self, this._then);

  final _BookEntity _self;
  final $Res Function(_BookEntity) _then;

/// Create a copy of BookEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? externalId = freezed,Object? title = null,Object? subtitle = freezed,Object? description = freezed,Object? author = null,Object? publisher = freezed,Object? publishedDate = freezed,Object? categories = freezed,Object? totalPages = null,Object? status = null,Object? imageThumbnail = freezed,Object? language = freezed,Object? color = null,Object? createdAt = null,Object? updatedAt = null,Object? currentPage = null,Object? finishedAt = freezed,Object? startedAt = freezed,}) {
  return _then(_BookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String?,publishedDate: freezed == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookStatus,imageThumbnail: freezed == imageThumbnail ? _self.imageThumbnail : imageThumbnail // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
