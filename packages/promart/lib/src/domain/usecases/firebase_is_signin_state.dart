import 'package:promart/promart.dart';

class FirebaseIsSignedIn {
  FirebaseIsSignedIn({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<bool?> call() async => await _repository.isSignedIn();
}
