import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

enum TypeDataNV { file, status, text }

extension TypeData on TypeDataNV {
  Widget getWidget({
    required RowDataExpandModel row,
    required ChiTietNVCubit cubit,
  }) {
    switch (this) {
      case TypeDataNV.text:
        return Text(
          row.value,
          style: textNormalCustom(
            color: textTitle,
            fontWeight: FontWeight.w400,
            fontSize: 14.0.textScale(),
          ),
        );
      case TypeDataNV.file:
        {
          final data = row.value as File;
          return Text(
            data.path,
            style: textNormalCustom(
              color: choXuLyColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          );
        }

      case TypeDataNV.status: {
        final data = row.value as String;

        return data.getStatusNV().getStatus();
      }
    }
  }
}

enum StatusNV { QUA_HAN, CHUA_THUC_HIEN, DANG_THUC_HIEN,THU_HOI,DA_HOAN_THANH,CHO_PHAN_XU_LY,TRA_LAI}

extension StatusChiTietNV on StatusNV {
  Widget getStatus() {
    switch (this) {
      case StatusNV.QUA_HAN:
        return StatusChiTietNhiemVu(
            name: S.current.qua_han, background: statusCalenderRed,);
      case StatusNV.CHUA_THUC_HIEN:
        return StatusChiTietNhiemVu(
          name: S.current.chua_thuc_hien, background: AqiColor,);
      case StatusNV.DANG_THUC_HIEN :
       return StatusChiTietNhiemVu(
          name: S.current.dang_thuc_hien, background: yellowColor,);
      case StatusNV.THU_HOI :
        return StatusChiTietNhiemVu(
          name: S.current.thu_hoi, background: yellowColor,);
      case StatusNV.DA_HOAN_THANH :
        return StatusChiTietNhiemVu(
          name: S.current.da_hoan_thanh, background: daXuLyColor,);
      case StatusNV.CHO_PHAN_XU_LY :
        return StatusChiTietNhiemVu(
          name: S.current.cho_phan_xu_ly, background: choXuLyColor,);
      case StatusNV.TRA_LAI :
        return StatusChiTietNhiemVu(
          name: S.current.tra_lai, background: statusCalenderRed,);
    }
  }
}

extension GetStatusNV on String {
  StatusNV getStatusNV () {
    switch(this) {
      case 'QUA_HAN' :
        return StatusNV.QUA_HAN;
      case 'CHUA_THUC_HIEN':
        return StatusNV.CHUA_THUC_HIEN;
      case 'DANG_THUC_HIEN' :
        return StatusNV.DANG_THUC_HIEN;
      case 'THU_HOI' :
        return StatusNV.THU_HOI;
      case 'DA_HOAN_THANH' :
        return StatusNV.DA_HOAN_THANH;
      case 'CHO_PHAN_XU_LY' :
        return StatusNV.CHO_PHAN_XU_LY;
      case 'TRA_LAI' :
        return StatusNV.TRA_LAI;

      default :
        return StatusNV.QUA_HAN;
    }
  }
}

Widget StatusChiTietNhiemVu({required String name, required Color background}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0.textScale(),
          vertical: 4.0.textScale(),
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          name,
          style: textNormalCustom(
            color: Colors.white,
            fontSize: 12.0.textScale(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
