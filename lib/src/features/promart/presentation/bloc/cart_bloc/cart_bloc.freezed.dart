// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cart_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CartEventTearOff {
  const _$CartEventTearOff();

  ProductAdded added({required AllProductData product}) {
    return ProductAdded(
      product: product,
    );
  }

  CartItemRemoved removed({required CartItem item}) {
    return CartItemRemoved(
      item: item,
    );
  }

  CartItemCountIncreased countIncreased({required CartItem item}) {
    return CartItemCountIncreased(
      item: item,
    );
  }

  CartItemCountDecreased countDecreased({required CartItem item}) {
    return CartItemCountDecreased(
      item: item,
    );
  }
}

/// @nodoc
const $CartEvent = _$CartEventTearOff();

/// @nodoc
mixin _$CartEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
    required TResult Function(CartItem item) removed,
    required TResult Function(CartItem item) countIncreased,
    required TResult Function(CartItem item) countDecreased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductAdded value) added,
    required TResult Function(CartItemRemoved value) removed,
    required TResult Function(CartItemCountIncreased value) countIncreased,
    required TResult Function(CartItemCountDecreased value) countDecreased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartEventCopyWith<$Res> {
  factory $CartEventCopyWith(CartEvent value, $Res Function(CartEvent) then) =
      _$CartEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$CartEventCopyWithImpl<$Res> implements $CartEventCopyWith<$Res> {
  _$CartEventCopyWithImpl(this._value, this._then);

  final CartEvent _value;
  // ignore: unused_field
  final $Res Function(CartEvent) _then;
}

/// @nodoc
abstract class $ProductAddedCopyWith<$Res> {
  factory $ProductAddedCopyWith(
          ProductAdded value, $Res Function(ProductAdded) then) =
      _$ProductAddedCopyWithImpl<$Res>;
  $Res call({AllProductData product});
}

/// @nodoc
class _$ProductAddedCopyWithImpl<$Res> extends _$CartEventCopyWithImpl<$Res>
    implements $ProductAddedCopyWith<$Res> {
  _$ProductAddedCopyWithImpl(
      ProductAdded _value, $Res Function(ProductAdded) _then)
      : super(_value, (v) => _then(v as ProductAdded));

  @override
  ProductAdded get _value => super._value as ProductAdded;

  @override
  $Res call({
    Object? product = freezed,
  }) {
    return _then(ProductAdded(
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AllProductData,
    ));
  }
}

/// @nodoc

class _$ProductAdded implements ProductAdded {
  const _$ProductAdded({required this.product});

  @override
  final AllProductData product;

  @override
  String toString() {
    return 'CartEvent.added(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductAdded &&
            const DeepCollectionEquality().equals(other.product, product));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(product));

  @JsonKey(ignore: true)
  @override
  $ProductAddedCopyWith<ProductAdded> get copyWith =>
      _$ProductAddedCopyWithImpl<ProductAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
    required TResult Function(CartItem item) removed,
    required TResult Function(CartItem item) countIncreased,
    required TResult Function(CartItem item) countDecreased,
  }) {
    return added(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
  }) {
    return added?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
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
    required TResult Function(ProductAdded value) added,
    required TResult Function(CartItemRemoved value) removed,
    required TResult Function(CartItemCountIncreased value) countIncreased,
    required TResult Function(CartItemCountDecreased value) countDecreased,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class ProductAdded implements CartEvent {
  const factory ProductAdded({required AllProductData product}) =
      _$ProductAdded;

  AllProductData get product;
  @JsonKey(ignore: true)
  $ProductAddedCopyWith<ProductAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemRemovedCopyWith<$Res> {
  factory $CartItemRemovedCopyWith(
          CartItemRemoved value, $Res Function(CartItemRemoved) then) =
      _$CartItemRemovedCopyWithImpl<$Res>;
  $Res call({CartItem item});

  $CartItemCopyWith<$Res> get item;
}

/// @nodoc
class _$CartItemRemovedCopyWithImpl<$Res> extends _$CartEventCopyWithImpl<$Res>
    implements $CartItemRemovedCopyWith<$Res> {
  _$CartItemRemovedCopyWithImpl(
      CartItemRemoved _value, $Res Function(CartItemRemoved) _then)
      : super(_value, (v) => _then(v as CartItemRemoved));

  @override
  CartItemRemoved get _value => super._value as CartItemRemoved;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(CartItemRemoved(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as CartItem,
    ));
  }

  @override
  $CartItemCopyWith<$Res> get item {
    return $CartItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$CartItemRemoved implements CartItemRemoved {
  const _$CartItemRemoved({required this.item});

  @override
  final CartItem item;

  @override
  String toString() {
    return 'CartEvent.removed(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CartItemRemoved &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  $CartItemRemovedCopyWith<CartItemRemoved> get copyWith =>
      _$CartItemRemovedCopyWithImpl<CartItemRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
    required TResult Function(CartItem item) removed,
    required TResult Function(CartItem item) countIncreased,
    required TResult Function(CartItem item) countDecreased,
  }) {
    return removed(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
  }) {
    return removed?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
    required TResult orElse(),
  }) {
    if (removed != null) {
      return removed(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductAdded value) added,
    required TResult Function(CartItemRemoved value) removed,
    required TResult Function(CartItemCountIncreased value) countIncreased,
    required TResult Function(CartItemCountDecreased value) countDecreased,
  }) {
    return removed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
  }) {
    return removed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
    required TResult orElse(),
  }) {
    if (removed != null) {
      return removed(this);
    }
    return orElse();
  }
}

