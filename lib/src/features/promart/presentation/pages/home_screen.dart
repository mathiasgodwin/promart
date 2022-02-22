import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/src/features/promart/presentation/bloc/cart_bloc/cart_bloc.dart';

import '../pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BottomNavigationBarItem> _tabItem = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_filled),
    ),
    const BottomNavigationBarItem(
      label: 'Wishlist',
      icon: Icon(Icons.favorite),
    ),
    BottomNavigationBarItem(
        label: 'Carts',
        icon: BlocBuilder<CartBloc, CartState>(
          buildWhen: (prev, current) =>
              prev.items.length != current.items.length,
          builder: (context, state) {
            return GFIconBadge(
              key: const Key('HomeCart_iconButtonBadge'),
              counterChild: GFBadge(
                child: Text(
                  state.items.length.toString(),
                ),
              ),
              child: GFIconButton(
                  shape: GFIconButtonShape.circle,
                  icon: const Icon(Icons.shopping_basket_outlined),
                  onPressed: () {
                    Navigator.of(context).push<void>(CartScreen.route());
                  }),
            );
          },
        )),
    const BottomNavigationBarItem(
      label: 'Account',
      icon: Icon(Icons.person),
    ),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    //
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        items: _tabItem,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
      ),
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}
