import 'package:ccvc_mobile/config/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  ///Svg path
  static const String icBack = '$baseImg/ic_back.svg';
  static const String icHomeFocus = '$baseImg/ic_home.svg';
  static const String icHomeUnFocus = '$baseImg/ic_home_unfocus.svg';
  static const String icChartUnFocus = '$baseImg/ic_chart.svg';
  static const String icChartFocus = '$baseImg/ic_bao_cao.svg';
  static const String icCalendarUnFocus = '$baseImg/ic_calendar.svg';
  static const String icCalendarFocus = '$baseImg/ic_calendar_focus.svg';
  static const String icMessageUnFocus = '$baseImg/ic_message.svg';
  static const String icMessageFocus = '$baseImg/ic_chat_focus.svg';
  static const String icMenuUnFocus = '$baseImg/ic_menu.svg';
  static const String icMenuFocus = '$baseImg/ic_menu_focus.svg';
  static const String icPlus = '$baseImg/ic_cong.svg';
  static const String icClose = '$baseImg/ic_close.svg';
  static const String icNext = '$baseImg/ic_next.svg';
  static const String icSinhNhat = '$baseImg/ic_sinh_nhat.svg';
  static const String icNextDropDown = '$baseImg/ic_next_drop_down.svg';
  static const String icBackDropDown = '$baseImg/ic_back_drop_down.svg';
  static const String icDropDownButton = '$baseImg/ic_drop_down_button_down.svg';

  ///SvgImage
  static const String icStar = '$baseImg/ic_start.png';

  static SvgPicture svgAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit? fit,
    BlendMode? blendMode,
  }) {
    final size = _svgImageSize[name];
    var w = width;
    var h = height;
    if (size != null) {
      w = width ?? size[0];
      h = height ?? size[1];
    }
    return SvgPicture.asset(
      name,
      colorBlendMode: blendMode ?? BlendMode.srcIn,
      color: color,
      width: w,
      height: h,
      fit: fit ?? BoxFit.none,
    );
  }

  static const Map<String, List<double>> _svgImageSize = {};
}
