import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/core/utils/screen/screen_util.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/view.dart';
import 'package:promart_api/promart.dart';


class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CatalogScreen());
  }

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _isTabSelected1 = true;
  bool _isTabSelected2 = false;
  bool _isTabSelected3 = false;
  bool _isTabSelected4 = false;

  int _currentIndex = 0;

  final List<Widget> _bodyList = const [
    _BodyListView(key: ValueKey<int>(00)),
    WishlistScreen(key: ValueKey<int>(11)),
    CartScreen(key: ValueKey<int>(22)),
    AccountScreen(key: ValueKey<int>(33))
  ];

  AppBar _wishListAppBar() {
    return AppBar(
      key: const ValueKey<int>(1),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      title: const Text(
        'Wishlist',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  AppBar _cartScreenAppBar() {
    return AppBar(
      key: const ValueKey<int>(2),
      backgroundColor: Colors.white,
      title: const Text(
        'My Cart',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // Most code here need some serious re-factoring :)
    // A lot of experimental stuffs here expecially the switching of app bars
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: GFIconButton(
              shape: GFIconButtonShape.circle,
              type: GFButtonType.transparent,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                  _isTabSelected1 = true;
                  _isTabSelected2 = false;
                  _isTabSelected3 = false;
                  _isTabSelected4 = false;
                });
              },
              icon: _isTabSelected1
                  ? const Icon(
                      Icons.home_filled,
                      color: Colors.red,
                    )
                  : const Icon(Icons.home_filled),
            ),
          ),
          BottomNavigationBarItem(
              label: 'Wishlist',
              icon: BlocBuilder<WishlistBloc, WishlistState>(
                buildWhen: (prev, current) => prev != current,
                builder: (context, state) {
                  return GFIconBadge(
                    key: const Key('HomeCart_iconButtonBadge'),
                    counterChild: GFBadge(
                      shape: GFBadgeShape.circle,
                      child: Text(
                        state.items.length.toString(),
                      ),
                    ),
                    child: GFIconButton(
                        shape: GFIconButtonShape.circle,
                        type: GFButtonType.transparent,
                        icon: _isTabSelected2
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;

                            _isTabSelected1 = false;
                            _isTabSelected2 = true;
                            _isTabSelected3 = false;
                            _isTabSelected4 = false;
                          });
                        }),
                  );
                },
              )),
          BottomNavigationBarItem(
              label: 'Carts',
              icon: BlocBuilder<CartBloc, CartState>(
                buildWhen: (prev, current) =>
                    prev.items.length != current.items.length,
                builder: (context, state) {
                  return GFIconBadge(
                    key: const Key('HomeCart_iconButtonBadge'),
                    counterChild: GFBadge(
                      shape: GFBadgeShape.circle,
                      child: Text(
                        state.items.length.toString(),
                      ),
                    ),
                    child: GFIconButton(
                        shape: GFIconButtonShape.circle,
                        type: GFButtonType.transparent,
                        icon: _isTabSelected3
                            ? const Icon(
                                Icons.shopping_basket_outlined,
                                color: Colors.red,
                              )
                            : const Icon(Icons.shopping_basket_outlined),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 2;

                            _isTabSelected1 = false;
                            _isTabSelected2 = false;
                            _isTabSelected3 = true;
                            _isTabSelected4 = false;
                          });
                        }),
                  );
                },
              )),
          BottomNavigationBarItem(
            label: 'Account',
            icon: GFIconButton(
              shape: GFIconButtonShape.circle,
              type: GFButtonType.transparent,
              onPressed: () {
                setState(() {
                  _currentIndex = 3;

                  _isTabSelected1 = false;
                  _isTabSelected2 = false;
                  _isTabSelected3 = false;
                  _isTabSelected4 = true;
                });
              },
              icon: _isTabSelected4
                  ? const Icon(
                      Icons.person,
                      color: Colors.red,
                    )
                  : const Icon(Icons.person),
            ),
          ),
        ],
        currentIndex: _currentIndex,
      ),
      backgroundColor: Colors.white,
      appBar: _currentIndex == 0
          ? _catalogScreenAppBar(context)
          : _currentIndex == 1
              ? _wishListAppBar()
              : _currentIndex == 2
                  ? _cartScreenAppBar()
                  : _accountScreenAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesCubit>(
            create: (_) => CategoriesCubit(
                repository: RepositoryProvider.of<PromartRepository>(context))
              ..getCategories(),
          ),
          BlocProvider<ProductsByCategoriesCubit>(
            create: (_) => ProductsByCategoriesCubit(
                repository: RepositoryProvider.of<PromartRepository>(context))
              ..getProductsByCategory('electronics'),
          ),
          BlocProvider<PromartCatalogCubit>(
            create: (_) => PromartCatalogCubit(
                // We are specifying the ..loadCatalog to load the Catalog on screen load
                repository: RepositoryProvider.of<PromartRepository>(context))
              ..loadCatalog(),
          ),
        ],
        child: _bodyList[_currentIndex],
      ),
    );
  }

  AppBar? _accountScreenAppBar() {
    // Account screen doesn't construct an app bar (based on the UI design)
    return null;
  }

  AppBar _catalogScreenAppBar(BuildContext context) {
    return AppBar(
      key: const ValueKey<int>(0),
      leadingWidth: 1,
      leading: const SizedBox(),
      elevation: 0.0,
      backgroundColor: Colors.purple,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Promart!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: kToolbarHeight * 0.4,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: kToolbarHeight * 0.08,
          ),
          Text(
            "Let's go shopping",
            style:
                TextStyle(color: Colors.white, fontSize: kToolbarHeight * 0.2),
          )
        ],
      ),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(CartScreenScaffold.route());
            },
            icon: const Icon(Icons.shopping_basket_rounded))
      ],
    );
  }
}

