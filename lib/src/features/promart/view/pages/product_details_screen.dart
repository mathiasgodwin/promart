import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/logic/logic.dart';
import 'package:promart/src/features/promart/view/view.dart';
import 'package:promart_api/promart.dart';

class ProductDetailsScreen extends StatefulWidget {
  final AllProductData productData;
  const ProductDetailsScreen(this.productData, {Key? key}) : super(key: key);

  //
  Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ProductDetailsScreen(productData));
  }

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      bottomNavigationBar: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GFButton(
              color: Colors.black,
              onPressed: () {
                context
                    .read<CartBloc>()
                    .add(ProductAdded(product: widget.productData));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('Item Added to Cart'),
                    duration: Duration(seconds: 1),
                  ));
              },
              text: 'ADD TO CART',
            ),
            GFButton(
              color: Colors.purple,
              onPressed: () {
                context
                    .read<CartBloc>()
                    .add(ProductAdded(product: widget.productData));
                Navigator.of(context).push<void>(CartScreenScaffold.route());
              },
              text: 'BUY NOW',
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: GFCard(
                padding: const EdgeInsets.all(0),
                image: Image.network(
                  widget.productData.image,
                  height: 250.w,
                ),
                showImage: true,
                title: GFListTile(
                  padding: EdgeInsets.only(top: 16.w, left: 0.0, right: 0.0),
                  margin: EdgeInsets.zero,
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GFIconButton(
                        color: GFColors.TRANSPARENT,
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () {},
                      ),
                      GFIconButton(
                        color: GFColors.TRANSPARENT,
                        icon: const Icon(Icons.shopping_bag),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                titlePosition: GFPosition.start,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Text(widget.productData.title,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(widget.productData.title,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GFButton(
                              onPressed: () {},
                              color: Colors.green.withOpacity(0.1),
                              text: 'Extra ₦200 Off',
                              textStyle: TextStyle(
                                  fontSize: 10.sp, color: Colors.black),
                              shape: GFButtonShape.pills,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            GFButton(
                              onPressed: () {},
                              color: Colors.red.withOpacity(0.1),
                              text: 'EMI Starts from ₦451',
                              textStyle:
                                  TextStyle(fontSize: 10.sp, color: Colors.red),
                              shape: GFButtonShape.pills,
                            ),
                          ],
                        ),
                        BlocBuilder<WishlistBloc, WishlistState>(
                          buildWhen: (prev, current) =>
                              prev.items != prev.items,
                          builder: (context, state) {
                            final _item =
                                WishAdded(product: widget.productData);
                            final _wish =
                                WishlistItem(product: widget.productData);

                            // Check if item is a favorite already
                            final _isWished = state.items.contains(_wish);
                            return GFIconButton(
                                key: const Key('GFIconbutton_wishlist_icon'),
                                shape: GFIconButtonShape.circle,
                                color: Colors.white,
                                icon: _isWished
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                                onPressed: () {
                                  // Widget should rebuild to update favorite icon
                                  context.watch<WishlistBloc>().add(_item);
                                  // if (_isWished) {
                                  //   ScaffoldMessenger.of(context)
                                  //     ..hideCurrentSnackBar()
                                  //     ..showSnackBar(const SnackBar(
                                  //       content: Text('Removed from Wishlist'),
                                  //       duration: Duration(seconds: 1),
                                  //     ));
                                  // } else {
                                  //   ScaffoldMessenger.of(context)
                                  //     ..hideCurrentSnackBar()
                                  //     ..showSnackBar(const SnackBar(
                                  //       content: Text('Added to Wishlist'),
                                  //       duration: Duration(seconds: 1),
                                  //     ));
                                  // }
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,

                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '₦' + widget.productData.price.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₦' + widget.productData.price.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp),
                              ),
                            ],
                            // , breast cancer
                          ),
                          RichText(
                            text: const TextSpan(
                              text: '53% Off',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(child: SizedBox(height: 10.w)),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      'PRODUCT DESCRIPTION',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  widget.productData.description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const Flexible(child: _RowDivider('RELATED PRODUCTS')),

            /// Give constraints to scrollable inside another scrollable else
            /// You'll hit a RenderObject object error!
            Flexible(
              fit: FlexFit.loose,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300.w),
                child: BlocProvider(
                  create: (context) => ProductsByCategoriesCubit(
                      repository:
                          RepositoryProvider.of<PromartRepository>(context))
                    ..getProductsByCategory('electronics'),
                  child: const ProductByCategoryName(category: 'electronics'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
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
