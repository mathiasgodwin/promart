import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:promart/src/configs/theme/theme.dart';
import 'package:promart/src/features/promart/logic/bloc/auth/auth.dart';
import 'package:promart/src/features/promart/logic/bloc/bloc.dart';
import 'package:promart/src/features/promart/logic/cubit/loading_asset/loading_asset.dart';
import 'package:promart_api/promart.dart';

import 'features/promart/view/view.dart';

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
              create: (_) => LoadingAssetSplashCubit()..loadAssets(true)),
          BlocProvider(
            create: (_) => AuthBloc(
              promartRepository: _promartRespository,
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(create: (context) => WishlistBloc()),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
        );
        return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child:
                BlocBuilder<LoadingAssetSplashCubit, LoadingAssetSplashState>(
              builder: (context, state) {
                if (state.status == LoadingAssetsStatus.loaded) {
                  return BlocListener<AuthBloc, AuthState>(
                    child: child,
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
                  );
                } else {}
                return child!;
              },
            ));
      },
      debugShowCheckedModeBanner: false,
      theme: theme,
      onGenerateRoute: (_) => SplashLoadingAssets.route(),
    );
  }
}
