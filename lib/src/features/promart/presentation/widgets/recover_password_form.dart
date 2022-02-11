import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/verify_codesent_email_screen.dart';

class RecoverPasswordForm extends StatelessWidget {
  const RecoverPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoverPasswordCubit, RecoverPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentMaterialBanner()
            ..showSnackBar(const SnackBar(
                content: Text('Recovery code sent. pls, check your email.')));

          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).push<void>(VerifyCodeScreen.route());
          });
          //
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentMaterialBanner()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Could not send email.')));
        }
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text('Forget Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25.sp,
                    )),
              ),
              SizedBox(
                height: 20.w,
              ),
              _EmailInput(),
              Center(child: _SubmitButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            child: TextField(
              key: const Key('recoverpasswordForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<RecoverPasswordCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Icon(
                    Icons.mail_outline,
                    size: 16.sp,
                  ),
                ),
                labelText: 'Email',
                helperText: '',
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GFButton(
                    size: 45.w,
                    onPressed: state.status.isValidated
                        ? () => context
                            .read<RecoverPasswordCubit>()
                            .recoverPassword()
                        : () {},
                    text: 'Send',
                    color: Colors.purple,
                  ),
                ),
              );
      },
    );
  }
}
