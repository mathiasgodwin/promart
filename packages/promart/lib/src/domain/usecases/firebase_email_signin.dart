import 'package:promart/promart.dart';

class FirebaseEmailSignIn {
  FirebaseEmailSignIn({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<String?> call({String? email, String? password}) async =>
      await _repository.emailSignIn(email: email, password: password);
}
