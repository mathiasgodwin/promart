part of 'products_by_categories_cubit.dart';

enum ProductByCategoriesStatus { loading, loaded, failure }

class ProductsByCategoriesState extends Equatable {
  final ProductByCategoriesStatus status;
  final AllProductModel? products;
  final String? errorMessage;

  const ProductsByCategoriesState(
      {this.status = ProductByCategoriesStatus.loading,
      this.products,
      this.errorMessage});

  @override
  List<Object?> get props => [status, products, errorMessage];

  ProductsByCategoriesState copyWith({
    ProductByCategoriesStatus? status,
    AllProductModel? products,
    String? errorMessage,
  }) {
    return ProductsByCategoriesState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
