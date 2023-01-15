import 'package:promart/promart.dart';

class AddToCartUsecase {
  AddToCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AddCartModel?> call(AddCartModel carts) async {
    return await _repository.addCart(carts: carts);
  }
}
