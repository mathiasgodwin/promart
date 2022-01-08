import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseConfirmPassRecover {
  FirebaseConfirmPassRecover({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<String?> call({String? code, String? newPassword}) async =>
      await _repository.confirmPasswordRecovery(
          code: code, newPassword: newPassword);
}
