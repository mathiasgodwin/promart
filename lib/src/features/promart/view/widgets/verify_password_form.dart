import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/view.dart';

class VerifyCodeForm extends StatelessWidget {
  const VerifyCodeForm({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return BlocListener<RecoverPasswordCubit, RecoverPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          //

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
                child: Text('Verification Code',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25.sp,
                    )),
              ),
              SizedBox(
                height: 12.w,
              ),
              _TextWithEmail(),
              SizedBox(
                height: 30.w,
              ),
              _CodeInput(),
              Center(child: _SubmitButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GFButton(
          size: 45.w,
          onPressed: () {
            Navigator.of(context).push<void>(NewPasswordScreen.route());
          },
          text: 'Verify',
          color: Colors.purple,
        ),
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            textAlign: TextAlign.center,
            cursorHeight: 40.w,
            cursorColor: Colors.black,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25.w,
            ),
            key: const Key('verifycodeForm_emailInput_textField'),
            onChanged: (code) {
              return context.read<RecoverPasswordCubit>().codeChanged(code);
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              focusColor: Colors.lightGreen,
              helperText: '',
              errorText: state.code.invalid ? 'Invalid code' : null,
            ),
          ),
        );
      },
    );
  }
}

class _TextWithEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        // print(context.read<RecoverPasswordCubit>().state.textEmail);
        // final String email = state.textEmail ?? '';
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Please type the verification code sent to the email',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15.sp,
            ),
          ),
        );
      },
    );
  }
}
