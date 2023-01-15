import 'package:promart/src/features/promart/data/models/getall_cart_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class GetAllCartUsecase {
  GetAllCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllCartModel?> call() async{
    return await _repository.getAllCarts();
  }
}
