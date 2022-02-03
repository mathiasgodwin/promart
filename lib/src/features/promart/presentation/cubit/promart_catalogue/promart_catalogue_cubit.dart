import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/datasources/remote/remote_datasource.dart';
import 'package:promart/src/features/promart/data/models/all_products_model.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/domain/usecases/all_product_usecase.dart';

part 'promart_catalogue_state.dart';

class PromartCatalogCubit extends Cubit<PromartCatalogState> {
  PromartCatalogCubit() : super(PromartCatalogLoading());

  final _repository = PromartRepository(dataSource: RemoteDataSource());
  late final _getAllCatalog = GetAllProductUsecase(repository: _repository);

  void loadCatalog({String? sort, String? limit}) async {
    emit(PromartCatalogLoading());
    try {
      final catalog = await _getAllCatalog(sort: sort, limit: limit);
      emit(PromartCatalogLoaded(catalog!));
    } on GetRemoteException catch (e) {
      emit(PromartCatalogError(e.message));
    } catch (e) {
      emit(PromartCatalogError(e.toString()));
    }
  }
}
