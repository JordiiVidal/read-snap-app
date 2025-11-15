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

 String get id; String get title; String get author; int get totalPages; int get currentPage; List<String> get categories; String get language; BookStatus get status; BookType get type; DateTime get createdAt; DateTime get updatedAt; List<String>? get identifiers; String? get googleExternalId; String? get imageThumbnail; DateTime? get finishedAt; DateTime? get startedAt;
/// Create a copy of BookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookEntityCopyWith<BookEntity> get copyWith => _$BookEntityCopyWithImpl<BookEntity>(this as BookEntity, _$identity);

  /// Serializes this BookEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.language, language) || other.language == language)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.identifiers, identifiers)&&(identical(other.googleExternalId, googleExternalId) || other.googleExternalId == googleExternalId)&&(identical(other.imageThumbnail, imageThumbnail) || other.imageThumbnail == imageThumbnail)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,totalPages,currentPage,const DeepCollectionEquality().hash(categories),language,status,type,createdAt,updatedAt,const DeepCollectionEquality().hash(identifiers),googleExternalId,imageThumbnail,finishedAt,startedAt);

@override
String toString() {
  return 'BookEntity(id: $id, title: $title, author: $author, totalPages: $totalPages, currentPage: $currentPage, categories: $categories, language: $language, status: $status, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, identifiers: $identifiers, googleExternalId: $googleExternalId, imageThumbnail: $imageThumbnail, finishedAt: $finishedAt, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $BookEntityCopyWith<$Res>  {
  factory $BookEntityCopyWith(BookEntity value, $Res Function(BookEntity) _then) = _$BookEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String author, int totalPages, int currentPage, List<String> categories, String language, BookStatus status, BookType type, DateTime createdAt, DateTime updatedAt, List<String>? identifiers, String? googleExternalId, String? imageThumbnail, DateTime? finishedAt, DateTime? startedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? author = null,Object? totalPages = null,Object? currentPage = null,Object? categories = null,Object? language = null,Object? status = null,Object? type = null,Object? createdAt = null,Object? updatedAt = null,Object? identifiers = freezed,Object? googleExternalId = freezed,Object? imageThumbnail = freezed,Object? finishedAt = freezed,Object? startedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BookType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,identifiers: freezed == identifiers ? _self.identifiers : identifiers // ignore: cast_nullable_to_non_nullable
as List<String>?,googleExternalId: freezed == googleExternalId ? _self.googleExternalId : googleExternalId // ignore: cast_nullable_to_non_nullable
as String?,imageThumbnail: freezed == imageThumbnail ? _self.imageThumbnail : imageThumbnail // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String author,  int totalPages,  int currentPage,  List<String> categories,  String language,  BookStatus status,  BookType type,  DateTime createdAt,  DateTime updatedAt,  List<String>? identifiers,  String? googleExternalId,  String? imageThumbnail,  DateTime? finishedAt,  DateTime? startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.totalPages,_that.currentPage,_that.categories,_that.language,_that.status,_that.type,_that.createdAt,_that.updatedAt,_that.identifiers,_that.googleExternalId,_that.imageThumbnail,_that.finishedAt,_that.startedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String author,  int totalPages,  int currentPage,  List<String> categories,  String language,  BookStatus status,  BookType type,  DateTime createdAt,  DateTime updatedAt,  List<String>? identifiers,  String? googleExternalId,  String? imageThumbnail,  DateTime? finishedAt,  DateTime? startedAt)  $default,) {final _that = this;
switch (_that) {
case _BookEntity():
return $default(_that.id,_that.title,_that.author,_that.totalPages,_that.currentPage,_that.categories,_that.language,_that.status,_that.type,_that.createdAt,_that.updatedAt,_that.identifiers,_that.googleExternalId,_that.imageThumbnail,_that.finishedAt,_that.startedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String author,  int totalPages,  int currentPage,  List<String> categories,  String language,  BookStatus status,  BookType type,  DateTime createdAt,  DateTime updatedAt,  List<String>? identifiers,  String? googleExternalId,  String? imageThumbnail,  DateTime? finishedAt,  DateTime? startedAt)?  $default,) {final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.totalPages,_that.currentPage,_that.categories,_that.language,_that.status,_that.type,_that.createdAt,_that.updatedAt,_that.identifiers,_that.googleExternalId,_that.imageThumbnail,_that.finishedAt,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookEntity extends BookEntity {
  const _BookEntity({required this.id, required this.title, required this.author, required this.totalPages, required this.currentPage, required final  List<String> categories, required this.language, required this.status, required this.type, required this.createdAt, required this.updatedAt, final  List<String>? identifiers, this.googleExternalId, this.imageThumbnail, this.finishedAt, this.startedAt}): _categories = categories,_identifiers = identifiers,super._();
  factory _BookEntity.fromJson(Map<String, dynamic> json) => _$BookEntityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String author;
@override final  int totalPages;
@override final  int currentPage;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String language;
@override final  BookStatus status;
@override final  BookType type;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<String>? _identifiers;
@override List<String>? get identifiers {
  final value = _identifiers;
  if (value == null) return null;
  if (_identifiers is EqualUnmodifiableListView) return _identifiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? googleExternalId;
@override final  String? imageThumbnail;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.language, language) || other.language == language)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._identifiers, _identifiers)&&(identical(other.googleExternalId, googleExternalId) || other.googleExternalId == googleExternalId)&&(identical(other.imageThumbnail, imageThumbnail) || other.imageThumbnail == imageThumbnail)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,totalPages,currentPage,const DeepCollectionEquality().hash(_categories),language,status,type,createdAt,updatedAt,const DeepCollectionEquality().hash(_identifiers),googleExternalId,imageThumbnail,finishedAt,startedAt);

@override
String toString() {
  return 'BookEntity(id: $id, title: $title, author: $author, totalPages: $totalPages, currentPage: $currentPage, categories: $categories, language: $language, status: $status, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, identifiers: $identifiers, googleExternalId: $googleExternalId, imageThumbnail: $imageThumbnail, finishedAt: $finishedAt, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$BookEntityCopyWith<$Res> implements $BookEntityCopyWith<$Res> {
  factory _$BookEntityCopyWith(_BookEntity value, $Res Function(_BookEntity) _then) = __$BookEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String author, int totalPages, int currentPage, List<String> categories, String language, BookStatus status, BookType type, DateTime createdAt, DateTime updatedAt, List<String>? identifiers, String? googleExternalId, String? imageThumbnail, DateTime? finishedAt, DateTime? startedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? author = null,Object? totalPages = null,Object? currentPage = null,Object? categories = null,Object? language = null,Object? status = null,Object? type = null,Object? createdAt = null,Object? updatedAt = null,Object? identifiers = freezed,Object? googleExternalId = freezed,Object? imageThumbnail = freezed,Object? finishedAt = freezed,Object? startedAt = freezed,}) {
  return _then(_BookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BookType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,identifiers: freezed == identifiers ? _self._identifiers : identifiers // ignore: cast_nullable_to_non_nullable
as List<String>?,googleExternalId: freezed == googleExternalId ? _self.googleExternalId : googleExternalId // ignore: cast_nullable_to_non_nullable
as String?,imageThumbnail: freezed == imageThumbnail ? _self.imageThumbnail : imageThumbnail // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
