import 'package:promart/promart.dart';

class GetAllUsersUsecase {
  GetAllUsersUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllUserModel?> call()async {
    return await _repository.getAllUsers();
  }
}
