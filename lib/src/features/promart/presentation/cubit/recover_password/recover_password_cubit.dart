import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:promart/src/core/utils/exceptions/google_auth_exceptions.dart';
import 'package:promart/src/core/utils/validators/code.dart';
import 'package:promart/src/core/utils/validators/confirm_password.dart';
import 'package:promart/src/core/utils/validators/email.dart';
import 'package:promart/src/core/utils/validators/password.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/domain/usecases/firebase_confirm_pass_recover.dart';
import 'package:promart/src/features/promart/domain/usecases/firebase_recover_password.dart';

part 'recover_password_state.dart';

class RecoverPasswordCubit extends Cubit<RecoverPasswordState> {
  RecoverPasswordCubit() : super(const RecoverPasswordState());

  final PromartRepository repository =
      PromartRepository(dataSource: RemoteDataSource());

  late final _confirmPasswordRecovery =
      FirebaseConfirmPassRecovery(repository: repository);

  late final _requestPasswordRecovery =
      FirebaseRecoverPassword(repository: repository);

  void emailChanged(String value) {
    final email = Email.dirty(value);

    final textEmail = value;
    print(value);
    emit(
      state.copyWith(
        email: email,
        textEmail: textEmail,
        status: Formz.validate([
          email,
          // state.code,
          // state.password,
          // state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        // state.code,
        // state.email,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        // state.email,
        state.password,
        // state.code,
        confirmedPassword,
      ]),
    ));
  }

  void codeChanged(String value) {
    final code = Code.dirty(value);
    print(code);
    print(value);
    emit(state.copyWith(
      code: code,
      status: Formz.validate([
        code,
        // state.email,
      ]),
    ));
  }

  Future<void> recoverPassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _requestPasswordRecovery(
        email: state.email.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on PasswordValidationError catch (e) {
      emit(state.copyWith(
          status: FormzStatus.invalid, errorMessage: e.toString()));
    } on PasswordRecoveryFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> confirmRecoverPassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _confirmPasswordRecovery(
          newPassword: state.password.value, code: state.code.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on ConfirmedPasswordValidationError catch (e) {
      emit(state.copyWith(
          status: FormzStatus.invalid, errorMessage: e.toString()));
    } on ConfirmPasswordRecoveryFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
