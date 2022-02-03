import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/datasources/remote/remote_datasource.dart';
import 'package:promart/src/features/promart/data/models/single_product_model.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/domain/domain.dart';

part 'single_product_state.dart';

class SingleProductCubit extends Cubit<SingleProductState> {
  SingleProductCubit() : super(SingleProductLoading());

  final _repository = PromartRepository(dataSource: RemoteDataSource());

  late final _getSingleProduct = SingleProductUsecase(repository: _repository);

  void getSingleProduct(String productId) async {
    emit(SingleProductLoading());
    try {
      final product = await _getSingleProduct(productId);
      emit(SingleProductLoaded(product!));
    } on GetRemoteException catch (e) {
      emit(SingleProductError(e.message));
    } catch (e) {
      emit(SingleProductError(e.toString()));
    }
  }
}
