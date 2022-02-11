import 'package:flutter/material.dart';

/// This remove the scroll glow from the entire app.
/// Check usage at the init of MaterialApp widget.
/// Suggested by: Remi Rousselet (StackOverflow Answer)
///
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
