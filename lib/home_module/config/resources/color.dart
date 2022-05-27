import 'dart:ui';

import 'package:flutter/material.dart';

///=========== Colors for default when didn't setup app theme ===============
///https://stackoverflow.com/a/17239853
const colorPrimary = Color(0xff0ABAB5);

const subTitle = Color(0xff8F9CAE);

const tabSelected = Color(0xff0ABAB5);

const sideTextInactiveColor = Color(0xFFB9C4D0);

const dividerColor = Color(0xffcacfd7);
const sideBtnSelected = Color(0xff0ABAB5);

const specialPriceColor = Color(0xffEB5757);

const itemWidgetUsing = Color(0xff28C76F);
const itemWidgetNotUse = Color(0xffFF9F43);

const textDefault = Color(0xff7966FF);
const textTitle = Color(0xff3D5586);
const titleItemEdit = Color(0xff586B8B);

const homeColor = Color(0xffEEF3FF);
const borderColor = Color(0xffDBDFEF);
const AqiColor = Color(0xffA2AEBD);
const infoColor = Color(0xff667793);
const linkColor = Color(0xff7966FF);
const shadowContainerColor = Color(0xff6566E9);
const choXuLyColor = Color(0xff5A8DEE);
const dangXyLyColor = Color(0xff7966FF);
const daXuLyColor = Color(0xff28C76F);
const choVaoSoColor = Color(0xffFF9F43);
const choTrinhKyColor = Color(0xff02C5DD);
const choCapSoColor = Color(0xffFF6D99);
const choBanHanhColor = Color(0xff374FC7);
const radioUnfocusColor = Color(0xffE2E8F0);
const radioFocusColor = Color(0xff7966FF);
const borderButtomColor = Color(0xffE2E8F0);
const backgroundRowColor = Color(0xffF5F8FD);

const backgroundColorApp = Color(0xffffffff);

const textBodyTime = Color(0xffA2AEBD);
const statusCalenderRed = Color(0xffEA5455);

const borderItemCalender = Color(0xffE2E8F0);
const numberOfCalenders = Color(0xff5A8DEE);

const dotColor = Color(0xffD4DAE3);
const yellowColor = Color(0xffFDB000);

const labelColor = Color(0xff7966FF);

const indicatorColor = Color(0xff7966FF);
const titleColor = Color(0xFF3D5586);

const lineColor = Color(0xffECEEF7);
const buttonColor = Color(0xff7966FF);
const buttonColor2 = Color(0x1A7966FF);

const unselectLabelColor = Color(0xFFA2AEBD);

const dateColor = Color(0xFF667793);
const dfBtnTxtColor = Color(0xFFFFFFFF);

const titleColumn = Color(0xFF667793);

const bgTabletColor = Color(0xffF9FAFF);

const unFocusColor = Color(0xffF2F0FF);

const pinkColor = Color(0xffFB7897);

const textTitleColumn = Color(0xff667793);

///=========== Using to make change app theme ================================
abstract class AppColor {
  Color colorSelect();
}

class LightApp extends AppColor {
  @override
  Color colorSelect() {
    return Colors.white;
  }
}

class DarkApp extends AppColor {
  @override
  Color colorSelect() {
    return Colors.white;
  }
}

class DefaultApp extends AppColor {
  @override
  Color colorSelect() {
    return textDefault;
  }
}

class BlueApp extends AppColor {
  @override
  Color colorSelect() {
    return numberOfCalenders;
  }
}

class PinkApp extends AppColor {
  @override
  Color colorSelect() {
    return pinkColor;
  }
}

class YellowApp extends AppColor {
  @override
  Color colorSelect() {
    return yellowColor;
  }
}

///============ End setup app theme ======================================
