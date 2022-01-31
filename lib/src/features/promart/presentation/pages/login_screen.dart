import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/login/login_cubit.dart';
import 'package:promart/src/features/promart/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.purple,
          systemNavigationBarColor: Colors.purple,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
