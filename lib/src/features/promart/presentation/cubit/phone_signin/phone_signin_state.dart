part of 'phone_signin_cubit.dart';

class PhoneSigninState extends Equatable {
  const PhoneSigninState(
      {this.phone = const Phone.pure(),
      this.code = const Code.pure(),
      this.verificationId,
      this.status = FormzStatus.pure,
      this.errorMessage});

  final String? verificationId;
  final Phone phone;
  final Code code;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [phone, code, verificationId, status, errorMessage];

  PhoneSigninState copyWith({
    String? verificationId,
    Phone? phone,
    Code? code,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return PhoneSigninState(
        verificationId: verificationId ?? this.verificationId,
        phone: phone ?? this.phone,
        code: code ?? this.code,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
