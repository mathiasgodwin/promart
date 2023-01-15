import 'package:promart/promart.dart';

class GetAllProductUsecase {
  GetAllProductUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllProductModel?> call({String? sort, String? limit}) async {
    return await _repository.getAllProducts(
        sort: sort ?? 'dsc', limit: limit ?? '20');
  }
}
