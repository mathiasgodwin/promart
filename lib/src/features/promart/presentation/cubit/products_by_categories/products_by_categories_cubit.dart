import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/domain/usecases/get_product_by_category.dart';

part 'products_by_categories_state.dart';

class ProductsByCategoriesCubit extends Cubit<ProductsByCategoriesState> {
  ProductsByCategoriesCubit() : super(ProductsByCategoriesLoading());

  final _repository = PromartRepository(dataSource: RemoteDataSource());
  late final _getProducts = GetProductByCategory(repository: _repository);

  void getProductsByCategory(String category,
      {String? limit, String? sort}) async {
    emit(ProductsByCategoriesLoading());
    try {
      final product = await _getProducts(
          category: category, sort: sort ?? 'dsc', limit: limit ?? '20');
      emit(ProductsByCategoriesLoaded(product!));
    } on GetRemoteException catch (e) {
      emit(ProductsByCategoriesError(e.message));
    } catch (e) {
      emit(const ProductsByCategoriesError("Failed to Load"));
    }
  }
}
