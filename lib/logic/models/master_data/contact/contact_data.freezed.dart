// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactData {

 String get customerID; Phone? get phone; Phone? get mobile; Phone? get fax; Email? get email; String? get website;
/// Create a copy of ContactData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactDataCopyWith<ContactData> get copyWith => _$ContactDataCopyWithImpl<ContactData>(this as ContactData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactData&&(identical(other.customerID, customerID) || other.customerID == customerID)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.fax, fax) || other.fax == fax)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website));
}


@override
int get hashCode => Object.hash(runtimeType,customerID,phone,mobile,fax,email,website);

@override
String toString() {
  return 'ContactData(customerID: $customerID, phone: $phone, mobile: $mobile, fax: $fax, email: $email, website: $website)';
}


}

/// @nodoc
abstract mixin class $ContactDataCopyWith<$Res>  {
  factory $ContactDataCopyWith(ContactData value, $Res Function(ContactData) _then) = _$ContactDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: ContactColumns.customer_id) String customerID,@JsonKey(name: ContactColumns.phone)@PhoneJsonConverter() Phone? phone,@JsonKey(name: ContactColumns.mobile)@PhoneJsonConverter() Phone? mobile,@JsonKey(name: ContactColumns.fax)@PhoneJsonConverter() Phone? fax,@JsonKey(name: ContactColumns.email)@EmailJsonConverter() Email? email,@JsonKey(name: ContactColumns.website) String? website
});




}
/// @nodoc
class _$ContactDataCopyWithImpl<$Res>
    implements $ContactDataCopyWith<$Res> {
  _$ContactDataCopyWithImpl(this._self, this._then);

  final ContactData _self;
  final $Res Function(ContactData) _then;

/// Create a copy of ContactData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerID = null,Object? phone = freezed,Object? mobile = freezed,Object? fax = freezed,Object? email = freezed,Object? website = freezed,}) {
  return _then(ContactData(
customerID: null == customerID ? _self.customerID : customerID // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as Phone?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as Phone?,fax: freezed == fax ? _self.fax : fax // ignore: cast_nullable_to_non_nullable
as Phone?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactData].
extension ContactDataPatterns on ContactData {
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
