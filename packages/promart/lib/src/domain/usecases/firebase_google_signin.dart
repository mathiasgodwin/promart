import 'package:promart/promart.dart';

class FirebaseGoogleSignIn {
  FirebaseGoogleSignIn({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<String?> call() async => await _repository.googleSignIn();
}
