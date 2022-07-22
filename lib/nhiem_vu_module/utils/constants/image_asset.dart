import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const baseImg = 'lib/nhiem_vu_module/assets/images';

class ImageAssets {
  ///Svg path
  static const String ic_gui_y_kien = '$baseImg/icon_send.svg';
  static const String icMenuCalender = '$baseImg/menu_calender.svg';
  static const String icBack = '$baseImg/ic_back.svg';
  static const String icDonViNhiemVu = '$baseImg/ic_don_vi_nhiem_vu.svg';
  static const String icPerson = '$baseImg/ic_person.svg';
  static const String icQuanLyNhiemVu = '$baseImg/ic_quan_ly_nhiem_vu.svg';
  static const String icExit = '$baseImg/ic_exit.svg';
  static const String ic_next_color = '$baseImg/ic_next_color.svg';
  static const String ic_chitet = '$baseImg/ic_chitiet.svg';
  static const String icThongKe = '$baseImg/ic_thong_ke.svg';
  static const String icNoDataNhiemVu = '$baseImg/ic_no_data_nhiem_vu.svg';
  static const String ic_up = '$baseImg/ic_up.svg';
  static const String ic_drop_down = '$baseImg/ic_drop_down.svg';

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
