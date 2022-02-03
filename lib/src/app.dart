import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/configs/routes/routes.dart';
import 'package:promart/src/configs/theme/theme.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/pages/home_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/login_screen.dart';

import 'features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required PromartRepository promartRespository,
  })  : _promartRespository = promartRespository,
        super(key: key);

  final PromartRepository _promartRespository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _promartRespository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          promartRepository: _promartRespository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBloc = BlocProvider.of<AuthBloc>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: routeBloc.state.status == AuthStatus.authenticated
            ? HomePage()
            : LoginScreen());
  }
}
