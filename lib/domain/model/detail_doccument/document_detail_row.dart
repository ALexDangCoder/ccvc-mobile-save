import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lich_su_van_ban_model.dart';

const QUA_HAN = 'QUA_HAN';
const CHO_TRINH_KY = 'CHO_TRINH_KY';
const CHUA_THUC_HIEN = 'CHUA_THUC_HIEN';
const DANG_THUC_HIEN = 'DANG_THUC_HIEN';
const CHO_VAO_SO = 'CHO_VAO_SO';
const NHAN_DE_BIET = 'NHAN_DE_BIET';
const CHO_XU_LY = 'CHO_XU_LY';
const DANG_XU_LY = 'DANG_XU_LY';
const CHO_TIEP_NHAN = 'CHO_TIEP_NHAN';
const CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';
const THU_HOI = 'THU_HOI';
const DA_HOAN_THANH = 'DA_HOAN_THANH';
const TRA_LAI = 'TRA_LAI';

enum TypeDocumentDetailRow {
  checkbox,
  text,
  fileActacks,
  priority,
  textStatus,
  status,
  fileVanBanDi
}

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
        case TypeDocumentDetailRow.textStatus:
        return Text(
          row.value,
          style: textNormalCustom(
            color: row.value.toString().textToCode.getStatusVanBan().getStatusColor(),
            fontWeight: FontWeight.w400,
            fontSize: 14.0.textScale(),
          ),
        );
      case TypeDocumentDetailRow.fileActacks:
        {
          final data = row.value as List<FileDinhKems>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .map(
                  (e) => GestureDetector(
                    onTap: () async {
                      final baseURL = Get.find<AppConstants>().baseUrlQLNV;
                      await saveFile(
                        fileName: e.ten ?? '',
                        url: e.duongDan ?? '',
                        downloadType: DomainDownloadType.QLNV
                      );

                    },
                    child: Text(
                      e.ten ?? '',
                      style: textNormalCustom(
                        color: color5A8DEE,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0.textScale(),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }
      case TypeDocumentDetailRow.status:
        {
          final data = row.value as String;

          return data.getStatusVanBan().getStatus();
        }
      case TypeDocumentDetailRow.priority:
        {
          return Text(
            row.value,
            style: textNormalCustom(
              color: getColorFromPriorityCodeUpperCase(row.value.toString().textToCode),
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          );
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
      case TypeDocumentDetailRow.fileVanBanDi:
        {
          if (row.value is List<Files>) {
            final data = row.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[...data
                  .map(
                    (e) => GestureDetector(
                      onTap: () async {
                        final baseURL = Get.find<AppConstants>().baseUrlQLNV;
                        await saveFile(
                          url: e.duongDan,
                          fileName: e.ten ?? '',
                          downloadType: DomainDownloadType.QLNV
                        );
                      },
                      child: Text(
                        e.ten ?? '',
                        style: textNormalCustom(
                          color: color5A8DEE,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.textScale(),
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }
    }
  }
}

enum StatusVanBan {
  QUA_HAN,
  CHO_TRINH_KY,
  CHUA_THUC_HIEN,
  DANG_THUC_HIEN,
  CHO_VAO_SO,
  NHAN_DE_BIET,
  CHO_XU_LY,
  DANG_XU_LY,
  CHO_TIEP_NHAN,
  CHO_PHAN_XU_LY,
  THU_HOI,
  DA_HOAN_THANH,
  TRA_LAI
}

extension StatusChiTietVanBan on StatusVanBan {
  Widget getStatus({bool changeTextColor = false}) {
    switch (this) {
      case StatusVanBan.QUA_HAN:
        return statusChiTietVanBan(
          name: S.current.qua_han,
          background: statusCalenderRed,
          changeTextColor: changeTextColor,
        );
        case StatusVanBan.CHO_TRINH_KY:
        return statusChiTietVanBan(
          name: S.current.cho_trinh_ky,
          background: choTrinhKyColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.CHUA_THUC_HIEN:
        return statusChiTietVanBan(
          name: S.current.chua_thuc_hien,
          background: yellowColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.DANG_THUC_HIEN:
        return statusChiTietVanBan(
          name: S.current.dang_thuc_hien,
          background: AqiColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.CHO_VAO_SO:
        return statusChiTietVanBan(
          name: S.current.cho_vao_so,
          background: choVaoSoColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.NHAN_DE_BIET:
        return statusChiTietVanBan(
          name: S.current.nhan_de_biet,
          background: choVaoSoColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.CHO_XU_LY:
        return statusChiTietVanBan(
          name: S.current.cho_xu_ly,
          background: color5A8DEE,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.DANG_XU_LY:
        return statusChiTietVanBan(
          name: S.current.dang_xu_ly,
          background: dangXyLyColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.CHO_TIEP_NHAN:
        return statusChiTietVanBan(
          name: S.current.cho_tiep_nhan,
          background: itemWidgetNotUse,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.CHO_PHAN_XU_LY:
        return statusChiTietVanBan(
          name: S.current.cho_phan_xu_ly,
          background: yellowColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.THU_HOI:
        return statusChiTietVanBan(
          name: S.current.thu_hoi,
          background: yellowColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.DA_HOAN_THANH:
        return statusChiTietVanBan(
          name: S.current.da_hoan_thanh,
          background: daXuLyColor,
          changeTextColor: changeTextColor,
        );
      case StatusVanBan.TRA_LAI:
        return statusChiTietVanBan(
          name: S.current.tra_lai,
          background: statusCalenderRed,
          changeTextColor: changeTextColor,
        );
    }
  }
  Color getStatusColor({bool changeTextColor = false}) {
    switch (this) {
      case StatusVanBan.QUA_HAN:
        return statusCalenderRed;
      case StatusVanBan.CHO_TRINH_KY:
        return choTrinhKyColor;
      case StatusVanBan.CHUA_THUC_HIEN:
        return yellowColor;
      case StatusVanBan.DANG_THUC_HIEN:
        return AqiColor;
      case StatusVanBan.CHO_VAO_SO:
        return choVaoSoColor;
      case StatusVanBan.NHAN_DE_BIET:
        return choVaoSoColor;
      case StatusVanBan.CHO_XU_LY:
        return color5A8DEE;
      case StatusVanBan.DANG_XU_LY:
        return dangXyLyColor;
      case StatusVanBan.CHO_TIEP_NHAN:
        return itemWidgetNotUse;
      case StatusVanBan.CHO_PHAN_XU_LY:
        return yellowColor;
      case StatusVanBan.THU_HOI:
        return yellowColor;
      case StatusVanBan.DA_HOAN_THANH:
        return daXuLyColor;
      case StatusVanBan.TRA_LAI:
        return statusCalenderRed;
    }
  }
}

extension GetStatusVanBan on String {
  StatusVanBan getStatusVanBan() {
    switch (this) {
      case QUA_HAN:
        return StatusVanBan.QUA_HAN;
      case CHO_TRINH_KY :
        return StatusVanBan.CHO_TRINH_KY;
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
      case THU_HOI:
        return StatusVanBan.THU_HOI;
      case DA_HOAN_THANH:
        return StatusVanBan.DA_HOAN_THANH;
      case TRA_LAI:
        return StatusVanBan.TRA_LAI;
      default:
        return StatusVanBan.QUA_HAN;
    }
  }
}

Widget statusChiTietVanBan({
  required String name,
  required Color background,
  bool changeTextColor = false,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (changeTextColor)
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
        )
      else
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0.textScale(),
            vertical: 4.0.textScale(),
          ),
          child: Text(
            name,
            style: textNormalCustom(
              color: background,
              fontSize: 12.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
    ],
  );
}
