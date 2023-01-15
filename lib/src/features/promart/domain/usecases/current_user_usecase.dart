// import 'package:firebase_auth/firebase_auth.dart';
import 'package:promart/src/features/promart/data/models/user_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseGetCurrentUser {
  FirebaseGetCurrentUser({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  User call() => _repository.currentUser;
}
