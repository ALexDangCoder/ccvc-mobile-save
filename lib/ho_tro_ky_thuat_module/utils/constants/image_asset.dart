import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const baseImg = 'lib/ho_tro_ky_thuat_module/assets/images';

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
  static const String ic_chia_se = '$baseImg/share_svg.svg';
  static const String ic_star_bold = '$baseImg/star_bold_svg.svg';
  static const String img_company = '$baseImg/img_companies.png';
  static const String img_companies_svg = '$baseImg/img_company.svg';
  static const String ic_copy = '$baseImg/ic_copy.svg';

  //
  static const String ic_call = '$baseImg/ic_call.svg';
  static const String ic_ho_tro_ky_thuat = '$baseImg/ic_ho_tro_ky_thuat.svg';
  static const String ic_phone = '$baseImg/ic_phone.svg';
  static const String ic_document = '$baseImg/ic_document.svg';
  static const String ic_info_circle = '$baseImg/ic_info_circle.svg';
  static const String ic_search = '$baseImg/ic_search.svg';
  static const String ic_delete = '$baseImg/ic_delete.svg';
  static const String ic_document_blue = '$baseImg/ic_document_blue.svg';
  static const String ic_edit = '$baseImg/ic_edit.svg';
  static const String ic_update = '$baseImg/ic_update.svg';
  static const String ic_more = '$baseImg/ic_more.svg';
  static const String ic_up = '$baseImg/ic_up.svg';
  static const String ic_drop_down = '$baseImg/ic_drop_down.svg';
  static const String icCalenders = '$baseImg/ic_calendar.svg';
  static const String icError = '$baseImg/ic_error.svg';
  static const String icSucces = '$baseImg/ic_succes.svg';
  static const String icClose = '$baseImg/ic_close.svg';
  static const String icSearchColor = '$baseImg/ic_search_color.svg';

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