class _BodyListView extends StatelessWidget {
  const _BodyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.w, left: 10.w),
          child: Text(
            'TOP CATEGORIES',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
        ),
        SizedBox(height: 10.w),
        const _AvailableCategories(),
        SizedBox(height: 25.w),
        const _ProductAdsCarouselSmall(),
        SizedBox(height: 25.w),
        const _RowDivider('Electronics'),
        SizedBox(height: 10.w),
        const ProductByCategoryName(category: 'electronics'),
        //
        SizedBox(height: 10.w),
        const _RowDivider('New Arrival'),
        SizedBox(height: 10.w),
        const _ProductsAdsCarouselBig(),
        SizedBox(height: 25.w),

        const _AllProductsGrid(),

        //
      ],
    );
  }
}

// We're are only going to display some images without considering the real
// categories text gotten from the api call yet, but the call should happen
// This setting is only for learning purpose. Yeah, just practicing :)
class _AvailableCategories extends StatelessWidget {
  const _AvailableCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = BlocProvider.of<CategoriesCubit>(context);
    final _w = MediaQuery.of(context).size.width;

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      buildWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state.status == CategoriesStatus.loading) {
        } else if (state.status == CategoriesStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state.status == CategoriesStatus.loaded) {}
      },
      builder: (context, state) {
        if (state.status == CategoriesStatus.loaded) {
          final items = state.categories.data;
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: _CategoriesScrollViewWidget(items: items),
          );
        } else if (state.status == CategoriesStatus.loading) {
          return Center(
              child: GFShimmer(
                  child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 46,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 8,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      color: Colors.white,
                      height: 8,
                      width: _w * 0.5,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      color: Colors.white,
                      height: 8,
                      width: _w * 0.25,
                    ),
                  ],
                ))
              ],
            ),
          )));
        } else if (state.status == CategoriesStatus.failure) {
          return Center(
              child: GFIconButton(
                  color: Colors.purple,
                  shape: GFIconButtonShape.circle,
                  size: GFSize.LARGE,
                  icon: const Icon(Icons.replay),
                  onPressed: () {
                    categories.getCategories();
                  }));
        }

        return const SizedBox();
      },
    );
  }
}

class _CategoriesScrollViewWidget extends StatelessWidget {
  final List<String> items;
  const _CategoriesScrollViewWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> _imagePath = const [
    'jewelry_category',
    'men_category',
    'women_category',
    'electronic_category',
    'boy_with_cap'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final item in _imagePath)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'assets/images/$item.jpg',
                          gaplessPlayback: true,
                          fit: BoxFit.cover,
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      // Text(
                      //   state.categories.data[0],
                      //   style: const TextStyle(
                      //       color: Colors.white, fontSize: 12),
                      // )
                    ],
                  ),
                ),
              ),
            // const SizedBox(width: 8),
            // SizedBox(
            //   height: 70,
            //   width: 70,
            //   child: Stack(
            //     children: <Widget>[
            //       Container(
            //           decoration: const BoxDecoration(
            //         image: DecorationImage(
            //             fit: BoxFit.fill,
            //             image: AssetImage('assets/images/men_category.jpg')),
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       )),
            //       // Text(
            //       //   state.categories.data[1],
            //       //   style: const TextStyle(color: Colors.white),
            //       // )
            //     ],
            //   ),
            // ),
            // const SizedBox(width: 8),
            // SizedBox(
            //   height: 70,
            //   width: 70,
            //   child: Stack(
            //     children: <Widget>[
            //       Container(
            //         decoration: const BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //             image: DecorationImage(
            //                 fit: BoxFit.fill,
            //                 image: AssetImage(
            //                     'assets/images/women_category.jpg'))),
            //       ),
            //       // Text(
            //       //   state.categories.data[2],
            //       //   style: const TextStyle(color: Colors.white),
            //       // )
            //     ],
            //   ),
            // ),
            // const SizedBox(width: 8),
            // SizedBox(
            //   height: 70,
            //   width: 70,
            //   child: Stack(
            //     children: <Widget>[
            //       Container(
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //               fit: BoxFit.fill,
            //               image: AssetImage(
            //                   'assets/images/electronic_category.jpg')),
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //         ),
            //       ),
            //       // Text(
            //       //   state.categories.data[3],
            //       //   style: const TextStyle(color: Colors.white),
            //       // )
            //     ],
            //   ),
            // ),
            // const SizedBox(width: 8),
            // SizedBox(
            //   height: 70,
            //   width: 70,
            //   child: Stack(
            //     children: <Widget>[
            //       Container(
            //           decoration: const BoxDecoration(
            //         image: DecorationImage(
            //             fit: BoxFit.fill,
            //             image: AssetImage('assets/images/2.jpg')),
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       )),
            //       // Text(
            //       //   state.categories.data[3],
            //       //   style: const TextStyle(color: Colors.white),
            //       // )
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}

