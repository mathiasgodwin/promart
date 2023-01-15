import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/logic/logic.dart';

class SplashLoadingAssets extends StatefulWidget {
  const SplashLoadingAssets({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SplashLoadingAssets());
  }

  @override
  _SplashLoadingAssetsState createState() => _SplashLoadingAssetsState();
}

class _SplashLoadingAssetsState extends State<SplashLoadingAssets> {
  final List<String> _imageToBeCached = const [
    //
    'jewelry_category',
    'men_category',
    'women_category',
    'electronic_category',
    'boy_with_cap',
    //
    'carousel_1',
    'carousel_2',
    'carousel_3',
    'carousel_4',
    'carousel_5',
    'carousel_6',
    //
    'carousel_landscape_1',
    'carousel_landscape_2',
    'carousel_landscape_3',
    'carousel_landscape_4',
    'carousel_landscape_5',
  ];
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoadingAssetSplashCubit>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: Future.wait(_imageToBeCached.map((image) async {
              // Adding a delay so the app doesn't get killed by os due to memory
              // pressure. I don't know if this is right :) just experimenting!
              // await Future.delayed(const Duration(seconds: 1));
              return precacheImage(
                  AssetImage(
                    'assets/images/' + image + '.jpg',
                  ),
                  context);
            })),
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        'Loading...',
                        style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.overline,
                            decorationStyle: TextDecorationStyle.wavy,
                            decorationColor: Colors.purple,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      GFLoader(
                        type: GFLoaderType.circle,
                      ),
                    ],
                  ),
                );
              } else {
                cubit.loadAssets(false);
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
