import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  // The account screen doesn't construct an app bar
  static PreferredSizeWidget?  appBar() => null;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Account Screen'));
  }
}
