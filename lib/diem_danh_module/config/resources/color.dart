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
const colorEA5455 = Color(0xFFEA5455);
const color20C997 = Color(0xFF20C997);
const color3D5586 = Color(0xff3D5586);
const colorE2E8F0 = Color(0xffE2E8F0);
const colorFFFFFF = Color(0xffffffff);
const color667793 = Color(0xff667793);
const colorECEEF7 = Color(0xffECEEF7);
const color7966FF = Color(0xff7966FF);
const colorA2AEBD = Color(0xffA2AEBD);
const colorF9FAFF = Color(0xffF9FAFF);
const colorF44336 = Color(0xFFF44336);
const color000000 = Color(0xff000000);
const colorE5E5E5 = Color(0xffE5E5E5);
const colorE9F9F1 = Color(0xffE9F9F1);
const colord32f2f = Color(0xFFd32f2f);


///=========== Using to make change app theme ================================
abstract class AppColor {
  Color titleColor();

  Color borderItemCalender();

  Color backgroundColorApp();

  Color contentColor();
}

class LightApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }

  @override
  Color borderItemCalender() {
    return colorE2E8F0;
  }

  @override
  Color backgroundColorApp() {
    return colorFFFFFF;
  }

  @override
  Color contentColor() {
    return color667793;
  }
}

class DarkApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }

  @override
  Color borderItemCalender() {
    return colorE2E8F0;
  }

  @override
  Color backgroundColorApp() {
    return colorFFFFFF;
  }

  @override
  Color contentColor() {
    return color667793;
  }
}

class DefaultApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }

  @override
  Color borderItemCalender() {
    return colorE2E8F0;
  }

  @override
  Color backgroundColorApp() {
    return colorFFFFFF;
  }

  @override
  Color contentColor() {
    return color667793;
  }
}

class BlueApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }

  @override
  Color borderItemCalender() {
    return colorE2E8F0;
  }

  @override
  Color backgroundColorApp() {
    return colorFFFFFF;
  }

  @override
  Color contentColor() {
    return color667793;
  }
}

class PinkApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }

  @override
  Color borderItemCalender() {
    return colorE2E8F0;
  }

  @override
  Color backgroundColorApp() {
    return colorFFFFFF;
  }

  @override
  Color contentColor() {
    return color667793;
  }
}

class YellowApp extends AppColor {
  @override
  Color titleColor() {
    return color3D5586;
  }

  @override
  Color borderItemCalender() {
    return colorE2E8F0;
  }

  @override
  Color backgroundColorApp() {
    return colorFFFFFF;
  }

  @override
  Color contentColor() {
    return color667793;
  }
}
