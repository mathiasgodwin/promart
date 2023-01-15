import 'package:promart/promart.dart';

class LoginUserUsecase {
  LoginUserUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<LoginTokenModel?> call({String? password, String? username}) async {
    return await  _repository.loginUser(password: password!, username: username!);
  }
}
