import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:promart/src/features/promart/presentation/cubit/login/login_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/forgot_password_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/signup_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.exceptionError ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Stack(
          //
          fit: StackFit.loose,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: _SignUpButton(),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 90, bottom: 30, left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Welcome back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Signin to continue.',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _EmailInput(),
                    _PasswordInput(),
                    const SizedBox(height: 5),
                    Center(child: _LoginButton()),
                    const SizedBox(height: 16),
                    _ForgotPassword(),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),

            //
          ]),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0),
                child: Icon(
                  Icons.mail_outline,
                  size: 16,
                ),
              ),
              labelText: 'Email / Phone',
              helperText: '',
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16,
                ),
              ),
              labelText: 'Password',
              helperText: '',
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _ForgotPassword extends StatefulWidget {
  @override
  State<_ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<_ForgotPassword> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handlePress;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() {
    Navigator.of(context).push<void>(RecoverPasswordScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        text: TextSpan(
          recognizer: _tapGestureRecognizer,
          text: 'Forgot Password?',
          style: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.black87),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: state.status.isValidated
                        ? () => context.read<LoginCubit>().loginWithCredential()
                        : () {},
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 8,
                      minimumSize: const Size(315, 50),
                    ),
                  ),
                );
        });
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
        key: const Key('loginForm_createAccount_flatButton'),
        onPressed: () => Navigator.of(context).push<void>(SignUpScreen.route()),
        child: const Text('Creat New Account'),
        style: ElevatedButton.styleFrom(
            primary: theme.primaryColor,
            minimumSize: const Size(double.infinity, 60)));
  }
}
