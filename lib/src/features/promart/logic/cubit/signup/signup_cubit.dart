import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:formz/formz.dart';
import 'package:promart/src/core/utils/validators/confirm_password.dart';
import 'package:promart/src/core/utils/validators/email.dart';
import 'package:promart/src/core/utils/validators/password.dart';
import 'package:promart_api/promart.dart';
part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  final repository = PromartRepository(dataSource: RemoteDataSource());

  late final _signUpWithEmail = FirebaseEmailSignUp(repository: repository);

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
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

    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );

    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    try {
      await _signUpWithEmail(
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
