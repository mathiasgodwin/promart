import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/models/getall_category_model.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/domain/domain.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final PromartRepository repository;
  CategoriesCubit({required this.repository}) : super(const CategoriesState());

  late final _getCategories = GetAllCategoryUsecase(repository: repository);

  void getCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      final categories = await _getCategories();

      emit(state.copyWith(
          status: CategoriesStatus.loaded, categories: categories));
    } on GetRemoteException catch (e) {
      emit(state.copyWith(
          status: CategoriesStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: CategoriesStatus.failure,
          errorMessage: 'Could not load categories, try again'));
    }
  }
}
