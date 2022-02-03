import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/datasources/remote/remote_datasource.dart';
import 'package:promart/src/features/promart/data/models/getall_category_model.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/domain/domain.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoading());

  final _repository = PromartRepository(dataSource: RemoteDataSource());
  late final _getCategories = GetAllCategoryUsecase(repository: _repository);

  void getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await _getCategories();

      emit(CategoriesLoaded(categories!));
    } on GetRemoteException catch (e) {
      emit(CategoriesError(e.message));
    } catch (e) {
      emit(const CategoriesError("Failed to Load"));
    }
  }
}
