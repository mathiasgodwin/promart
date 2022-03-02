// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wishlist_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WishlistEventTearOff {
  const _$WishlistEventTearOff();

  WishAdded added({required AllProductData product}) {
    return WishAdded(
      product: product,
    );
  }
}

/// @nodoc
const $WishlistEvent = _$WishlistEventTearOff();

/// @nodoc
mixin _$WishlistEvent {
  AllProductData get product => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WishAdded value) added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WishAdded value)? added,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishAdded value)? added,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WishlistEventCopyWith<WishlistEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistEventCopyWith<$Res> {
  factory $WishlistEventCopyWith(
          WishlistEvent value, $Res Function(WishlistEvent) then) =
      _$WishlistEventCopyWithImpl<$Res>;
  $Res call({AllProductData product});
}

/// @nodoc
class _$WishlistEventCopyWithImpl<$Res>
    implements $WishlistEventCopyWith<$Res> {
  _$WishlistEventCopyWithImpl(this._value, this._then);

  final WishlistEvent _value;
  // ignore: unused_field
  final $Res Function(WishlistEvent) _then;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AllProductData,
    ));
  }
}

/// @nodoc
abstract class $WishAddedCopyWith<$Res>
    implements $WishlistEventCopyWith<$Res> {
  factory $WishAddedCopyWith(WishAdded value, $Res Function(WishAdded) then) =
      _$WishAddedCopyWithImpl<$Res>;
  @override
  $Res call({AllProductData product});
}

/// @nodoc
class _$WishAddedCopyWithImpl<$Res> extends _$WishlistEventCopyWithImpl<$Res>
    implements $WishAddedCopyWith<$Res> {
  _$WishAddedCopyWithImpl(WishAdded _value, $Res Function(WishAdded) _then)
      : super(_value, (v) => _then(v as WishAdded));

  @override
  WishAdded get _value => super._value as WishAdded;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(WishAdded(
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AllProductData,
    ));
  }
}

/// @nodoc

class _$WishAdded implements WishAdded {
  const _$WishAdded({required this.product});

  @override
  final AllProductData product;

  @override
  String toString() {
    return 'WishlistEvent.added(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WishAdded &&
            const DeepCollectionEquality().equals(other.product, product));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(product));

  @JsonKey(ignore: true)
  @override
  $WishAddedCopyWith<WishAdded> get copyWith =>
      _$WishAddedCopyWithImpl<WishAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
  }) {
    return added(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
  }) {
    return added?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WishAdded value) added,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(WishAdded value)? added,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WishAdded value)? added,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class WishAdded implements WishlistEvent {
  const factory WishAdded({required AllProductData product}) = _$WishAdded;

  @override
  AllProductData get product;
  @override
  @JsonKey(ignore: true)
  $WishAddedCopyWith<WishAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$WishlistStateTearOff {
  const _$WishlistStateTearOff();

  _WishlistState call({required BuiltList<WishlistItem> items}) {
    return _WishlistState(
      items: items,
    );
  }
}

/// @nodoc
const $WishlistState = _$WishlistStateTearOff();

/// @nodoc
mixin _$WishlistState {
  BuiltList<WishlistItem> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WishlistStateCopyWith<WishlistState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistStateCopyWith<$Res> {
  factory $WishlistStateCopyWith(
          WishlistState value, $Res Function(WishlistState) then) =
      _$WishlistStateCopyWithImpl<$Res>;
  $Res call({BuiltList<WishlistItem> items});
}

/// @nodoc
class _$WishlistStateCopyWithImpl<$Res>
    implements $WishlistStateCopyWith<$Res> {
  _$WishlistStateCopyWithImpl(this._value, this._then);

  final WishlistState _value;
  // ignore: unused_field
  final $Res Function(WishlistState) _then;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as BuiltList<WishlistItem>,
    ));
  }
}

/// @nodoc
abstract class _$WishlistStateCopyWith<$Res>
    implements $WishlistStateCopyWith<$Res> {
  factory _$WishlistStateCopyWith(
          _WishlistState value, $Res Function(_WishlistState) then) =
      __$WishlistStateCopyWithImpl<$Res>;
  @override
  $Res call({BuiltList<WishlistItem> items});
}

/// @nodoc
class __$WishlistStateCopyWithImpl<$Res>
    extends _$WishlistStateCopyWithImpl<$Res>
    implements _$WishlistStateCopyWith<$Res> {
  __$WishlistStateCopyWithImpl(
      _WishlistState _value, $Res Function(_WishlistState) _then)
      : super(_value, (v) => _then(v as _WishlistState));

  @override
  _WishlistState get _value => super._value as _WishlistState;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_WishlistState(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as BuiltList<WishlistItem>,
    ));
  }
}

/// @nodoc

class _$_WishlistState implements _WishlistState {
  const _$_WishlistState({required this.items});

  @override
  final BuiltList<WishlistItem> items;

  @override
  String toString() {
    return 'WishlistState(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WishlistState &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$WishlistStateCopyWith<_WishlistState> get copyWith =>
      __$WishlistStateCopyWithImpl<_WishlistState>(this, _$identity);
}

abstract class _WishlistState implements WishlistState {
  const factory _WishlistState({required BuiltList<WishlistItem> items}) =
      _$_WishlistState;

  @override
  BuiltList<WishlistItem> get items;
  @override
  @JsonKey(ignore: true)
  _$WishlistStateCopyWith<_WishlistState> get copyWith =>
      throw _privateConstructorUsedError;
}
