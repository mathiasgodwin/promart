import 'package:promart/src/features/promart/data/models/login_token_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class LoginUserUsecase {
  LoginUserUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<LoginTokenModel?> call({String? password, String? username}) async {
    return await  _repository.loginUser(password: password!, username: username!);
  }
}
