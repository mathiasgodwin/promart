import 'package:promart/promart.dart';

class DeleteCartUsecase {
  DeleteCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<DeleteCartModel?> call({required String cartId}) async
  {
    return await  _repository.deleteCart(cartId: cartId);
  }
}
