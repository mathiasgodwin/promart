import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';
import 'package:promart/src/features/promart/presentation/widgets/recover_password_form.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RecoverPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecoverPasswordCubit>(create:(_) => RecoverPasswordCubit(), 
      child: const RecoverPasswordForm(),
      )
    );
  }
}
