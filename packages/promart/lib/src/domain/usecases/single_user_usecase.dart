import 'package:promart/promart.dart';

class SingleUserUsecase {
  SingleUserUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<SingleUserModel?> call(String userId) async {
    return _repository.getSingleUser(userId: userId);
  }
}
