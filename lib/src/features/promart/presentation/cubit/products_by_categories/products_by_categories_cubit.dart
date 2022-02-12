import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/domain/usecases/get_product_by_category.dart';

part 'products_by_categories_state.dart';

class ProductsByCategoriesCubit extends Cubit<ProductsByCategoriesState> {
  final PromartRepository repository;
  ProductsByCategoriesCubit({required this.repository})
      : super(const ProductsByCategoriesState());

  late final _getProducts = GetProductByCategory(repository: repository);

  void getProductsByCategory(String category,
      {String? limit, String? sort}) async {
    emit(state.copyWith(status: ProductByCategoriesStatus.loading));
    try {
      final product = await _getProducts(
          category: category, sort: sort ?? 'dsc', limit: limit ?? '20');
      emit(state.copyWith(
          status: ProductByCategoriesStatus.loaded, products: product));
    } on GetRemoteException catch (e) {
      emit(state.copyWith(
          status: ProductByCategoriesStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: ProductByCategoriesStatus.failure,
          errorMessage: 'Request was not successful, try again'));
    }
  }
}
