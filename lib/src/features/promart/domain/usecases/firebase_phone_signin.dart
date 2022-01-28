import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class FirebasePhoneSignIn {
  FirebasePhoneSignIn({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Stream<String> call({required String phoneNumber, Duration? timeout}) async* {
    final response = _repository.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout ?? const Duration(seconds: 60));

    yield* response;
  }
}
