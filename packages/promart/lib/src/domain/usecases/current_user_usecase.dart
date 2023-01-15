import 'package:promart/promart.dart';

class FirebaseGetCurrentUser {
  FirebaseGetCurrentUser({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  User call() => _repository.currentUser;
}
