import 'package:promart/promart.dart';

class SingleCartUsecase {
  SingleCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<SingleCartModel?> call(String cartId) async {
    return await _repository.getSingleCart(cartId: cartId);
  }
}
