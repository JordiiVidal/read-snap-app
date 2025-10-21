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

 String get id; String get name; String get author; int get totalPages; BookStatus get status; String get color; DateTime get createdAt; DateTime get updatedAt; int get currentPage; DateTime? get finishedAt;
/// Create a copy of BookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookEntityCopyWith<BookEntity> get copyWith => _$BookEntityCopyWithImpl<BookEntity>(this as BookEntity, _$identity);

  /// Serializes this BookEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.status, status) || other.status == status)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,author,totalPages,status,color,createdAt,updatedAt,currentPage,finishedAt);

@override
String toString() {
  return 'BookEntity(id: $id, name: $name, author: $author, totalPages: $totalPages, status: $status, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, currentPage: $currentPage, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class $BookEntityCopyWith<$Res>  {
  factory $BookEntityCopyWith(BookEntity value, $Res Function(BookEntity) _then) = _$BookEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String author, int totalPages, BookStatus status, String color, DateTime createdAt, DateTime updatedAt, int currentPage, DateTime? finishedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? author = null,Object? totalPages = null,Object? status = null,Object? color = null,Object? createdAt = null,Object? updatedAt = null,Object? currentPage = null,Object? finishedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookStatus,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String author,  int totalPages,  BookStatus status,  String color,  DateTime createdAt,  DateTime updatedAt,  int currentPage,  DateTime? finishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that.id,_that.name,_that.author,_that.totalPages,_that.status,_that.color,_that.createdAt,_that.updatedAt,_that.currentPage,_that.finishedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String author,  int totalPages,  BookStatus status,  String color,  DateTime createdAt,  DateTime updatedAt,  int currentPage,  DateTime? finishedAt)  $default,) {final _that = this;
switch (_that) {
case _BookEntity():
return $default(_that.id,_that.name,_that.author,_that.totalPages,_that.status,_that.color,_that.createdAt,_that.updatedAt,_that.currentPage,_that.finishedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String author,  int totalPages,  BookStatus status,  String color,  DateTime createdAt,  DateTime updatedAt,  int currentPage,  DateTime? finishedAt)?  $default,) {final _that = this;
switch (_that) {
case _BookEntity() when $default != null:
return $default(_that.id,_that.name,_that.author,_that.totalPages,_that.status,_that.color,_that.createdAt,_that.updatedAt,_that.currentPage,_that.finishedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookEntity extends BookEntity {
  const _BookEntity({required this.id, required this.name, required this.author, required this.totalPages, required this.status, required this.color, required this.createdAt, required this.updatedAt, required this.currentPage, this.finishedAt}): super._();
  factory _BookEntity.fromJson(Map<String, dynamic> json) => _$BookEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String author;
@override final  int totalPages;
@override final  BookStatus status;
@override final  String color;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  int currentPage;
@override final  DateTime? finishedAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.author, author) || other.author == author)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.status, status) || other.status == status)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,author,totalPages,status,color,createdAt,updatedAt,currentPage,finishedAt);

@override
String toString() {
  return 'BookEntity(id: $id, name: $name, author: $author, totalPages: $totalPages, status: $status, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, currentPage: $currentPage, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class _$BookEntityCopyWith<$Res> implements $BookEntityCopyWith<$Res> {
  factory _$BookEntityCopyWith(_BookEntity value, $Res Function(_BookEntity) _then) = __$BookEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String author, int totalPages, BookStatus status, String color, DateTime createdAt, DateTime updatedAt, int currentPage, DateTime? finishedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? author = null,Object? totalPages = null,Object? status = null,Object? color = null,Object? createdAt = null,Object? updatedAt = null,Object? currentPage = null,Object? finishedAt = freezed,}) {
  return _then(_BookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BookStatus,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
