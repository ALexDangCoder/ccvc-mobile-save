import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

enum BaoCaoStatus { TRUNG_BINH, DAT, KHONG_DAT }

extension BaoCao on BaoCaoStatus {
  StatusText getText() {
    switch (this) {
      case BaoCaoStatus.TRUNG_BINH:
        return StatusText(text: S.current.trung_binh, color: textColorForum);
      case BaoCaoStatus.DAT:
        return StatusText(text: S.current.dat, color: itemWidgetUsing);
      case BaoCaoStatus.KHONG_DAT:
        return StatusText(text: S.current.khong_dat, color: statusCalenderRed);
    }
  }
}

class StatusText {
  String text = '';
  Color color = Colors.transparent;

  StatusText({required this.text, required this.color});
}

class BaoCaoModel {
  BaoCaoStatus status;
  String content = '';
  List<File> listFile = [];

  BaoCaoModel({
    required this.status,
    required this.content,
    required this.listFile,
  });
}
