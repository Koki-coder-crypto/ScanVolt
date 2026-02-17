// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QrContent {

 QrContentType get type; String get data; String get label; DateTime get createdAt;
/// Create a copy of QrContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrContentCopyWith<QrContent> get copyWith => _$QrContentCopyWithImpl<QrContent>(this as QrContent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrContent&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.label, label) || other.label == label)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,type,data,label,createdAt);

@override
String toString() {
  return 'QrContent(type: $type, data: $data, label: $label, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QrContentCopyWith<$Res>  {
  factory $QrContentCopyWith(QrContent value, $Res Function(QrContent) _then) = _$QrContentCopyWithImpl;
@useResult
$Res call({
 QrContentType type, String data, String label, DateTime createdAt
});




}
/// @nodoc
class _$QrContentCopyWithImpl<$Res>
    implements $QrContentCopyWith<$Res> {
  _$QrContentCopyWithImpl(this._self, this._then);

  final QrContent _self;
  final $Res Function(QrContent) _then;

/// Create a copy of QrContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? label = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QrContentType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QrContent].
extension QrContentPatterns on QrContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrContent value)  $default,){
final _that = this;
switch (_that) {
case _QrContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrContent value)?  $default,){
final _that = this;
switch (_that) {
case _QrContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QrContentType type,  String data,  String label,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrContent() when $default != null:
return $default(_that.type,_that.data,_that.label,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QrContentType type,  String data,  String label,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _QrContent():
return $default(_that.type,_that.data,_that.label,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QrContentType type,  String data,  String label,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QrContent() when $default != null:
return $default(_that.type,_that.data,_that.label,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _QrContent implements QrContent {
  const _QrContent({required this.type, required this.data, required this.label, required this.createdAt});
  

@override final  QrContentType type;
@override final  String data;
@override final  String label;
@override final  DateTime createdAt;

/// Create a copy of QrContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrContentCopyWith<_QrContent> get copyWith => __$QrContentCopyWithImpl<_QrContent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrContent&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.label, label) || other.label == label)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,type,data,label,createdAt);

@override
String toString() {
  return 'QrContent(type: $type, data: $data, label: $label, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QrContentCopyWith<$Res> implements $QrContentCopyWith<$Res> {
  factory _$QrContentCopyWith(_QrContent value, $Res Function(_QrContent) _then) = __$QrContentCopyWithImpl;
@override @useResult
$Res call({
 QrContentType type, String data, String label, DateTime createdAt
});




}
/// @nodoc
class __$QrContentCopyWithImpl<$Res>
    implements _$QrContentCopyWith<$Res> {
  __$QrContentCopyWithImpl(this._self, this._then);

  final _QrContent _self;
  final $Res Function(_QrContent) _then;

/// Create a copy of QrContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? label = null,Object? createdAt = null,}) {
  return _then(_QrContent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QrContentType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
