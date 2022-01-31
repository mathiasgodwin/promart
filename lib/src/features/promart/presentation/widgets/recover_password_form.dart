import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';

class RecoverPasswordForm extends StatelessWidget {
  const RecoverPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoverPasswordCubit, RecoverPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Forget Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    )),
              ),
              const SizedBox(
                height: 20,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            child: TextField(
              key: const Key('recoverpasswordForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<RecoverPasswordCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.0),
                  child: Icon(
                    Icons.mail_outline,
                    size: 16,
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
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GFButton(
                    size: 45,
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
