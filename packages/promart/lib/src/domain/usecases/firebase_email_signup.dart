import 'package:promart/promart.dart';

class FirebaseEmailSignUp {
  FirebaseEmailSignUp({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<String?> call({String? email, String? password}) async =>
      await _repository.emailSignUp(email: email, password: password);
}
