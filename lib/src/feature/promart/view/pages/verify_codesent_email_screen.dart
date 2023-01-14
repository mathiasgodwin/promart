import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/recover_password/recover_password_cubit.dart';
import 'package:promart/src/features/promart/presentation/widgets/verify_password_form.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const VerifyCodeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: BlocProvider<RecoverPasswordCubit>(
        create: (_) => RecoverPasswordCubit(),
        child: const VerifyCodeForm(),
      ),
    );
  }
}
