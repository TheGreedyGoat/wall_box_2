// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DatabaseChangeState {

 int get address; int get company; int get contact; int get customer; int get personal; int get priceAssignment; int get tagAssignment; int get transaction; int get customerPackage;
/// Create a copy of DatabaseChangeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseChangeStateCopyWith<DatabaseChangeState> get copyWith => _$DatabaseChangeStateCopyWithImpl<DatabaseChangeState>(this as DatabaseChangeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseChangeState&&(identical(other.address, address) || other.address == address)&&(identical(other.company, company) || other.company == company)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.personal, personal) || other.personal == personal)&&(identical(other.priceAssignment, priceAssignment) || other.priceAssignment == priceAssignment)&&(identical(other.tagAssignment, tagAssignment) || other.tagAssignment == tagAssignment)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.customerPackage, customerPackage) || other.customerPackage == customerPackage));
}


@override
int get hashCode => Object.hash(runtimeType,address,company,contact,customer,personal,priceAssignment,tagAssignment,transaction,customerPackage);

@override
String toString() {
  return 'DatabaseChangeState(address: $address, company: $company, contact: $contact, customer: $customer, personal: $personal, priceAssignment: $priceAssignment, tagAssignment: $tagAssignment, transactRepo: $transaction, customerPackage: $customerPackage)';
}


}

/// @nodoc
abstract mixin class $DatabaseChangeStateCopyWith<$Res>  {
  factory $DatabaseChangeStateCopyWith(DatabaseChangeState value, $Res Function(DatabaseChangeState) _then) = _$DatabaseChangeStateCopyWithImpl;
@useResult
$Res call({
 int address, int company, int contact, int customer, int personal, int priceAssignment, int tagAssignment, int transactRepo
});




}
/// @nodoc
class _$DatabaseChangeStateCopyWithImpl<$Res>
    implements $DatabaseChangeStateCopyWith<$Res> {
  _$DatabaseChangeStateCopyWithImpl(this._self, this._then);

  final DatabaseChangeState _self;
  final $Res Function(DatabaseChangeState) _then;

/// Create a copy of DatabaseChangeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? company = null,Object? contact = null,Object? customer = null,Object? personal = null,Object? priceAssignment = null,Object? tagAssignment = null,Object? transactRepo = null,}) {
  return _then(DatabaseChangeState(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as int,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as int,contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as int,customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as int,personal: null == personal ? _self.personal : personal // ignore: cast_nullable_to_non_nullable
as int,priceAssignment: null == priceAssignment ? _self.priceAssignment : priceAssignment // ignore: cast_nullable_to_non_nullable
as int,tagAssignment: null == tagAssignment ? _self.tagAssignment : tagAssignment // ignore: cast_nullable_to_non_nullable
as int,transaction: null == transactRepo ? _self.transaction : transactRepo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DatabaseChangeState].
extension DatabaseChangeStatePatterns on DatabaseChangeState {
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
