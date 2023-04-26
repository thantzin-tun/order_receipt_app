// import "package:flutter/material.dart";

// class DeviceScreen {

//   static double? getScreenWidth(BuildContext context) {
//     return MediaQuery.of(context).size.width;
//   }
//   static double getScreenHeight(BuildContext context) {
//     return MediaQuery.of(context).size.height;
//   }

// }

import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
