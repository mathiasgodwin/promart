/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure(
      [this.message =
          'Could not send request, check your internet connection.']);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'Could not send request, check your internet connection.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'Could not send request, check your internet connection.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class PasswordRecoveryFailure implements Exception {
  const PasswordRecoveryFailure(
      [this.message =
          'Could not send request, check your internet connection.']);

  final String message;

  factory PasswordRecoveryFailure.fromCode(String code) {
    switch (code) {
      case '_firebaseAuth/invalid-email':
        return const PasswordRecoveryFailure(
            'Email is not valid or badly formatted.');
      case '_firebaseAuth/user-not-found':
        return const PasswordRecoveryFailure(
            'Email doesn\'t exist or not registered.');
      default:
        return const PasswordRecoveryFailure();
    }
  }
}

class ConfirmPasswordRecoveryFailure implements Exception {
  const ConfirmPasswordRecoveryFailure(
      [this.message =
          'Could not send request, check your internet connection.']);

  final String message;

  factory ConfirmPasswordRecoveryFailure.fromCode(String code) {
    switch (code) {
      case 'weak-password':
        return const ConfirmPasswordRecoveryFailure(
            'Password too weak, try again.');
      case 'expired-action-code':
        return const ConfirmPasswordRecoveryFailure(
            'Password recovery time-out, restart the whole process.');
      case 'user-not-found':
        return const ConfirmPasswordRecoveryFailure(
            'The Account does\'t exist.');
      case 'invalid-action-code':
        return const ConfirmPasswordRecoveryFailure('Invalid reset code.');
      default:
        return const ConfirmPasswordRecoveryFailure();
    }
  }
}

class PhoneAuthError implements Exception {
  const PhoneAuthError(
      [this.message =
          'Could not send request, check your internet connection.']);

  final String message;

  factory PhoneAuthError.fromCode(String code) {
    switch (code) {
      case 'invalid-phone-number':
        return const PhoneAuthError('The phone number is invalid.');
      case 'too-many-requests':
        return const PhoneAuthError('Error due too many request.');
      case 'app-not-authorized':
        return const PhoneAuthError('An unknown error.');
      case 'session-expired':
        return const PhoneAuthError('Current session expired, try again!');
      case 'invalid-verification-code':
        return const PhoneAuthError('Invalid verification code.');
      default:
        return const PhoneAuthError();
    }
  }
}

class PhoneAuthSmsTimeoutError implements Exception {
  const PhoneAuthSmsTimeoutError();
}
