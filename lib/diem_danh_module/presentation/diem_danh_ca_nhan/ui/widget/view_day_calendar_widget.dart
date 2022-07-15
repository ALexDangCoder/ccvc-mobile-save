import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewDayCalendarWidget extends StatelessWidget {
  final TypeStateDiemDanh state;
  final String timeIn;
  final String timeOut;
  final double dayWage;

  const ViewDayCalendarWidget({
    Key? key,
    required this.state,
    required this.dayWage,
    required this.timeIn,
    required this.timeOut,
  }) : super(key: key);

  String get getStringDate {
    if (timeIn.isEmpty && timeOut.isNotEmpty) {
      return '??:$timeOut';
    }

    if (timeOut.isEmpty && timeIn.isNotEmpty) {
      return '$timeIn:??';
    }

    if (timeIn.isEmpty && timeOut.isEmpty) {
      return '??:??';
    }

    if (timeIn.isNotEmpty && timeOut.isNotEmpty) {
      return '$timeIn:$timeOut';
    }

    return '??:??';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dayWage == 0.0)
          SvgPicture.asset(state.getIcon)
        else
          dayWageWidget(),
        spaceH10,
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color:
                timeIn.isEmpty || timeOut.isEmpty ? colorEA5455 : color20C997,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            getStringDate,
            style: textNormalCustom(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 9,
            ),
          ),
        )
      ],
    );
  }

  Widget dayWageWidget() {
    return Row(
      children: [
        Text(
          dayWage.toString(),
          style: textNormalCustom(
            color: color667793,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        spaceW5,
        SvgPicture.asset(ImageAssets.icDiLam),
      ],
    );
  }
}
