import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
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
          value:
              '${DateTime.parse(widget.data.dateTimeFrom ?? '').toStringWithAMPM}-'
              '${DateTime.parse(widget.data.dateTimeTo ?? '').toStringWithAMPM}',
        ),
        rowData(
          icon: ImageAssets.icCalendarUnFocus,
          value: widget.cubit
              .parseDate(widget.data.dateTo ?? DateTime.now().formatApi),
        ),
        rowData(
          icon: ImageAssets.icCalendarUnFocus,
          value: widget.data.typeScheduleName,
        ),
        rowData(icon: ImageAssets.icNotify, value: ''),
        rowData(
          icon: ImageAssets.icPerson,
          value: widget.data.canBoChuTri?.hoTen ?? '',
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
          Text(
            value,
            style: textNormalCustom(
              color: textTitle,
              fontWeight: FontWeight.w400,
              fontSize: 16.0.textScale(),
            ),
          ),
        ],
      ),
    );
  }
}
