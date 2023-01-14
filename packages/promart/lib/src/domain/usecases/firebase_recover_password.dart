import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseRecoverPassword {
  FirebaseRecoverPassword({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;
  Future<String?> call({String? email}) async =>
      await _repository.passwordRecovery(email: email);
}
