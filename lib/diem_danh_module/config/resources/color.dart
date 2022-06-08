import 'dart:ui';

import 'package:flutter/material.dart';

///=========== Colors for default when didn't setup app theme ===============
///https://stackoverflow.com/a/17239853
const colorPrimary = Color(0xff0ABAB5);
const colorPrimaryTransparent = Color(0x720ABAB5);
const colorAccent = Color(0xffDCFFFE);
const colorSelected = Color(0xFFE0F2F1);
const mainTxtColor = Color(0xFF30536F);
const dfTxtColor = Color(0xFF303742);
const secondTxtColor = Color(0xFF808FA8);
const highlightTxtColor = Color(0xff303742);
const subTitle = Color(0xff8F9CAE);
const attackFile = Color(0xff8F9CAE);

const color3D5586 = Color(0xff3D5586);

///=========== Using to make change app theme ================================
abstract class AppColor {
  Color titleColor();
}

class LightApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }
}

class DarkApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }
}

class DefaultApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }
}

class BlueApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }
}

class PinkApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }
}

class YellowApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }
}
