import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:promart/src/app.dart';
import 'package:promart/src/bloc_observer.dart';
import 'package:promart/src/features/promart/data/datasources/remote_datasource.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
  final promartRepository = PromartRepository(dataSource: RemoteDataSource());
  await promartRepository.user.first;
  BlocOverrides.runZoned(
    () => runApp(App(promartRespository: promartRepository)),
    blocObserver: AuthBlocObserver(),
  );
}
