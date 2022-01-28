import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebaseVerifySms {
  FirebaseVerifySms({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<void> call(
          {required String smsCode, required String verificationId}) async =>
      await _repository.verifySmsCode(
          smsCode: smsCode, verificationId: verificationId);
}
