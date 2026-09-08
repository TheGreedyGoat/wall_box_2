// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wall_box_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WallBoxTransaction {

 String get id; String get tagID; String get wallboxID; DateTime get start; DateTime get stop; KiloWattHour get usage;
/// Create a copy of WallBoxTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WallBoxTransactionCopyWith<WallBoxTransaction> get copyWith => _$WallBoxTransactionCopyWithImpl<WallBoxTransaction>(this as WallBoxTransaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WallBoxTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.tagID, tagID) || other.tagID == tagID)&&(identical(other.wallboxID, wallboxID) || other.wallboxID == wallboxID)&&(identical(other.start, start) || other.start == start)&&(identical(other.stop, stop) || other.stop == stop)&&(identical(other.usage, usage) || other.usage == usage));
}


@override
int get hashCode => Object.hash(runtimeType,id,tagID,wallboxID,start,stop,usage);

@override
String toString() {
  return 'WallBoxTransaction(id: $id, tagID: $tagID, wallboxID: $wallboxID, start: $start, stop: $stop, usage: $usage)';
}


}

/// @nodoc
abstract mixin class $WallBoxTransactionCopyWith<$Res>  {
  factory $WallBoxTransactionCopyWith(WallBoxTransaction value, $Res Function(WallBoxTransaction) _then) = _$WallBoxTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String tagID, String wallboxID, DateTime start, DateTime stop,@KiloWattHourConverter()@JsonKey(name: 'usage') KiloWattHour usage
});




}
/// @nodoc
class _$WallBoxTransactionCopyWithImpl<$Res>
    implements $WallBoxTransactionCopyWith<$Res> {
  _$WallBoxTransactionCopyWithImpl(this._self, this._then);

  final WallBoxTransaction _self;
  final $Res Function(WallBoxTransaction) _then;

/// Create a copy of WallBoxTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tagID = null,Object? wallboxID = null,Object? start = null,Object? stop = null,Object? usage = null,}) {
  return _then(WallBoxTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tagID: null == tagID ? _self.tagID : tagID // ignore: cast_nullable_to_non_nullable
as String,wallboxID: null == wallboxID ? _self.wallboxID : wallboxID // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,stop: null == stop ? _self.stop : stop // ignore: cast_nullable_to_non_nullable
as DateTime,usage: null == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as KiloWattHour,
  ));
}

}


/// Adds pattern-matching-related methods to [WallBoxTransaction].
extension WallBoxTransactionPatterns on WallBoxTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
