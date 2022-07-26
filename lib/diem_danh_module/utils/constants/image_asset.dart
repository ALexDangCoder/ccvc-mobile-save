import 'package:ccvc_mobile/diem_danh_module/config/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  ///Svg path
  static const String icDiMuon = '$baseImg/ic_di_muon.svg';
  static const String icDiemDanhTopMenu = '$baseImg/ic_diem_danh_top_menu.svg';
  static const String icDiemDanhCaNhan = '$baseImg/ic_diem_danh_ca_nhan.svg';
  static const String icDiemDanhKhuonMat =
      '$baseImg/ic_diem_danh_khuon_mat.svg';
  static const String icDiemDanhBienSoXe =
      '$baseImg/ic_diem_danh_bien_so_xe.svg';
  static const String icMenuCalender = '$baseImg/menu_calender.svg';
  static const String icBack = '$baseImg/ic_back.svg';
  static const String icExit = '$baseImg/ic_exit.svg';
  static const String icUpAnh = '$baseImg/ic_up_anh.svg';
  static const String imgAnhChinhDien = '$baseImg/anh_chinh_dien.jpg';
  static const String imgAnhChinhDienDeoKinh =
      '$baseImg/anh_chinh_dien_deo_kinh.jpg';
  static const String imgAnhChupMatTuDuoiLen =
      '$baseImg/anh_chup_mat_tu_duoi_len.jpg';
  static const String imgAnhChupMatTuDuoiLenDeoKinh =
      '$baseImg/anh_chup_mat_tu_duoi_len_deo_kinh.jpg';
  static const String imgAnhChupMatTuTrenXuong =
      '$baseImg/anh_chup_mat_tu_tren_xuong.jpg';
  static const String imgAnhChupMatTuTrenXuongDeoKinh =
      '$baseImg/anh_chup_mat_tu_tren_xuong_deo_kinh.jpg';
  static const String imgAnhNhinSangPhai = '$baseImg/anh_nhin_sang_phai.jpg';
  static const String imgAnhNhinSangPhaiDeoKinh =
      '$baseImg/anh_nhin_sang_phai_deo_kinh.jpg';
  static const String imgAnhNhinSangTrai = '$baseImg/anh_nhin_sang_trai.jpg';
  static const String imgAnhNhinSangTraiDeoKinh =
      '$baseImg/anh_nhin_sang_trai_deo_kinh.jpg';
  static const String icVectorFloatAction =
      '$baseImg/ic_vector_float_action.svg';
  static const String icXoaNhanhDienBienSoXe =
      '$baseImg/ic_xoa_nhan_dien_bien_so_xe.svg';
  static const String imgDangKyXeSvg = '$baseImg/image_dang_ky_xe.svg';
  static const String icRemoveImg = '$baseImg/ic_remove_img.svg';
  static const String icNghiLam = '$baseImg/ic_nghi_lam.svg';
  static const String icMuon = '$baseImg/ic_muon.svg';
  static const String icDiLam = '$baseImg/ic_di_lam.svg';
  static const String icKhongLyDo = '$baseImg/ic_khong_ly_do.svg';
  static const String icNghiPhep = '$baseImg/ic_nghi_phep.svg';
  static const String icVeSom = '$baseImg/ic_ve_som.svg';
  static const String ic_tick_showToast = '$baseImg/ic_tick_show_toast.svg';

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
