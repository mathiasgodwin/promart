import 'package:firebase_auth/firebase_auth.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseAuthStateChange {
  FirebaseAuthStateChange({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Stream<User?> call() => _repository.onAuthChange();
}
