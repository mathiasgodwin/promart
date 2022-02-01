import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';
import 'package:promart/src/features/promart/presentation/widgets/new_password_form.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const NewPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecoverPasswordCubit>(
        create: (_) => RecoverPasswordCubit(),
        child: const NewPasswordForm(),
      ),
    );
  }
}