class _ProductAdsCarouselSmall extends StatelessWidget {
  const _ProductAdsCarouselSmall({Key? key}) : super(key: key);

  final List<String> _imagePath = const [
    'carousel_1',
    'carousel_2',
    'carousel_3',
    'carousel_4',
    'carousel_5',
    'carousel_6',
  ];

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        scrollPhysics: const BouncingScrollPhysics(),
        items: <Widget>[
          for (final item in _imagePath)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 150,
                child: Image.asset(
                  'assets/images/$item.jpg',
                  gaplessPlayback: true,
                  fit: BoxFit.cover,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
        ]);
  }
}

class _ProductsAdsCarouselBig extends StatelessWidget {
  const _ProductsAdsCarouselBig({Key? key}) : super(key: key);

  final List<String> _imagePath = const [
    'carousel_landscape_1',
    'carousel_landscape_2',
    'carousel_landscape_3',
    'carousel_landscape_4',
    'carousel_landscape_5',
  ];
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
        viewportFraction: 0.7,
        aspectRatio: 10 / 8,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        scrollPhysics: const BouncingScrollPhysics(),
        items: <Widget>[
          for (final item in _imagePath)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 200,
                child: Image.asset(
                  'assets/images/$item.jpg',
                  gaplessPlayback: true,
                  fit: BoxFit.cover,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
        ]);
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GFButton(
            onPressed: () {},
            text: 'MORE',
            color: Colors.purple,
          )
        ],
      ),
    );
  }
}

class _AllProductsGrid extends StatelessWidget {
  const _AllProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _w = size(context).width;
    return BlocConsumer<PromartCatalogCubit, PromartCatalogState>(
        buildWhen: (prev, current) => prev != current,
        listener: (context, state) {
          if (state.status == PromartCatalogStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content:
                      Text(state.errorMessage ?? 'Could not load, try again')));
          } else if (state.status == PromartCatalogStatus.loaded) {}
        },
        builder: (context, state) {
          if (state.status == PromartCatalogStatus.loaded) {
            return _ProductGridWidget(
              state: state,
            );
          } else if (state.status == PromartCatalogStatus.loading) {
            return Center(
              child: GFShimmer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 46,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            height: 8,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            color: Colors.white,
                            height: 8,
                            width: _w * 0.5,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            color: Colors.white,
                            height: 8,
                            width: _w * 0.25,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            );
          } else if (state.status == PromartCatalogStatus.failure) {
            return Center(
                child: GFIconButton(
                    color: Colors.purple,
                    shape: GFIconButtonShape.circle,
                    size: GFSize.LARGE,
                    icon: const Icon(Icons.replay),
                    onPressed: () {
                      context.read<PromartCatalogCubit>().loadCatalog();
                    }));
          }
          return const SizedBox();
        });
  }
}

class _ProductGridWidget extends StatelessWidget {
  final PromartCatalogState state;

  const _ProductGridWidget({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemCount: state.catalog!.data.length,
      itemBuilder: (BuildContext context, int index) {
        var item = state.catalog!.data[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push<void>(ProductDetailsScreen(item).route());
          },
          child: GFCard(
            padding: const EdgeInsets.all(0),
            image: Image.network(
              item.image,
              width: 150,
              height: 100,
            ),
            showImage: true,
            title: GFListTile(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              title: Text(
                item.title,
                maxLines: 1,
                softWrap: true,
                style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              subTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.clip,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '\$${item.price.toString()}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
