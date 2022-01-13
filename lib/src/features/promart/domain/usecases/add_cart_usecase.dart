import 'package:promart/src/features/promart/data/models/add_cart_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class AddToCartUsecase {
  AddToCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AddCartModel?> call(AddCartModel carts) async{
    return await _repository.addCart(carts: carts);
  }
}
