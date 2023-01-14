import 'package:promart/src/app.dart';
import 'package:promart/bootstrap.dart';

void main() {
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
  bootstrap(() => const App());
}
