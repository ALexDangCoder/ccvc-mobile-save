import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class LichAmWidget extends StatelessWidget {
  final NgayAmLich ngayAmLich;
  final String thu;
  final String ngayAmLichStr;

  LichAmWidget({
    Key? key,
    required this.ngayAmLich,
    required this.thu,
    required this.ngayAmLichStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleLichAm(
                thu,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: colorA2AEBD,
              ),
              titleLichAm(
                  DateTime.parse(
                    ngayAmLich.solarDate ?? DateTime.now().toString(),
                  ).formatDayCalendar,
                  fontSize: 16.0,),
              titleLichAm(
                  '${ngayAmLich.day??''}, Tháng ${ngayAmLich.month??''} (AL), ${ngayAmLich.yearName??''}',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: colorA2AEBD),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleLichAm('N. ${ngayAmLich.yearName ?? ''}',
                  fontSize: 12.0, fontWeight: FontWeight.w500, color: colorA2AEBD),
              titleLichAm('T. ${ngayAmLich.monthLongName ?? ''}',
                  fontSize: 12.0, fontWeight: FontWeight.w500, color: colorA2AEBD),
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
