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
const itemWidgetUsing = Color(0xff28C76F);
const itemWidgetNotUse = Color(0xffFF9F43);
const backgroundWidget = Color(0xffF0F6FF);
const textDefault = Color(0xff7966FF);
const textTitle = Color(0xff3D5586);
const bgWidgets = Color(0xffF9FAFF);

const textDropDownColor = Color(0xff3D5586);
const bgDropDown = Color(0xFFE2E8F0);
const bgButtonDropDown = Color(0xff7966FF);

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
const titleCalenderWork = Color(0xff3D5586);
const textBodyTime = Color(0xffA2AEBD);
const statusCalenderRed = Color(0xffEA5455);
const backgroundItemCalender = Color(0xffF5F8FD);
const borderItemCalender = Color(0xffE2E8F0);
const numberOfCalenders = Color(0xff5A8DEE);
const colorNumberCellQLVB=Color(0xff586B8B);

//tabbar color
const labelColor = Color(0xff7966FF);
const unselectedLabelColor = Color(0xff667793);
const indicatorColor = Color(0xff7966FF);
const titleColor = Color(0xFF3D5586);
const colorBlack=Color(0xff000000);
const errorBorderColor= Color(0xFF585782);

const lineColor = Color(0xffECEEF7);
const buttonColor = Color(0xff7966FF);
const buttonColor2 = Color(0x1A7966FF);
//tabar color
const unselectLabelColor = Color(0xFFA2AEBD);
//drawer menu color
const backgroundDrawerMenu = Color(0xFF333333);
const backgroundDrawer = Colors.black12;
const fontColor = Colors.white;

const dateColor = Color(0xFF667793);

//tất cả chủ đề color
const textColorTongTin = Color(0xFF39CEAD);
const textColorBaoChi = Color(0xFFF763A0);
const textColorMangXaHoi = Color(0xFF2F80ED);
const textColorForum = Color(0xFFFF9F43);
const textColorBlog = Color(0xFF7367F0);
const textColorNguonKhac = Color(0xFFF57168);
const titleColumn = Color(0xFF667793);
const iconColor = Color(0xFFDADADA);

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

  Color backGroundColor();

  Color subTitleColor();
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

  @override
  Color backGroundColor() {
    return const Color(0xffFFFFFF);
  }

  @override
  Color subTitleColor() {
    return const Color(0xff5A8DEE);
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

  @override
  Color backGroundColor() {
    return Colors.black.withOpacity(0.8);
  }

  @override
  Color subTitleColor() {
    // TODO: implement subTitleColor
    throw UnimplementedError();
  }
}

///============ End setup app theme ======================================
