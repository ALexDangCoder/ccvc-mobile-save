import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemRowChiTiet extends StatefulWidget {
  final ChiTietLichLamViecModel data;
  final ChiTietLichLamViecCubit cubit;

  const ItemRowChiTiet({Key? key, required this.data, required this.cubit})
      : super(key: key);

  @override
  _ItemRowChiTietState createState() => _ItemRowChiTietState();
}

class _ItemRowChiTietState extends State<ItemRowChiTiet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        rowData(
          icon: ImageAssets.icNhacLai,
          value: getDateTime(
            widget.data.dateTimeFrom ?? '',
            widget.data.dateTimeTo ?? '',
          ),
        ),
        rowData(
          icon: ImageAssets.icCalendarUnFocus,
          value: getDate(
            widget.data.dateFrom ?? '',
            widget.data.dateTo ?? '',
          ),
        ),
        rowData(
          icon: ImageAssets.icCalendarUnFocus,
          value: widget.data.typeScheduleName,
        ),
        rowData(
          icon: ImageAssets.icNotify,
          value: widget.data.scheduleReminder?.nhacLai(),
        ),
        if (widget.data.publishSchedule ?? false) ...[
          spaceH10,
          Padding(
            padding: EdgeInsets.only(
              left: 31.0.textScale(),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.current.cong_khai_lich,
                style: textNormal(
                  color_667793,
                  14,
                ),
              ),
            ),
          ),
          spaceH8,
        ],
        rowData(
          icon: ImageAssets.icPerson,
          value: widget.data.canBoChuTri?.namePosition() ?? '',
        ),
        rowData(icon: ImageAssets.icWork, value: widget.data.linhVuc ?? ''),
        rowData(icon: ImageAssets.icViTri, value: widget.data.location ?? ''),
        rowData(icon: ImageAssets.icDocument, value: widget.data.content ?? ''),
      ],
    );
  }

  Widget rowData({required String icon, dynamic value}) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          SizedBox(
            height: 15.0.textScale(),
            width: 15.0.textScale(),
            child: SvgPicture.asset(icon),
          ),
          SizedBox(
            width: 16.0.textScale(),
          ),
          Expanded(
            child: Text(
              value,
              style: textNormalCustom(
                color: textTitle,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String getDateTime(String timeFrom, String timeTo) {
    String time = '' ;
    try {
      time = '${DateTime.parse(timeFrom).toFormat12h} - '
          '${DateTime.parse(timeTo).toFormat12h}';
    } on FormatException catch (_) {
      return '';
    }
    return time;
  }

  String getDate(String dateFrom, String dateTo) {
    String time = '';
    try {
      if(DateTime.parse(dateFrom).difference(DateTime.parse(dateTo)).inDays != 0){
        time = '${widget.cubit.parseDate(dateFrom)} - '
            '${widget.cubit.parseDate(dateTo)}';
      }
      else {
        time = widget.cubit.parseDate(dateFrom);
      }
    } on FormatException catch (_) {
      return '';
    }
    return time;
  }
}
