import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_header.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../type_data_row.dart';

class HeaderChiTiet extends StatelessWidget {
  final List<ChiTietHeaderRow> row;

  const HeaderChiTiet({Key? key, required this.row}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: APP_DEVICE == DeviceType.TABLET
          ? const EdgeInsets.only(left: 20,right: 20,top: 20,)
          : const EdgeInsets.only(left: 16,right: 16,top: 16,),
      decoration: APP_DEVICE == DeviceType.TABLET
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: toDayColor.withOpacity(0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorBlack.withOpacity(0.05),
                  blurRadius: 10, // changes position of shadow
                ),
              ],
            )
          : const BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: row
              .map(
                (e) => Container(
                  margin: EdgeInsets.only(
                    bottom: 10.0.textScale(),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: e.key,
                                style: textNormalCustom(
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0.textScale(),
                                ),
                              ),
                              if (e.isNote)
                                TextSpan(
                                  text: ' *',
                                  style: textNormalCustom(
                                    color: Colors.red,
                                    fontSize: 14.0.textScale(),
                                  ),
                                )
                              else
                                const TextSpan(text: ''),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0.textScale(),
                      ),
                      Expanded(
                        flex: 5,
                        child: (e.key != S.current.tinh_hinh_thuc_hien)
                            ? Text(
                                e.value,
                                style: textNormalCustom(
                                  color: textTitle,
                                  fontSize: 16.0.textScale(),
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : getStatus(getStatusNV(e.value)),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget getStatus(StatusNV status) {
  switch (status) {
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
        background: color02C5DD,
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

StatusNV getStatusNV(String status) {
  switch (status) {
    case 'QUA_HAN':
      return StatusNV.QUA_HAN;
    case 'CHUA_THUC_HIEN':
      return StatusNV.CHUA_THUC_HIEN;
    case 'DANG_THUC_HIEN':
      return StatusNV.DANG_THUC_HIEN;
    case 'THU_HOI':
      return StatusNV.THU_HOI;
    case 'DA_HOAN_THANH':
      return StatusNV.DA_HOAN_THANH;
    case 'CHO_PHAN_XU_LY':
      return StatusNV.CHO_PHAN_XU_LY;
    case 'TRA_LAI':
      return StatusNV.TRA_LAI;
    default:
      return StatusNV.NONE;
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
