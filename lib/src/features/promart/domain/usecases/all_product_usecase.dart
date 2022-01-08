import 'package:promart/src/features/promart/data/models/all_products_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class GetAllProductUsecase {
  GetAllProductUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllProductModel?> call() async {
    return await _repository.getAllProducts();
  }
}
