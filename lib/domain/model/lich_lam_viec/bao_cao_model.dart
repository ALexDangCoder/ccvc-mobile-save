import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

enum BaoCaoStatus { TRUNG_BINH, DAT, KHONG_DAT }

const _TRUNG_BINH = 'trung-binh';
const _DAT = 'dat';
const _KHONG_DAT = 'khong-dat';

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
  List<FileModel> listFile = [];
  String reportStatusCode;
  String id;
  String reportStatusId;
  String canBoChuTriId;

  BaoCaoModel({
    this.status = BaoCaoStatus.TRUNG_BINH,
    required this.content,
    required this.listFile,
    this.reportStatusCode = '',
    this.id = '',
    this.reportStatusId = '',
    this.canBoChuTriId = '',
  }) {
    status = fromEnum();
  }

  BaoCaoStatus fromEnum() {
    {
      switch (reportStatusCode) {
        case _TRUNG_BINH:
          return BaoCaoStatus.TRUNG_BINH;
        case _DAT:
          return BaoCaoStatus.DAT;
        case _KHONG_DAT:
          return BaoCaoStatus.KHONG_DAT;
      }
      return BaoCaoStatus.TRUNG_BINH;
    }
  }
}

class FileModel {
  String? id;
  String? name;
  String? path;
  double? fileLength;

  FileModel({
    this.id,
    this.name,
    this.path,
    this.fileLength,
  });
}
