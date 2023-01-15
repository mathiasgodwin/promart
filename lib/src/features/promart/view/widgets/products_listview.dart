import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/core/utils/screen/screen_util.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/view.dart';


class ProductByCategoryName extends StatelessWidget {
  final String? category;
  const ProductByCategoryName({required this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _w = size(context).width;

    return BlocConsumer<ProductsByCategoriesCubit, ProductsByCategoriesState>(
      buildWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state.status == ProductByCategoriesStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content:
                    Text(state.errorMessage ?? 'Could not load, try again')));
        } else if (state.status == ProductByCategoriesStatus.loading) {}
      },
      builder: (context, state) {
        if (state.status == ProductByCategoriesStatus.loaded) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 8.w, right: 8.w),
            height: 270.w,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.products!.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = state.products!.data[index];
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
        } else if (state.status == ProductByCategoriesStatus.loading) {
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
        } else if (state.status == ProductByCategoriesStatus.failure) {
          return Center(
            child: GFIconButton(
              color: Colors.purple,
              shape: GFIconButtonShape.circle,
              size: GFSize.LARGE,
              icon: const Icon(Icons.replay),
              onPressed: () {
                context
                    .read<ProductsByCategoriesCubit>()
                    .getProductsByCategory('electronics');
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
