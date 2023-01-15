import 'package:bloc/bloc.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:promart_api/promart.dart';

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
    } on NetworkException catch (e) {
      emit(state.copyWith(
          status: CategoriesStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: CategoriesStatus.failure,
          errorMessage: 'Could not load categories, try again'));
    }
  }
}
