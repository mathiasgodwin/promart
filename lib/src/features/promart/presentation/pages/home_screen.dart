import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/core/utils/screen/screen_util.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/categories/categories_cubit.dart';
import 'package:promart/src/features/promart/presentation/cubit/products_by_categories/products_by_categories_cubit.dart';
import 'package:promart/src/features/promart/presentation/cubit/promart_catalogue/promart_catalogue_cubit.dart';

import 'package:promart/src/features/promart/presentation/cubit/single_product/single_product_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/product_details_screen.dart';
import 'package:promart/src/features/promart/presentation/widgets/products_listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
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
            create: (_) => CategoriesCubit(
                repository: RepositoryProvider.of<PromartRepository>(context))
              ..getCategories(),
          ),
          BlocProvider<ProductsByCategoriesCubit>(
            create: (_) => ProductsByCategoriesCubit(
                repository: RepositoryProvider.of<PromartRepository>(context))
              ..getProductsByCategory('electronics'),
          ),
          BlocProvider<SingleProductCubit>(
            create: (_) => SingleProductCubit(),
          ),
          BlocProvider<PromartCatalogCubit>(
            create: (_) => PromartCatalogCubit(
                // We are specifying the ..loadCatalog to load the Catalog on screen load
                repository: RepositoryProvider.of<PromartRepository>(context))
              ..loadCatalog(),
          ),
        ],
        child: ListView(
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
        ),
      ),
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
      buildWhen: (prev, current) => prev.categories != current.categories,
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
          return const Padding(
            padding: EdgeInsets.only(left: 10),
            child: _CategoriesScrollViewWidget(),
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

class _CategoriesScrollViewWidget extends StatelessWidget {
  const _CategoriesScrollViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/cat3.jpg'))),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
        ));
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
        buildWhen: (prev, current) => prev.catalog != current.catalog,
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
            )));
          } else if (state.status == PromartCatalogStatus.failure) {
            return Center(
                child: GFIconButton(
                    color: Colors.purple,
                    shape: GFIconButtonShape.circle,
                    size: GFSize.LARGE,
                    icon: const Icon(Icons.replay_circle_filled_rounded),
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
