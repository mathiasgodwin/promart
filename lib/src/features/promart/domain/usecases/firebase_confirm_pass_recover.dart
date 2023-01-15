import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseConfirmPassRecovery {
  FirebaseConfirmPassRecovery({
    required IPromartRepository repository,
  }) : _repository = repository;

  final IPromartRepository _repository;

  Future<String?> call(
          {required String code, required String newPassword}) async =>
      await _repository.confirmPasswordRecovery(
          code: code, newPassword: newPassword);
}
