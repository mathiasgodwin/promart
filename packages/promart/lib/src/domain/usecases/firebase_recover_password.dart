import 'package:promart/promart.dart';

class FirebaseRecoverPassword {
  FirebaseRecoverPassword({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;
  Future<String?> call({String? email}) async =>
      await _repository.passwordRecovery(email: email);
}
