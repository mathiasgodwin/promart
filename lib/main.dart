import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:promart/src/app.dart';
import 'package:promart/src/bloc_observer.dart';
import 'package:promart/src/features/promart/data/datasources/remote/remote_datasource.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.purple,
    systemNavigationBarColor: Colors.purple,
  ));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
  final promartRepository = PromartRepository(dataSource: RemoteDataSource());
  await promartRepository.user.first;
  await ScreenUtil.ensureScreenSize();

  final storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  HydratedBlocOverrides.runZoned(
      () => runApp(App(promartRespository: promartRepository)),
      blocObserver: AuthBlocObserver(),
      storage: storage);
}
