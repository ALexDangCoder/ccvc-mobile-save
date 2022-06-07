import 'package:ccvc_mobile/diem_danh_module/config/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  ///Svg path
  static const String icDiMuon = '$baseImg/ic_di_muon.svg';
  static const String icDiemDanhTopMenu = '$baseImg/ic_diem_danh_top_menu.svg';
  static const String icDiemDanhCaNhan = '$baseImg/ic_diem_danh_ca_nhan.svg';
  static const String icDiemDanhKhuonMat = '$baseImg/ic_diem_danh_khuon_mat.svg';
  static const String icDiemDanhBienSoXe = '$baseImg/ic_diem_danh_bien_so_xe.svg';
  static const String icMenuCalender = '$baseImg/menu_calender.svg';
  static const String icBack = '$baseImg/ic_back.svg';
  static const String icExit = '$baseImg/ic_exit.svg';


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