abstract class CartItemRemoved implements CartEvent {
  const factory CartItemRemoved({required CartItem item}) = _$CartItemRemoved;

  CartItem get item;
  @JsonKey(ignore: true)
  $CartItemRemovedCopyWith<CartItemRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCountIncreasedCopyWith<$Res> {
  factory $CartItemCountIncreasedCopyWith(CartItemCountIncreased value,
          $Res Function(CartItemCountIncreased) then) =
      _$CartItemCountIncreasedCopyWithImpl<$Res>;
  $Res call({CartItem item});

  $CartItemCopyWith<$Res> get item;
}

/// @nodoc
class _$CartItemCountIncreasedCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res>
    implements $CartItemCountIncreasedCopyWith<$Res> {
  _$CartItemCountIncreasedCopyWithImpl(CartItemCountIncreased _value,
      $Res Function(CartItemCountIncreased) _then)
      : super(_value, (v) => _then(v as CartItemCountIncreased));

  @override
  CartItemCountIncreased get _value => super._value as CartItemCountIncreased;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(CartItemCountIncreased(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as CartItem,
    ));
  }

  @override
  $CartItemCopyWith<$Res> get item {
    return $CartItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$CartItemCountIncreased implements CartItemCountIncreased {
  const _$CartItemCountIncreased({required this.item});

  @override
  final CartItem item;

  @override
  String toString() {
    return 'CartEvent.countIncreased(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CartItemCountIncreased &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  $CartItemCountIncreasedCopyWith<CartItemCountIncreased> get copyWith =>
      _$CartItemCountIncreasedCopyWithImpl<CartItemCountIncreased>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
    required TResult Function(CartItem item) removed,
    required TResult Function(CartItem item) countIncreased,
    required TResult Function(CartItem item) countDecreased,
  }) {
    return countIncreased(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
  }) {
    return countIncreased?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
    required TResult orElse(),
  }) {
    if (countIncreased != null) {
      return countIncreased(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductAdded value) added,
    required TResult Function(CartItemRemoved value) removed,
    required TResult Function(CartItemCountIncreased value) countIncreased,
    required TResult Function(CartItemCountDecreased value) countDecreased,
  }) {
    return countIncreased(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
  }) {
    return countIncreased?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
    required TResult orElse(),
  }) {
    if (countIncreased != null) {
      return countIncreased(this);
    }
    return orElse();
  }
}

abstract class CartItemCountIncreased implements CartEvent {
  const factory CartItemCountIncreased({required CartItem item}) =
      _$CartItemCountIncreased;

  CartItem get item;
  @JsonKey(ignore: true)
  $CartItemCountIncreasedCopyWith<CartItemCountIncreased> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCountDecreasedCopyWith<$Res> {
  factory $CartItemCountDecreasedCopyWith(CartItemCountDecreased value,
          $Res Function(CartItemCountDecreased) then) =
      _$CartItemCountDecreasedCopyWithImpl<$Res>;
  $Res call({CartItem item});

  $CartItemCopyWith<$Res> get item;
}

/// @nodoc
class _$CartItemCountDecreasedCopyWithImpl<$Res>
    extends _$CartEventCopyWithImpl<$Res>
    implements $CartItemCountDecreasedCopyWith<$Res> {
  _$CartItemCountDecreasedCopyWithImpl(CartItemCountDecreased _value,
      $Res Function(CartItemCountDecreased) _then)
      : super(_value, (v) => _then(v as CartItemCountDecreased));

  @override
  CartItemCountDecreased get _value => super._value as CartItemCountDecreased;

  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(CartItemCountDecreased(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as CartItem,
    ));
  }

