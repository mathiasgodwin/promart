part of 'categories_cubit.dart';

enum CategoriesStatus { loading, loaded, failure }

class CategoriesState extends Equatable {
  final CategoriesStatus status;
  final AllCategoryModel categories;
  final String errorMessage;
  const CategoriesState({
    this.status = CategoriesStatus.loading,
    this.categories = AllCategoryModel.empty,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [status, categories, errorMessage];

  CategoriesState copyWith({
    CategoriesStatus? status,
    AllCategoryModel? categories,
    String? errorMessage,
  }) {
    return CategoriesState(
        status: status ?? this.status,
        categories: categories ?? this.categories,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
