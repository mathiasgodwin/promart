import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/view.dart';
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
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.4.sh),
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.0),
                child: Row(
                  children: [
                    Text('Forget Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 25.sp,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              _EmailInput(),
              Center(child: _SubmitButton()),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final fontSize = 14;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            child: TextField(
              scrollPadding: EdgeInsets.only(
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom + fontSize * 4),
              key: const Key('recoverpasswordForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<RecoverPasswordCubit>().emailChanged(email),
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