  @override
  $CartItemCopyWith<$Res> get item {
    return $CartItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$CartItemCountDecreased implements CartItemCountDecreased {
  const _$CartItemCountDecreased({required this.item});

  @override
  final CartItem item;

  @override
  String toString() {
    return 'CartEvent.countDecreased(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CartItemCountDecreased &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  $CartItemCountDecreasedCopyWith<CartItemCountDecreased> get copyWith =>
      _$CartItemCountDecreasedCopyWithImpl<CartItemCountDecreased>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AllProductData product) added,
    required TResult Function(CartItem item) removed,
    required TResult Function(CartItem item) countIncreased,
    required TResult Function(CartItem item) countDecreased,
  }) {
    return countDecreased(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
  }) {
    return countDecreased?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AllProductData product)? added,
    TResult Function(CartItem item)? removed,
    TResult Function(CartItem item)? countIncreased,
    TResult Function(CartItem item)? countDecreased,
    required TResult orElse(),
  }) {
    if (countDecreased != null) {
      return countDecreased(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductAdded value) added,
    required TResult Function(CartItemRemoved value) removed,
    required TResult Function(CartItemCountIncreased value) countIncreased,
    required TResult Function(CartItemCountDecreased value) countDecreased,
  }) {
    return countDecreased(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
  }) {
    return countDecreased?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductAdded value)? added,
    TResult Function(CartItemRemoved value)? removed,
    TResult Function(CartItemCountIncreased value)? countIncreased,
    TResult Function(CartItemCountDecreased value)? countDecreased,
    required TResult orElse(),
  }) {
    if (countDecreased != null) {
      return countDecreased(this);
    }
    return orElse();
  }
}

abstract class CartItemCountDecreased implements CartEvent {
  const factory CartItemCountDecreased({required CartItem item}) =
      _$CartItemCountDecreased;

  CartItem get item;
  @JsonKey(ignore: true)
  $CartItemCountDecreasedCopyWith<CartItemCountDecreased> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CartStateTearOff {
  const _$CartStateTearOff();

  _CartState call({required BuiltList<CartItem> items}) {
    return _CartState(
      items: items,
    );
  }
}

/// @nodoc
const $CartState = _$CartStateTearOff();

/// @nodoc
mixin _$CartState {
  BuiltList<CartItem> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res>;
  $Res call({BuiltList<CartItem> items});
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res> implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  final CartState _value;
  // ignore: unused_field
  final $Res Function(CartState) _then;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as BuiltList<CartItem>,
    ));
  }
}

/// @nodoc
abstract class _$CartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(
          _CartState value, $Res Function(_CartState) then) =
      __$CartStateCopyWithImpl<$Res>;
  @override
  $Res call({BuiltList<CartItem> items});
}

/// @nodoc
class __$CartStateCopyWithImpl<$Res> extends _$CartStateCopyWithImpl<$Res>
    implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(_CartState _value, $Res Function(_CartState) _then)
      : super(_value, (v) => _then(v as _CartState));

  @override
  _CartState get _value => super._value as _CartState;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_CartState(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as BuiltList<CartItem>,
    ));
  }
}

/// @nodoc

class _$_CartState implements _CartState {
  const _$_CartState({required this.items});

  @override
  final BuiltList<CartItem> items;

  @override
  String toString() {
    return 'CartState(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CartState &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$CartStateCopyWith<_CartState> get copyWith =>
      __$CartStateCopyWithImpl<_CartState>(this, _$identity);
}

abstract class _CartState implements CartState {
  const factory _CartState({required BuiltList<CartItem> items}) = _$_CartState;

  @override
  BuiltList<CartItem> get items;
  @override
  @JsonKey(ignore: true)
  _$CartStateCopyWith<_CartState> get copyWith =>
      throw _privateConstructorUsedError;
}
