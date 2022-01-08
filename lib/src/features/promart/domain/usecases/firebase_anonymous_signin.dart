import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseAnonymousSign {
  FirebaseAnonymousSign({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<String?> call() async => await _repository.anonymousSignIn();
}
