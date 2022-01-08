import 'package:promart/src/features/promart/data/models/single_cart_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class SingleCartUsecase {
  SingleCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<SingleCartModel?> call(String cartId) async {
    return await _repository.getSingleCart(cartId: cartId);
  }
}
