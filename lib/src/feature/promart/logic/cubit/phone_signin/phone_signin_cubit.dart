import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:promart/src/core/utils/exceptions/google_auth_exceptions.dart';
import 'package:promart/src/core/utils/validators/code.dart';
import 'package:promart/src/core/utils/validators/phone.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/domain/usecases/firebase_phone_signin.dart';
import 'package:promart/src/features/promart/domain/usecases/firebase_phone_verify.dart';

part 'phone_signin_state.dart';

class PhoneSigninCubit extends Cubit<PhoneSigninState> {
  PhoneSigninCubit() : super(const PhoneSigninState());

  final PromartRepository repository =
      PromartRepository(dataSource: RemoteDataSource());

  final Duration verificationCodeTimeout = const Duration(seconds: 60);

  StreamSubscription<String>? _phoneNumberSignInSubscription;
  late final _signInWithPhone = FirebasePhoneSignIn(repository: repository);
  late final _verifySmsCode = FirebaseVerifySms(repository: repository);

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(
      state.copyWith(phone: phone, status: Formz.validate([phone, state.code])),
    );
  }

  void codeChanged(String value) {
    final code = Code.dirty(value);
    emit(
      state.copyWith(code: code, status: Formz.validate([code, state.phone])),
    );
  }

  void signInWithPhone() {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _phoneNumberSignInSubscription = _signInWithPhone(
            phoneNumber: state.phone.value, timeout: verificationCodeTimeout)
        .listen((event) {
      emit(
        state.copyWith(verificationId: event),
      );
    })
      ..onError((e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, errorMessage: e.toString()));
      });
  }

  void verifySmsCode() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await _verifySmsCode(
          smsCode: state.code.value, verificationId: state.verificationId!);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on PhoneAuthSmsTimeoutError catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    } on PhoneAuthError catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _phoneNumberSignInSubscription?.cancel();
    return super.close();
  }
}
