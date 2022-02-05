import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/src/configs/theme/theme.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/pages/home_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/login_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/splash_screen.dart';

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

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
                break;
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: theme,
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
