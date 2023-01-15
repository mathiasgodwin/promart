import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/view.dart';
class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoverPasswordCubit, RecoverPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push<void>(NewPaswordSuccessful.route());
        }
      },
      child: Stack(
          //
          fit: StackFit.loose,
          children: [
            Center(
              child: Padding(
                padding:  EdgeInsets.only(top: 200.w, left: 20.w, right: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text('New Credentials',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.sp)),
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Your Identity has been verified!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.w),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Set your new password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                     SizedBox(
                      height: 40.w,
                    ),
                    _PasswordInput(),
                    _ConfirmPasswordInput(),
                     SizedBox(height: 5.w),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: _LoginButton(),
                    ),
                  ],
                ),
              ),
            ),

            //
          ]),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (password) =>
                context.read<RecoverPasswordCubit>().passwordChanged(password),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon:  Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0.w),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16.w,
                ),
              ),
              labelText: 'New Password',
              helperText: '',
              errorText: state.email.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context
                .read<RecoverPasswordCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon:  Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0.w),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16.w,
                ),
              ),
              labelText: 'confirm password',
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

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : GFButton(
                fullWidthButton: true,
                color: Colors.purple,
                onPressed: () {
                  Navigator.of(context).push<void>(NewPaswordSuccessful.route());
                },
                text: 'Update',
                size: 60.w);
      },
    );
  }
}
