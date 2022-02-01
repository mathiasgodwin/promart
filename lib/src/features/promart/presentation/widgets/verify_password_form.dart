import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/new_password_screen.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Verification Code',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              _TextWithEmail(),
              const SizedBox(
                height: 30,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GFButton(
          size: 45,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            textAlign: TextAlign.center,
            cursorHeight: 40,
            cursorColor: Colors.black,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
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
        final String email = state.textEmail ?? '';
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Please type the verification code sent to the email',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }
}
