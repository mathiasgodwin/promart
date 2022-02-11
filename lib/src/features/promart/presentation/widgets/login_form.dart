import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:promart/src/features/promart/presentation/cubit/login/login_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/forgot_password_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/home_screen.dart';
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
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push<void>(HomeScreen.route());
        }
      },
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _SignUpButton(),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 0.2.sh, left: 10.w, right: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text('Welcome back',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Signin to continue.',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                ),
                SizedBox(
                  height: 40.w,
                ),
                _EmailInput(),
                _PasswordInput(),
                SizedBox(height: 5.w),
                Center(child: _LoginButton()),
                SizedBox(height: 16.w),
                _ForgotPassword(),
                SizedBox(height: 4.w),
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 12.r),
                child: Icon(
                  Icons.mail_outline,
                  size: 16.sp,
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 12.w),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16.w,
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
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ElevatedButton(
                    onPressed: state.status.isValidated
                        ? () => context.read<LoginCubit>().loginWithCredential()
                        : () {},
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 8,
                      minimumSize: Size(315.w, 50.w),
                    ),
                  ),
                );
        });
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    final theme = Theme.of(context);
    return ElevatedButton(
        key: const Key('loginForm_createAccount_flatButton'),
        onPressed: () => Navigator.of(context).push<void>(SignUpScreen.route()),
        child: const Text('Creat New Account'),
        style: ElevatedButton.styleFrom(
            primary: theme.primaryColor,
            minimumSize: Size(double.infinity, 60.w)));
  }
}
