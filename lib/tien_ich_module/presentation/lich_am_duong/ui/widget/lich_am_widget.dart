import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class LichAmWidget extends StatelessWidget {
  final NgayAmLich ngayAmLich;
  final String thu;
  final String ngayAmLichStr;

  const LichAmWidget({
    Key? key,
    required this.ngayAmLich,
    required this.thu,
    required this.ngayAmLichStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleLichAm(thu, fontSize: 18.0, fontWeight: FontWeight.w500),
              spaceW6,
              titleLichAm(
                DateTime.parse(
                  ngayAmLich.solarDate ?? DateTime.now().toString(),
                ).formatApiDDMMYYYY,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleLichAm(
                '${S.current.am_lich}: ${ngayAmLich.day ?? ''}-'
                ' ${ngayAmLich.month ?? ''}- ${ngayAmLich.year ?? ''}',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AqiColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleLichAm(
                '${S.current.ngay} ${ngayAmLich.dayName ?? ''}',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AqiColor,
              ),
              titleLichAm(
                ' - ${S.current.thang} ${ngayAmLich.monthLongName ?? ''}',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AqiColor,
              ),
              titleLichAm(
                ' - ${S.current.nam} ${ngayAmLich.yearName ?? ''}',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AqiColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget titleLichAm(String title,
    {double? fontSize, FontWeight? fontWeight, Color? color}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: textNormalCustom(
        fontSize: fontSize ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? color3D5586,
      ),
    ),
  );
}
