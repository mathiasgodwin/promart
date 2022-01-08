import 'package:firebase_auth/firebase_auth.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseGetCurrentUser {
  FirebaseGetCurrentUser({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<User?> call() async => await _repository.getCurrentUser();
}
