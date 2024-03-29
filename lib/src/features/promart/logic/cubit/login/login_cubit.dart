import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:formz/formz.dart';
import 'package:promart/src/core/utils/validators/email.dart';
import 'package:promart/src/core/utils/validators/password.dart';
import 'package:promart_api/promart.dart';



part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final repository = PromartRepository(dataSource: RemoteDataSource());

  late final _loginWithPasswordEmail =
      FirebaseEmailSignIn(repository: repository);
  late final _loginWithGoogle = FirebaseGoogleSignIn(repository: repository);

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> loginWithCredential() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginWithPasswordEmail(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, error: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure,));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
