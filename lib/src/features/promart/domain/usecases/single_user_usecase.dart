import 'package:promart/src/features/promart/data/models/single_user_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class SingleUserUsecase {
  SingleUserUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<SingleUserModel?> call(String userId) async {
    return _repository.getSingleUser(userId: userId);
  }
}
