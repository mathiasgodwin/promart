part of 'promart_catalogue_cubit.dart';

abstract class PromartCatalogState extends Equatable {
  const PromartCatalogState();

  @override
  List<Object> get props => [];
}

class PromartCatalogLoading extends PromartCatalogState {}

class PromartCatalogLoaded extends PromartCatalogState {
  const PromartCatalogLoaded(this.catalog);

  // We have products inside catalogues
  // So we're using the product model.
  final AllProductModel catalog;

  @override
  List<Object> get props => [catalog];
}

class PromartCatalogError extends PromartCatalogState {
  final String? errorMessage;
  const PromartCatalogError(this.errorMessage);
}
