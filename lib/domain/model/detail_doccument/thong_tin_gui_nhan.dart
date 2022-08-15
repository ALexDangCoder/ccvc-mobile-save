import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

const _CHO_VAO_SO = 'Chờ vào sổ';
const _CHO_XU_LY = 'Chờ xử lý';
const _DANG_XU_LY = 'Đang xử lý';
const _DA_XU_LY = 'Đã xử lý';
const _THU_HOI = 'Thu hồi';
const _TRA_LAI = 'Trả lại';

class DataThongTinGuiNhanModel {
  String? messages;
  List<ThongTinGuiNhanModel>? data;
  String? validationResult;
  bool? isSuccess;

  DataThongTinGuiNhanModel({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });
}

class ThongTinGuiNhanModel {
  String? nguoiGui;

  String? donViGui;
  String? thoiGian;
  String? nguoiNhan;
  String? donViNhan;
  String? vaiTroXuLy;
  String? trangThai;
  String? maTrangThai;
   TRANG_THAI? trangTBGN;

  ThongTinGuiNhanModel({
    this.nguoiGui,
    this.donViGui,
    this.donViNhan,
    this.trangThai,
    this.nguoiNhan,
    this.thoiGian,
    this.vaiTroXuLy,
     this.maTrangThai,
  }) {
    trangTBGN = getString();
  }

  TRANG_THAI getString() {
    switch (trangThai) {
      case _CHO_VAO_SO:
        return TRANG_THAI.CHO_VAO_SO;
      case _CHO_XU_LY:
        return TRANG_THAI.CHO_XU_LY;
      case _DANG_XU_LY:
        return TRANG_THAI.DANG_XU_LY;
      case _DA_XU_LY:
        return TRANG_THAI.DA_XU_LY;
      case _THU_HOI:
        return TRANG_THAI.THU_HOI;
      case _TRA_LAI:
        return TRANG_THAI.TRA_LAI;
    }
    return TRANG_THAI.CHO_XU_LY;
  }

  ThongTinGuiNhanModel.fromDetail();

  List<DocumentDetailRow> toListRow({bool isTablet = false}) {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_gui,
        nguoiGui ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_gui,
        donViGui ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGian?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DATE_DD_MM_YYYY,
            ) ??
            '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_nhan,
        nguoiNhan ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_nhan,
        donViNhan ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.vai_tro_xu_ly,
        vaiTroXuLy ?? '',
        TypeDocumentDetailRow.text,
      ),
      if (!isTablet)
        DocumentDetailRow(
          S.current.trang_thai,
          trangThai ?? '',
          TypeDocumentDetailRow.text,
        )
      else
        DocumentDetailRow(
          S.current.trang_thai,
          trangThai ?? '',
          TypeDocumentDetailRow.textStatus,
        ),
    ];
    return list;
  }
}

enum TRANG_THAI {
  CHO_VAO_SO,
  CHO_XU_LY,
  DANG_XU_LY,
  DA_XU_LY,
  THU_HOI,
  TRA_LAI
}

extension TrangThaiTBGN on TRANG_THAI {
  Color getColor() {
    switch (this) {
      case TRANG_THAI.CHO_VAO_SO:
        return blueDamChart;
      case TRANG_THAI.CHO_XU_LY:
        return choTrinhKyColor;
      case TRANG_THAI.DANG_XU_LY:
        return textColorForum;
      case TRANG_THAI.DA_XU_LY:
        return greenChart;
      case TRANG_THAI.THU_HOI:
        return colorEA5455;
      case TRANG_THAI.TRA_LAI:
        return blueNhatChart;
    }
  }
}
