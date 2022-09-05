import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

Widget status(String text, Color background) {
  return Row(
    children: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 15.0.textScale(),
          vertical: 3.0.textScale(),
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: textNormalCustom(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12.0.textScale(),
          ),
        ),
      ),
    ],
  );
}

extension trangThai on TrangThai {
  Widget getWidget() {
    switch (this) {
      case TrangThai.CHO_DUYET:
        return status(S.current.cho_duyet, processingColor);

      case TrangThai.NHAP:
        return status(S.current.nhap, subTitle);

      case TrangThai.TU_CHOI:
        return status(S.current.tu_choi, canceledColor);

      case TrangThai.DA_DUYET:
        return status(S.current.da_duyet, itemWidgetUsing);
    }
  }
}

extension TinhTrangExt on TinhTrang {
  Widget getWidget() {
    switch (this) {
      case TinhTrang.TRUNG_BINH:
        return status(S.current.trung_binh, itemWidgetNotUse);

      case TinhTrang.DAT:
        return status(S.current.dat, itemWidgetUsing);

      case TinhTrang.KHONG_DAT:
        return status(S.current.khong_dat, canceledColor);
    }
  }
}
