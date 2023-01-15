import 'package:promart/promart.dart';

class SingleProductUsecase {
  SingleProductUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<SingleProductModel?> call(String productId) async {
    return _repository.getSingleProduct(productId: productId);
  }
}
