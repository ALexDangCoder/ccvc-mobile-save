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
      case TrangThai.ChoDuyet:
        return status(S.current.cho_duyet, processingColor);

      case TrangThai.ChuaGuiDuyet:
        return status(S.current.nhap, subTitle);

      case TrangThai.HuyDuyet:
        return status(S.current.huy_duyet, canceledColor);

      case TrangThai.DaDuyet:
        return status(S.current.da_duyet, itemWidgetUsing);
    }
  }
}

extension tinhTrang on TinhTrang {
  Widget getWidget() {
    switch (this) {
      case TinhTrang.TrungBinh:
        return status(S.current.trung_binh, itemWidgetNotUse);

      case TinhTrang.Dat:
        return status(S.current.dat, itemWidgetUsing);

      case TinhTrang.ChuaDat:
        return status(S.current.chua_dat, canceledColor);
    }
  }
}
