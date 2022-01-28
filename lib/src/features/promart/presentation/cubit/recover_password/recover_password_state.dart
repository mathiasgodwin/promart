part of 'recover_password_cubit.dart';

class RecoverPasswordState extends Equatable {
  const RecoverPasswordState({
    this.email = const Email.pure(),
    this.code = const Code.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Code code;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        code,
        password,
        confirmedPassword,
        status,
        errorMessage,
      ];

  RecoverPasswordState copyWith({
    Email? email,
    Code? code,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RecoverPasswordState(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
