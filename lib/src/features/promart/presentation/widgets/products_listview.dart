import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/presentation/cubit/products_by_categories/products_by_categories_cubit.dart';
import 'package:promart/src/features/promart/presentation/pages/product_details_screen.dart';

class ProductByCategoryName extends StatefulWidget {
  const ProductByCategoryName(this.category, {Key? key}) : super(key: key);

  final String category;

  @override
  State<ProductByCategoryName> createState() => ProductByCategoryNameState();
}

class ProductByCategoryNameState extends State<ProductByCategoryName> {
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
            margin: EdgeInsets.only(left: 8.w, right: 8.w),
            height: 270.w,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.products.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = state.products.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push<void>(ProductDetailsScreen(item).route());
                  },
                  child: SizedBox(
                    width: 0.2.sh,
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
