import 'package:flutter/widgets.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/pages/home_screen.dart';
import 'package:promart/src/features/promart/presentation/pages/login_screen.dart';

List<Page> onGenerateAppViewPages(AuthStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthStatus.authenticated:
      return [HomePage.page()];
    case AuthStatus.unauthenticated:
    default:
      return [LoginScreen.page()];
  }
}
