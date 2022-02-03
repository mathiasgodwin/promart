part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  const CategoriesLoaded(this.categories);

  final AllCategoryModel categories;
  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String? errorMessage;

  const CategoriesError(this.errorMessage);
}
