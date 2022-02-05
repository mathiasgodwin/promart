import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/categories/categories_cubit.dart';
import 'package:promart/src/features/promart/presentation/cubit/products_by_categories/products_by_categories_cubit.dart';

import 'package:promart/src/features/promart/presentation/cubit/single_product/single_product_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const HomeScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              style: TextStyle(
                  color: Colors.white, fontSize: kToolbarHeight * 0.2),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.shopping_basket_outlined),
            onPressed: () => context.read<AuthBloc>().add(AppLogoutRequested()),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesCubit>(
            create: (_) => CategoriesCubit(),
          ),
          BlocProvider<ProductsByCategoriesCubit>(
            create: (_) => ProductsByCategoriesCubit(),
          ),
          BlocProvider<SingleProductCubit>(
            create: (_) => SingleProductCubit(),
          ),
        ],
        child: ListView(
          shrinkWrap: true,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                'TOP CATEGORIES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            _AvailableCategories(),
            SizedBox(height: 25),
            _ProductAdsCarouselSmall(),
            SizedBox(height: 25),
            _RowDivider('Electronics'),
            SizedBox(height: 10),
            _ProductByCategoryName('electronics'),
            //
            SizedBox(height: 10),
            _RowDivider('New Arrival'),
            SizedBox(height: 10),
            _ProductsAdsCarouselBig(),

            //
          ],
        ),
      ),
    );
  }
}

// We're are only going to disable some images without considering the real
// categories text gotten from the api call yet, but the call should happen
// This setting only for learning purpose.
class _AvailableCategories extends StatefulWidget {
  const _AvailableCategories({Key? key}) : super(key: key);

  @override
  State<_AvailableCategories> createState() => _AvailableCategoriesState();
}

class _AvailableCategoriesState extends State<_AvailableCategories> {
  bool _reload = true;

  // Disable reloading if data is gotten once.
  void loadAnddoNotReload(CategoriesCubit categoriesCubit) {
    if (_reload) {
      categoriesCubit.getCategories();
    } else if (!_reload) {}
  }

  @override
  Widget build(BuildContext context) {
    final categories = BlocProvider.of<CategoriesCubit>(context);
    final _w = MediaQuery.of(context).size.width;
    final _h = MediaQuery.of(context).size.height;

    loadAnddoNotReload(categories);
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesLoading) {
        } else if (state is CategoriesError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content:
                    Text(state.errorMessage ?? 'Could not load, try again')));
        } else if (state is CategoriesLoaded) {
          setState(() {
            _reload = false;
          });
        }
      },
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/cat3.jpg')),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/cat3.jpg')),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                          // Text(
                          //   state.categories.data[1],
                          //   style: const TextStyle(color: Colors.white),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/images/cat3.jpg'))),
                          ),
                          // Text(
                          //   state.categories.data[2],
                          //   style: const TextStyle(color: Colors.white),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/cat3.jpg')),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          // Text(
                          //   state.categories.data[3],
                          //   style: const TextStyle(color: Colors.white),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/cat3.jpg')),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                          // Text(
                          //   state.categories.data[3],
                          //   style: const TextStyle(color: Colors.white),
                          // )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        } else if (state is CategoriesLoading) {
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
        } else if (state is CategoriesError) {
          return Center(
              child: GFIconButton(
                  color: Colors.purple,
                  shape: GFIconButtonShape.circle,
                  size: GFSize.LARGE,
                  icon: const Icon(Icons.replay_circle_filled_rounded),
                  onPressed: () {
                    categories.getCategories();
                  }));
        }

        return const SizedBox();
      },
    );
  }
}

class _ProductAdsCarouselSmall extends StatelessWidget {
  const _ProductAdsCarouselSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        scrollPhysics: const BouncingScrollPhysics(),
        items: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              // colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.colorBurn),
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: const AssetImage('assets/images/cat3.jpg'),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Column(
                children: const <Widget>[],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ]);
  }
}

class _ProductsAdsCarouselBig extends StatelessWidget {
  const _ProductsAdsCarouselBig({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              // colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.colorBurn),
              height: 200,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 200,
              image: const AssetImage('assets/images/cat3.jpg'),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Column(
                children: const <Widget>[],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GFImageOverlay(
              height: 150,
              image: AssetImage('assets/images/cat3.jpg'),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ]);
  }
}

class _RowDivider extends StatelessWidget {
  final String text;

  const _RowDivider(this.text, {Key? key}) : super(key: key);

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

class _ProductByCategoryName extends StatefulWidget {
  final String category;
  const _ProductByCategoryName(this.category, {Key? key}) : super(key: key);

  @override
  State<_ProductByCategoryName> createState() => _ProductByCategoryNameState();
}

class _ProductByCategoryNameState extends State<_ProductByCategoryName> {
  bool _reload = true;

  // Disable reloading if data is gotten once.
  void loadAnddoNotReload(
    ProductsByCategoriesCubit productsByCategoriesCubit,
  ) {
    if (_reload) {
      productsByCategoriesCubit.getProductsByCategory(widget.category);
    } else if (!_reload) {}
  }

  @override
  Widget build(BuildContext context) {
    final productsByCategoriesCubit =
        BlocProvider.of<ProductsByCategoriesCubit>(context);
    final _w = MediaQuery.of(context).size.width;
    loadAnddoNotReload(productsByCategoriesCubit);

    return BlocConsumer<ProductsByCategoriesCubit, ProductsByCategoriesState>(
      listener: (context, state) {
        if (state is ProductsByCategoriesError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content:
                    Text(state.errorMessage ?? 'Could not load, try again')));
        } else if (state is ProductsByCategoriesLoaded) {
          setState(() {
            _reload = false;
          });
        }
      },
      builder: (context, state) {
        if (state is ProductsByCategoriesLoaded) {
          return Container(
            color: Colors.white,
            margin: const EdgeInsets.only(left: 8, right: 8),
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              itemCount: state.products.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = state.products.data[index];
                return SizedBox(
                  width: _w * 0.5,
                  child: GFCard(
                    image: Image.network(
                      item.image,
                      width: 150,
                      height: 150,
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
            ),
          );
        } else if (state is ProductsByCategoriesLoading) {
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
        } else if (state is ProductsByCategoriesError) {
          return Center(
              child: GFIconButton(
                  color: Colors.purple,
                  shape: GFIconButtonShape.circle,
                  size: GFSize.LARGE,
                  icon: const Icon(Icons.replay_circle_filled_rounded),
                  onPressed: () {
                    productsByCategoriesCubit
                        .getProductsByCategory(widget.category);
                  }));
        }
        return const SizedBox();
      },
    );
  }
}
