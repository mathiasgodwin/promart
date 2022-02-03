part of 'products_by_categories_cubit.dart';

abstract class ProductsByCategoriesState extends Equatable {
  const ProductsByCategoriesState();

  @override
  List<Object> get props => [];
}

class ProductsByCategoriesLoading extends ProductsByCategoriesState {}

class ProductsByCategoriesLoaded extends ProductsByCategoriesState {
  const ProductsByCategoriesLoaded(this.products);

  final AllProductModel products;

  @override
  List<Object> get props => [products];
}

class ProductsByCategoriesError extends ProductsByCategoriesState {
  final String? errorMessage;
  const ProductsByCategoriesError(this.errorMessage);
}
