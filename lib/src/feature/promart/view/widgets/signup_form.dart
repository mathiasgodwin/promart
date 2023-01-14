import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:promart/src/core/utils/screen/screen_util.dart';
import 'package:promart/src/features/promart/presentation/cubit/signup/signup_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        //
        child: SizedBox(
          height: size(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.3.sh),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text('Welcome!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'Create a new account.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(height: 0.04.sh),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _EmailInput(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: _PasswordInput(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: _ConfirmPasswordInput(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    _SignUpButton(),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    Text(
                      'Or Continue with',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: _AuthButton(),
              ),
            ],
          ),
        ),

        //
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final fontSize = 14;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + fontSize * 4),
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w),
              child: Icon(
                Icons.mail_outline,
                size: 16.sp,
              ),
            ),
            labelText: 'Email',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final fontSize = 14;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          height: 50.w,
          child: TextField(
            scrollPadding: EdgeInsets.only(
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + fontSize * 4),
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 12.w),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16.sp,
                ),
              ),
              labelText: 'Password',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              helperText: '',
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  final fontSize = 14;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return SizedBox(
          height: 50.w,
          child: TextField(
            scrollPadding: EdgeInsets.only(
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + fontSize * 4),
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 12.w),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16.sp,
                ),
              ),
              labelText: 'Confirm password',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              helperText: '',
              errorText: state.confirmedPassword.invalid
                  ? 'passwords do not match'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

// You login with google and not signUp.
class _AuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = width(context);

    return SizedBox(
      width: _w,
      child: GFButtonBar(
        spacing: 0.0,
        children: [
          SizedBox(
            width: _w / 2,
            child: GFButton(
              borderShape: const BeveledRectangleBorder(),
              size: 75.w,
              padding: const EdgeInsets.all(0),
              color: Colors.blue,
              onPressed: () {},
              text: 'Facebook',
            ),
          ),
          SizedBox(
            width: _w / 2,
            child: GFButton(
              borderShape: const BeveledRectangleBorder(),
              size: 75.w,
              padding: const EdgeInsets.all(0),
              color: Colors.red,
              onPressed: () {},
              text: 'Google',
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : GFButton(
                fullWidthButton: true,
                color: Colors.purple,
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : () {},
                text: 'Signup',
                size: 60.w);
      },
    );
  }
}
