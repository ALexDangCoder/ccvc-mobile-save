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
const subTitleTxtColor = Color(0xff9097A3);

//bottom navigation color
const bgBottomTab = Color(0xFFFCFCFC);
const tabSelected = Color(0xff0ABAB5);
const tabUnselected = Color(0xFFA9B8BD);

//custom color
const signInRowColor = Color(0xFFA9B8BD);
const signInTextColor = Color(0xff0ABAB5);
const sideTextInactiveColor = Color(0xFFB9C4D0);
const signInTextSecondaryColor = Color(0xFF8F8F8F);
const dotActiveColor = Color(0xff0ABAB5);
const dividerColor = Color(0xffcacfd7);
const sideBtnSelected = Color(0xff0ABAB5);
const sideBtnUnselected = Color(0xff9097A3);
const underLine = Color(0xffDBDBDB);
const specialPriceColor = Color(0xffEB5757);
const otherColor = Color(0xff303742);
const pendingColor = Color(0xff303742);
const processingColor = Color(0xffFE8922);
const deliveredColor = Color(0xff19A865);
const canceledColor = Color(0xffF94444);
const subMenuColor = Color(0xff303742);
const colorLineSearch = Color(0x80CACFD7);
const colorPressedItemMenu = Color(0xffE7F8F8);
const fittingBg = Color(0xFFF2F2F2);

//tabar color
const indicatorColor = Color(0xFF7966FF);
const unselectLabelColor = Color(0xFFA2AEBD);
const labelColor = Color(0xFF304261);
const titleColor = Color(0xFF3D5586);
///=========== Using to make change app theme ================================
abstract class AppColor {
  Color primaryColor();

  Color accentColor();

  Color statusColor();

  Color mainColor();

  Color bgColor();

  Color dfTxtColor();

  Color secondTxtColor();

  Color dfBtnColor();

  Color dfBtnTxtColor();

  Color txtLightColor();

  Color sideBtnColor();

  Color disableColor();

  Color titleColor();
}

class LightApp extends AppColor {
  @override
  Color primaryColor() {
    return colorPrimary;
  }

  @override
  Color accentColor() {
    return colorAccent;
  }

  @override
  Color statusColor() {
    return const Color(0xFFFCFCFC);
  }

  @override
  Color mainColor() {
    return const Color(0xFF30536F);
  }

  @override
  Color bgColor() {
    return const Color(0xFFFCFCFC);
  }

  @override
  Color dfBtnColor() {
    return const Color(0xFF324452);
  }

  @override
  Color dfBtnTxtColor() {
    return const Color(0xFFFFFFFF);
  }

  @override
  Color dfTxtColor() {
    return const Color(0xFF303742);
  }

  @override
  Color secondTxtColor() {
    return const Color(0xFF9097A3);
  }

  @override
  Color txtLightColor() {
    return Colors.white.withOpacity(0.85);
  }

  @override
  Color sideBtnColor() {
    return const Color(0xFFDCFFFE);
  }

  @override
  Color disableColor() {
    return const Color(0xFFA9B8BD);
  }

  @override
  Color titleColor() {
   return const Color(0xff3D5586);
  }
}

class DarkApp extends AppColor {
  @override
  Color primaryColor() {
    return Colors.black;
  }

  @override
  Color accentColor() {
    return Colors.black;
  }

  @override
  Color statusColor() {
    return Colors.black;
  }

  @override
  Color mainColor() {
    return Colors.black.withOpacity(0.8);
  }

  @override
  Color bgColor() {
    return Colors.black.withOpacity(0.8);
  }

  @override
  Color dfBtnColor() {
    return Colors.white.withOpacity(0.8);
  }

  @override
  Color dfBtnTxtColor() {
    return Colors.black.withOpacity(0.6);
  }

  @override
  Color dfTxtColor() {
    return Colors.white.withOpacity(0.6);
  }

  @override
  Color secondTxtColor() {
    return Colors.black.withOpacity(0.4);
  }

  @override
  Color txtLightColor() {
    return Colors.white.withOpacity(0.85);
  }

  @override
  Color sideBtnColor() {
    return const Color(0xFFA9B8BD);
  }

  @override
  Color disableColor() {
    return Colors.grey;
  }

  @override
  Color titleColor() {
      return const Color(0xffFFFFFF);
  }
}

///============ End setup app theme ======================================
