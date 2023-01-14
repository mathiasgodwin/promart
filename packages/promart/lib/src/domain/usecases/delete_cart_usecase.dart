import 'package:promart/src/features/promart/data/models/delete_cart_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class DeleteCartUsecase {
  DeleteCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<DeleteCartModel?> call({required String cartId}) async
  {
    return await  _repository.deleteCart(cartId: cartId);
  }
}
