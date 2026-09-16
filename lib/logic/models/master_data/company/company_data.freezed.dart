// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyData {

 String get customerID; String? get companyName; String? get companyAddition;
/// Create a copy of CompanyData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyDataCopyWith<CompanyData> get copyWith => _$CompanyDataCopyWithImpl<CompanyData>(this as CompanyData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyData&&(identical(other.customerID, customerID) || other.customerID == customerID)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyAddition, companyAddition) || other.companyAddition == companyAddition));
}


@override
int get hashCode => Object.hash(runtimeType,customerID,companyName,companyAddition);

@override
String toString() {
  return 'CompanyData(customerID: $customerID, companyName: $companyName, companyAddition: $companyAddition)';
}


}

/// @nodoc
abstract mixin class $CompanyDataCopyWith<$Res>  {
  factory $CompanyDataCopyWith(CompanyData value, $Res Function(CompanyData) _then) = _$CompanyDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: CompanyColumns.customer_id) String customerID,@JsonKey(name: CompanyColumns.company_name) String? companyName,@JsonKey(name: CompanyColumns.company_addition) String? companyAddition
});




}
/// @nodoc
class _$CompanyDataCopyWithImpl<$Res>
    implements $CompanyDataCopyWith<$Res> {
  _$CompanyDataCopyWithImpl(this._self, this._then);

  final CompanyData _self;
  final $Res Function(CompanyData) _then;

/// Create a copy of CompanyData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerID = null,Object? companyName = freezed,Object? companyAddition = freezed,}) {
  return _then(CompanyData(
customerID: null == customerID ? _self.customerID : customerID // ignore: cast_nullable_to_non_nullable
as String,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,companyAddition: freezed == companyAddition ? _self.companyAddition : companyAddition // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyData].
extension CompanyDataPatterns on CompanyData {
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
