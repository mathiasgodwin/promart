import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:promart/src/configs/theme/theme.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:promart/src/features/promart/presentation/bloc/bloc.dart';

import 'package:promart/src/features/promart/presentation/pages/catalog_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/login_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/splash_screen.dart';
import 'package:promart/src/features/promart/presentation/widgets/scroll_behavior.dart';

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              promartRepository: _promartRespository,
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
        ],
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
  // final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          ScreenUtil.setContext(context);
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      CatalogScreen.route(),
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
            ),
          );
        },
        debugShowCheckedModeBanner: false,
        theme: theme,
        onGenerateRoute: (_) => SplashScreen.route(),
      ),
    );
  }
}
