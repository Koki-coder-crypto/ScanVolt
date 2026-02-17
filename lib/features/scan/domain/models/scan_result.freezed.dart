// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScanResult {

 String get id; String get rawValue; String get format; ScanDataType get dataType; DateTime get scannedAt; String? get displayValue; bool get isFavorite;
/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanResultCopyWith<ScanResult> get copyWith => _$ScanResultCopyWithImpl<ScanResult>(this as ScanResult, _$identity);

  /// Serializes this ScanResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanResult&&(identical(other.id, id) || other.id == id)&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue)&&(identical(other.format, format) || other.format == format)&&(identical(other.dataType, dataType) || other.dataType == dataType)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rawValue,format,dataType,scannedAt,displayValue,isFavorite);

@override
String toString() {
  return 'ScanResult(id: $id, rawValue: $rawValue, format: $format, dataType: $dataType, scannedAt: $scannedAt, displayValue: $displayValue, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $ScanResultCopyWith<$Res>  {
  factory $ScanResultCopyWith(ScanResult value, $Res Function(ScanResult) _then) = _$ScanResultCopyWithImpl;
@useResult
$Res call({
 String id, String rawValue, String format, ScanDataType dataType, DateTime scannedAt, String? displayValue, bool isFavorite
});




}
/// @nodoc
class _$ScanResultCopyWithImpl<$Res>
    implements $ScanResultCopyWith<$Res> {
  _$ScanResultCopyWithImpl(this._self, this._then);

  final ScanResult _self;
  final $Res Function(ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rawValue = null,Object? format = null,Object? dataType = null,Object? scannedAt = null,Object? displayValue = freezed,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rawValue: null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,dataType: null == dataType ? _self.dataType : dataType // ignore: cast_nullable_to_non_nullable
as ScanDataType,scannedAt: null == scannedAt ? _self.scannedAt : scannedAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanResult].
extension ScanResultPatterns on ScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanResult value)  $default,){
final _that = this;
switch (_that) {
case _ScanResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanResult value)?  $default,){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String rawValue,  String format,  ScanDataType dataType,  DateTime scannedAt,  String? displayValue,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.id,_that.rawValue,_that.format,_that.dataType,_that.scannedAt,_that.displayValue,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String rawValue,  String format,  ScanDataType dataType,  DateTime scannedAt,  String? displayValue,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _ScanResult():
return $default(_that.id,_that.rawValue,_that.format,_that.dataType,_that.scannedAt,_that.displayValue,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String rawValue,  String format,  ScanDataType dataType,  DateTime scannedAt,  String? displayValue,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.id,_that.rawValue,_that.format,_that.dataType,_that.scannedAt,_that.displayValue,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanResult implements ScanResult {
  const _ScanResult({required this.id, required this.rawValue, required this.format, required this.dataType, required this.scannedAt, this.displayValue, this.isFavorite = false});
  factory _ScanResult.fromJson(Map<String, dynamic> json) => _$ScanResultFromJson(json);

@override final  String id;
@override final  String rawValue;
@override final  String format;
@override final  ScanDataType dataType;
@override final  DateTime scannedAt;
@override final  String? displayValue;
@override@JsonKey() final  bool isFavorite;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanResultCopyWith<_ScanResult> get copyWith => __$ScanResultCopyWithImpl<_ScanResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanResult&&(identical(other.id, id) || other.id == id)&&(identical(other.rawValue, rawValue) || other.rawValue == rawValue)&&(identical(other.format, format) || other.format == format)&&(identical(other.dataType, dataType) || other.dataType == dataType)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt)&&(identical(other.displayValue, displayValue) || other.displayValue == displayValue)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rawValue,format,dataType,scannedAt,displayValue,isFavorite);

@override
String toString() {
  return 'ScanResult(id: $id, rawValue: $rawValue, format: $format, dataType: $dataType, scannedAt: $scannedAt, displayValue: $displayValue, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$ScanResultCopyWith<$Res> implements $ScanResultCopyWith<$Res> {
  factory _$ScanResultCopyWith(_ScanResult value, $Res Function(_ScanResult) _then) = __$ScanResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String rawValue, String format, ScanDataType dataType, DateTime scannedAt, String? displayValue, bool isFavorite
});




}
/// @nodoc
class __$ScanResultCopyWithImpl<$Res>
    implements _$ScanResultCopyWith<$Res> {
  __$ScanResultCopyWithImpl(this._self, this._then);

  final _ScanResult _self;
  final $Res Function(_ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rawValue = null,Object? format = null,Object? dataType = null,Object? scannedAt = null,Object? displayValue = freezed,Object? isFavorite = null,}) {
  return _then(_ScanResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rawValue: null == rawValue ? _self.rawValue : rawValue // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,dataType: null == dataType ? _self.dataType : dataType // ignore: cast_nullable_to_non_nullable
as ScanDataType,scannedAt: null == scannedAt ? _self.scannedAt : scannedAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayValue: freezed == displayValue ? _self.displayValue : displayValue // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
