import 'package:flutter/material.dart';

Size size(BuildContext context) {
  return MediaQuery.of(context).size;
}

double height(BuildContext context) {
  return size(context).height;
}

double width(BuildContext context) {
  return size(context).width;
}

/// Returns the height of the device considering status bar height only
double normalHeight(BuildContext context) {
  return height(context) - MediaQuery.of(context).padding.top;
}

/// Returns the height of the device considering status bar and Appbar height only
double actualHeight(BuildContext context) {
  return height(context) - MediaQuery.of(context).padding.top - kToolbarHeight;
}

/// Returns the height of the device considering status bar, appbar and bottom bar height
double naturalHeight(BuildContext context) {
  return height(context) -
      MediaQuery.of(context).padding.top -
      kToolbarHeight -
      kBottomNavigationBarHeight;
}
