import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseSignOutUser {
  FirebaseSignOutUser({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<void> call() async => await _repository.signOut();
}
