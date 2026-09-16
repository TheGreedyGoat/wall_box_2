// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_assignment_edit_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TagAssignmentEditState {

 List<TagAssignment> get originals; List<TagAssignment> get newAssignments;
/// Create a copy of TagAssignmentEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagAssignmentEditStateCopyWith<TagAssignmentEditState> get copyWith => _$TagAssignmentEditStateCopyWithImpl<TagAssignmentEditState>(this as TagAssignmentEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagAssignmentEditState&&const DeepCollectionEquality().equals(other.originals, originals)&&const DeepCollectionEquality().equals(other.newAssignments, newAssignments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originals),const DeepCollectionEquality().hash(newAssignments));

@override
String toString() {
  return 'TagAssignmentEditState(originals: $originals, newAssignments: $newAssignments)';
}


}

/// @nodoc
abstract mixin class $TagAssignmentEditStateCopyWith<$Res>  {
  factory $TagAssignmentEditStateCopyWith(TagAssignmentEditState value, $Res Function(TagAssignmentEditState) _then) = _$TagAssignmentEditStateCopyWithImpl;
@useResult
$Res call({
 List<TagAssignment> originals, List<TagAssignment> newAssignments
});




}
/// @nodoc
class _$TagAssignmentEditStateCopyWithImpl<$Res>
    implements $TagAssignmentEditStateCopyWith<$Res> {
  _$TagAssignmentEditStateCopyWithImpl(this._self, this._then);

  final TagAssignmentEditState _self;
  final $Res Function(TagAssignmentEditState) _then;

/// Create a copy of TagAssignmentEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originals = null,Object? newAssignments = null,}) {
  return _then(TagAssignmentEditState(
originals: null == originals ? _self.originals : originals // ignore: cast_nullable_to_non_nullable
as List<TagAssignment>,newAssignments: null == newAssignments ? _self.newAssignments : newAssignments // ignore: cast_nullable_to_non_nullable
as List<TagAssignment>,
  ));
}

}


/// Adds pattern-matching-related methods to [TagAssignmentEditState].
extension TagAssignmentEditStatePatterns on TagAssignmentEditState {
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
