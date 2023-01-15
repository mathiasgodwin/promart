import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/widgets/widgets.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const RecoverPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider<RecoverPasswordCubit>(
          create: (_) => RecoverPasswordCubit(),
          child: const RecoverPasswordForm(),
        ));
  }
}
