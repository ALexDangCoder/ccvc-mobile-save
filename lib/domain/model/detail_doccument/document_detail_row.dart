import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import 'lich_su_van_ban_model.dart';

const QUA_HAN = 'QUA_HAN';
const CHUA_THUC_HIEN = 'CHUA_THUC_HIEN';
const DANG_THUC_HIEN = 'DANG_THUC_HIEN';
const CHO_VAO_SO = 'CHO_VAO_SO';
const NHAN_DE_BIET = 'NHAN_DE_BIET';
const CHO_XU_LY = 'CHO_XU_LY';
const DANG_XU_LY = 'DANG_XU_LY';
const CHO_TIEP_NHAN = 'CHO_TIEP_NHAN';
const CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';

enum TypeDocumentDetailRow { checkbox, text, fileActacks, status }

class DocumentDetailRow {
  String title = '';
  dynamic value;
  TypeDocumentDetailRow type = TypeDocumentDetailRow.text;

  DocumentDetailRow(this.title, this.value, this.type);

  DocumentDetailRow.DocumentDefault(
    this.title,
    this.value,
  );
}

extension TypeDataDocument on TypeDocumentDetailRow {
  Widget getWidgetVanBan({
    required DocumentDetailRow row,
    required DetailDocumentCubit cubit,
  }) {
    switch (this) {
      case TypeDocumentDetailRow.text:
        return Text(
          row.value,
          style: textNormalCustom(
            color: textTitle,
            fontWeight: FontWeight.w400,
            fontSize: 14.0.textScale(),
          ),
        );
      case TypeDocumentDetailRow.fileActacks:
        {
          final data = row.value as List<FileDinhKems>;
          return Column(
            children: data.map((e) => Text(
            e.ten??'',
            style: textNormalCustom(
            color: choXuLyColor,
            fontWeight: FontWeight.w400,
            fontSize: 14.0.textScale(),
            ),
          ),).toList(),
          );
        }
      case TypeDocumentDetailRow.status:
        {
          final data = row.value as String;

          return data.getStatusVanBan().getStatus();
        }
      case TypeDocumentDetailRow.checkbox:
        return Row(
          children: [
            SizedBox(
              height: 20,
              width: 41,
              child: CustomCheckBox(
                title: '',
                isCheck: row.value,
                onChange: (bool check) {},
              ),
            ),
            AutoSizeText(
              row.title,
              style: textNormalCustom(
                color: titleItemEdit,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
    }
  }
}

enum StatusVanBan {
  QUA_HAN,
  CHUA_THUC_HIEN,
  DANG_THUC_HIEN,
  CHO_VAO_SO,
  NHAN_DE_BIET,
  CHO_XU_LY,
  DANG_XU_LY,
  CHO_TIEP_NHAN,
  CHO_PHAN_XU_LY
}

extension StatusChiTietVanBan on StatusVanBan {
  Widget getStatus() {
    switch (this) {
      case StatusVanBan.QUA_HAN:
        return statusChiTietVanBan(
          name: S.current.qua_han,
          background: statusCalenderRed,
        );
      case StatusVanBan.CHUA_THUC_HIEN:
        return statusChiTietVanBan(
          name: S.current.chua_thuc_hien,
          background: yellowColor,
        );
      case StatusVanBan.DANG_THUC_HIEN:
        return statusChiTietVanBan(
          name: S.current.dang_thuc_hien,
          background: AqiColor,
        );
      case StatusVanBan.CHO_VAO_SO:
        return statusChiTietVanBan(
          name: S.current.cho_vao_so,
          background: choVaoSoColor,
        );
      case StatusVanBan.NHAN_DE_BIET:
        return statusChiTietVanBan(
          name: S.current.nhan_de_biet,
          background: choVaoSoColor,
        );
      case StatusVanBan.CHO_XU_LY:
        return statusChiTietVanBan(
          name: S.current.cho_xu_ly,
          background: choXuLyColor,
        );
      case StatusVanBan.DANG_XU_LY:
        return statusChiTietVanBan(
          name: S.current.dang_xu_ly,
          background: dangXyLyColor,
        );
      case StatusVanBan.CHO_TIEP_NHAN:
        return statusChiTietVanBan(
          name: S.current.cho_tiep_nhan,
          background: itemWidgetNotUse,
        );
      case StatusVanBan.CHO_PHAN_XU_LY:
        return statusChiTietVanBan(
          name: S.current.cho_phan_xu_ly,
          background: yellowColor,
        );
    }
  }
}

extension GetStatusVanBan on String {
  StatusVanBan getStatusVanBan() {
    switch (this) {
      case QUA_HAN:
        return StatusVanBan.QUA_HAN;

      case CHUA_THUC_HIEN:
        return StatusVanBan.CHUA_THUC_HIEN;

      case DANG_THUC_HIEN:
        return StatusVanBan.DANG_THUC_HIEN;
      case CHO_VAO_SO:
        return StatusVanBan.CHO_VAO_SO;
      case NHAN_DE_BIET:
        return StatusVanBan.NHAN_DE_BIET;
      case CHO_XU_LY:
        return StatusVanBan.CHO_XU_LY;
      case DANG_XU_LY:
        return StatusVanBan.DANG_XU_LY;
      case CHO_TIEP_NHAN:
        return StatusVanBan.CHO_TIEP_NHAN;
      case CHO_PHAN_XU_LY:
        return StatusVanBan.CHO_PHAN_XU_LY;
      default:
        return StatusVanBan.QUA_HAN;
    }
  }
}

Widget statusChiTietVanBan({required String name, required Color background}) {
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
            color: backgroundColorApp,
            fontSize: 12.0.textScale(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
