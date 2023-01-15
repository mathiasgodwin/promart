import 'package:promart/promart.dart';

class GetAllCartUsecase {
  GetAllCartUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllCartModel?> call() async{
    return await _repository.getAllCarts();
  }
}
