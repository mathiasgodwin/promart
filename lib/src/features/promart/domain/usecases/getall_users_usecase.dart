import 'package:promart/src/features/promart/data/models/getall_users_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class GetAllUsersUsecase {
  GetAllUsersUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllUserModel?> call()async {
    return await _repository.getAllUsers();
  }
}
