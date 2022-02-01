import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/new_password_successful_screen.dart';

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
                padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('New Credentials',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Your Identity has been verified!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Set your new password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _PasswordInput(),
                    _ConfirmPasswordInput(),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (password) =>
                context.read<RecoverPasswordCubit>().passwordChanged(password),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context
                .read<RecoverPasswordCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16,
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
                  Navigator.of(context).push(NewPaswordSuccessful.route());
                },
                text: 'Update',
                size: 60);
      },
    );
  }
}
