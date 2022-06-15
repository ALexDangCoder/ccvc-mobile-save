import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

enum TypeDataNV { file, status, text }

extension TypeData on TypeDataNV {
  Widget getWidget({
    required RowDataExpandModel row,
    ChiTietNVCubit? cubit,
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
          final data = row.value as List<FileDinhKems>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .map(
                  (e) => GestureDetector(
                    onTap: () async {
                      final status = await Permission.storage.status;
                      if (!status.isGranted) {
                        await Permission.storage.request();
                        await Permission.manageExternalStorage.request();
                      }
                      await saveFile(
                        fileName: e.ten ?? '',
                        url: e.duongDan ?? ''
                      ).then(
                        (value) {
                          if (value == true) {
                            MessageConfig.show(
                              title: S.current.tai_file_thanh_cong,
                            );
                          } else {
                            MessageConfig.show(
                              title: S.current.tai_file_that_bai,
                              messState: MessState.error,
                            );
                          }
                        },
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

      case TypeDataNV.status:
        {
          final data = row.value as String;

          return data.getStatusNV().getStatus();
        }
    }
  }
}

enum StatusNV {
  QUA_HAN,
  CHUA_THUC_HIEN,
  DANG_THUC_HIEN,
  THU_HOI,
  DA_HOAN_THANH,
  CHO_PHAN_XU_LY,
  TRA_LAI,
  NONE,
}

extension StatusChiTietNV on StatusNV {
  Widget getStatus() {
    switch (this) {
      case StatusNV.QUA_HAN:
        return statusChiTietNhiemVu(
          name: S.current.qua_han,
          background: statusCalenderRed,
        );
      case StatusNV.CHUA_THUC_HIEN:
        return statusChiTietNhiemVu(
          name: S.current.chua_thuc_hien,
          background: yellowColor,
        );
      case StatusNV.DANG_THUC_HIEN:
        return statusChiTietNhiemVu(
          name: S.current.dang_thuc_hien,
          background: blueNhatChart,
        );
      case StatusNV.THU_HOI:
        return statusChiTietNhiemVu(
          name: S.current.thu_hoi,
          background: yellowColor,
        );
      case StatusNV.DA_HOAN_THANH:
        return statusChiTietNhiemVu(
          name: S.current.da_hoan_thanh,
          background: daXuLyColor,
        );
      case StatusNV.CHO_PHAN_XU_LY:
        return statusChiTietNhiemVu(
          name: S.current.cho_phan_xu_ly,
          background: color5A8DEE,
        );
      case StatusNV.TRA_LAI:
        return statusChiTietNhiemVu(
          name: S.current.tra_lai,
          background: statusCalenderRed,
        );
      case StatusNV.NONE:
        return const SizedBox();
    }
  }
}

extension GetStatusNV on String {
  StatusNV getStatusNV() {
    switch (this) {
      case 'QUA_HAN':
        return StatusNV.QUA_HAN;
      case 'CHUA_THUC_HIEN':
      case 'Chưa thực hiện':
        return StatusNV.CHUA_THUC_HIEN;
      case 'DANG_THUC_HIEN':
      case 'Đang thực hiện':
        return StatusNV.DANG_THUC_HIEN;
      case 'THU_HOI':
        return StatusNV.THU_HOI;
      case 'Đã hoàn thành':
      case 'DA_HOAN_THANH':
        return StatusNV.DA_HOAN_THANH;
      case 'CHO_PHAN_XU_LY':
        return StatusNV.CHO_PHAN_XU_LY;
      case 'TRA_LAI':
        return StatusNV.TRA_LAI;

      default:
        return StatusNV.QUA_HAN;
    }
  }
}

Widget statusChiTietNhiemVu({required String name, required Color background}) {
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
