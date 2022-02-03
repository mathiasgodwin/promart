import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
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
        child: const _AvailableCategories(),
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
          return Container(
            color: Colors.green,
            child: Text(state.categories.data.first),
          );
        } else if (state is CategoriesLoading) {
          return const CircularProgressIndicator();
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
