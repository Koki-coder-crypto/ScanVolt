// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanState {

 bool get isScanning; ScanResult? get lastResult; bool get torchEnabled; String? get error;
/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanStateCopyWith<ScanState> get copyWith => _$ScanStateCopyWithImpl<ScanState>(this as ScanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.torchEnabled, torchEnabled) || other.torchEnabled == torchEnabled)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,lastResult,torchEnabled,error);

@override
String toString() {
  return 'ScanState(isScanning: $isScanning, lastResult: $lastResult, torchEnabled: $torchEnabled, error: $error)';
}


}

/// @nodoc
abstract mixin class $ScanStateCopyWith<$Res>  {
  factory $ScanStateCopyWith(ScanState value, $Res Function(ScanState) _then) = _$ScanStateCopyWithImpl;
@useResult
$Res call({
 bool isScanning, ScanResult? lastResult, bool torchEnabled, String? error
});


$ScanResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class _$ScanStateCopyWithImpl<$Res>
    implements $ScanStateCopyWith<$Res> {
  _$ScanStateCopyWithImpl(this._self, this._then);

  final ScanState _self;
  final $Res Function(ScanState) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isScanning = null,Object? lastResult = freezed,Object? torchEnabled = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as ScanResult?,torchEnabled: null == torchEnabled ? _self.torchEnabled : torchEnabled // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $ScanResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanState].
extension ScanStatePatterns on ScanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanState value)  $default,){
final _that = this;
switch (_that) {
case _ScanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanState value)?  $default,){
final _that = this;
switch (_that) {
case _ScanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isScanning,  ScanResult? lastResult,  bool torchEnabled,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanState() when $default != null:
return $default(_that.isScanning,_that.lastResult,_that.torchEnabled,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isScanning,  ScanResult? lastResult,  bool torchEnabled,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ScanState():
return $default(_that.isScanning,_that.lastResult,_that.torchEnabled,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isScanning,  ScanResult? lastResult,  bool torchEnabled,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ScanState() when $default != null:
return $default(_that.isScanning,_that.lastResult,_that.torchEnabled,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ScanState implements ScanState {
  const _ScanState({this.isScanning = true, this.lastResult, this.torchEnabled = false, this.error});
  

@override@JsonKey() final  bool isScanning;
@override final  ScanResult? lastResult;
@override@JsonKey() final  bool torchEnabled;
@override final  String? error;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanStateCopyWith<_ScanState> get copyWith => __$ScanStateCopyWithImpl<_ScanState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.lastResult, lastResult) || other.lastResult == lastResult)&&(identical(other.torchEnabled, torchEnabled) || other.torchEnabled == torchEnabled)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,lastResult,torchEnabled,error);

@override
String toString() {
  return 'ScanState(isScanning: $isScanning, lastResult: $lastResult, torchEnabled: $torchEnabled, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ScanStateCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory _$ScanStateCopyWith(_ScanState value, $Res Function(_ScanState) _then) = __$ScanStateCopyWithImpl;
@override @useResult
$Res call({
 bool isScanning, ScanResult? lastResult, bool torchEnabled, String? error
});


@override $ScanResultCopyWith<$Res>? get lastResult;

}
/// @nodoc
class __$ScanStateCopyWithImpl<$Res>
    implements _$ScanStateCopyWith<$Res> {
  __$ScanStateCopyWithImpl(this._self, this._then);

  final _ScanState _self;
  final $Res Function(_ScanState) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isScanning = null,Object? lastResult = freezed,Object? torchEnabled = null,Object? error = freezed,}) {
  return _then(_ScanState(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,lastResult: freezed == lastResult ? _self.lastResult : lastResult // ignore: cast_nullable_to_non_nullable
as ScanResult?,torchEnabled: null == torchEnabled ? _self.torchEnabled : torchEnabled // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanResultCopyWith<$Res>? get lastResult {
    if (_self.lastResult == null) {
    return null;
  }

  return $ScanResultCopyWith<$Res>(_self.lastResult!, (value) {
    return _then(_self.copyWith(lastResult: value));
  });
}
}

// dart format on
