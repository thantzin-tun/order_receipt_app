import 'dart:ui';
import 'package:flutter/material.dart';
import "responsive.dart";

class HeaderFont  {
    //header mobileFontSize
    static const mobileHeaderFont = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

  //header for tablet fontSize
  static const tabletHeaderFont = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );

    //header for web fontSize
  static const webHeaderFont = TextStyle(
      color: Colors.yellow,
      fontWeight: FontWeight.w600,
      fontSize: 50,
    );

}

//Footer Font
class FooterFont  {
    //footer mobileFontSize
    static const mobileFooterFont = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

  //footer for tablet fontSize
  static const tabletFooterFont = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );

    
}

// extension MediaQueryValues on BuildContext {
//   double get screenWidth => MediaQuery.of(this).size.width;
//   double get screenHeight => MediaQuery.of(this).size.height;
// }

//Item TextSize for ThreeScreen
final TextStyle itemMobileFontSize = TextStyle(fontSize: 13,);
final TextStyle itemTabledFontSize = TextStyle(fontSize: 20);

