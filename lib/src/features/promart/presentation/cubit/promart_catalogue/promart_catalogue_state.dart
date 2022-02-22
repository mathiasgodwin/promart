part of 'promart_catalogue_cubit.dart';

enum PromartCatalogStatus {initial, loading, loaded, failure }

class PromartCatalogState extends Equatable {
  final PromartCatalogStatus status;
  final AllProductModel? catalog;
  final String? errorMessage;

  const PromartCatalogState(
      {this.status = PromartCatalogStatus.initial,
      this.catalog,
      this.errorMessage});

  @override
  List<Object?> get props => [status, catalog, errorMessage];

  PromartCatalogState copyWith({
    PromartCatalogStatus? status,
    AllProductModel? catalog,
    String? errorMessage,
  }) {
    return PromartCatalogState(
      status: status ?? this.status,
      catalog: catalog ?? this.catalog,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
