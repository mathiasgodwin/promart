part of 'single_product_cubit.dart';

abstract class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object> get props => [];
}

class SingleProductLoading extends SingleProductState {}

class SingleProductLoaded extends SingleProductState {
  const SingleProductLoaded(this.product);

  // So we're using the product model.
  final SingleProductModel product;

  @override
  List<Object> get props => [product];
}

class SingleProductError extends SingleProductState {
  final String? errorMessage;
  const SingleProductError(this.errorMessage);
}
