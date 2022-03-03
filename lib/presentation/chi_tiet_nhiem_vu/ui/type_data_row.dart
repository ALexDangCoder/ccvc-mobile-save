import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
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

enum StatusNV { quahan, chuath, dangth }

extension StatusChiTietNV on StatusNV {
  Widget getStatus() {
    switch (this) {
      case StatusNV.quahan:
        return StatusChiTietNhiemVu(
            name: S.current.qua_han, background: statusCalenderRed,);
      case StatusNV.chuath:
        return StatusChiTietNhiemVu(
          name: S.current.chua_thuc_hien, background: choVaoSoColor,);
      case StatusNV.dangth :
       return StatusChiTietNhiemVu(
          name: S.current.dang_thuc_hien, background: choVaoSoColor,);
    }
  }
}

extension GetStatusNV on String {
  StatusNV getStatusNV () {
    switch(this) {
      case 'QUA_HAN' :
        return StatusNV.quahan;

      case 'CHUA_THUC_HIEN':
        return StatusNV.chuath;

      case 'DANG_THUC_HIEN' :
        return StatusNV.dangth;

      default :
        return StatusNV.quahan;
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
