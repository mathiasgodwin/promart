import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/presentation/bloc/auth_bloc/authbloc_bloc.dart';
import 'package:promart/src/features/promart/presentation/cubit/categories/categories_cubit.dart';
import 'package:promart/src/features/promart/presentation/cubit/products_by_categories/products_by_categories_cubit.dart';

import 'package:promart/src/features/promart/presentation/cubit/single_product/single_product_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Column(
          children: const [
            Text('Promart!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 7,
            ),
            Text(
              "Let's go shopping",
              style: TextStyle(color: Colors.white, fontSize: 12),
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
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Text(
                'TOP CATEGORIES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            _AvailableCategories()
          ],
        ),
      ),
    );
  }
}

class _CategoryCards extends StatelessWidget {
  const _CategoryCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsByCategoriesCubit, ProductsByCategoriesState>(
      listener: (context, state) {
        if (state is ProductsByCategoriesError) {
          print('Could not load categories'); //
        } else if (state is ProductsByCategoriesLoading) {
          print('Display Shimmer cards');
        }
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}

class _AvailableCategories extends StatelessWidget {
  const _AvailableCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = BlocProvider.of<CategoriesCubit>(context);
    categories.getCategories();
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesLoading) {
          print('Display Shimmer cards');
        } else if (state is CategoriesError) {
          print(state.errorMessage);
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
                                  image: AssetImage('assets/images/cat2.jpg')),
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
                                        AssetImage('assets/images/cat1.jpg'))),
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
                                  image: AssetImage('assets/images/1.jpg')),
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
                                image: AssetImage('assets/images/3.jpg')),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                          // // Text(
                          // //   state.categories.data[3],
                          // //   style: const TextStyle(color: Colors.white),
                          // )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        } else if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesError) {
          return Center(
            child: Text(state.errorMessage!),
          );
        }

        return const SizedBox();
      },
    );
  }
}
