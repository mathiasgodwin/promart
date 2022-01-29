import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:promart/src/app.dart';
import 'package:promart/src/bloc_observer.dart';
import 'package:promart/src/features/promart/data/datasources/remote_datasource.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository =
      PromartRepository(dataSource: RemoteDataSource());
  await authenticationRepository.user.first;
  BlocOverrides.runZoned(
    () => runApp(App(authenticationRepository: authenticationRepository)),
    blocObserver: AuthBlocObserver(),
  );
}
