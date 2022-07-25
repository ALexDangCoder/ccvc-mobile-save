import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
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
      return '??:??-${timeOut.getTime}';
    }

    if (timeOut.isEmpty && timeIn.isNotEmpty) {
      return '${timeIn.getTime}-??:??';
    }

    if (timeIn.isEmpty && timeOut.isEmpty) {
      return '??:??-??:??';
    }

    if (timeIn.isNotEmpty && timeOut.isNotEmpty) {
      return '${timeIn.getTime}-${timeOut.getTime}';
    }

    return '??:??-??:??';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (dayWage == 0.0)
          SvgPicture.asset(
            state.getIcon,
            height: 12,
            width: 12,
          )
        else
          dayWageWidget(),
        spaceH10,
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 5,
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
        ),
        spaceH6,
      ],
    );
  }

  Widget dayWageWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dayWage.toString(),
          style: textNormalCustom(
            color: color667793,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        spaceW2,
        SvgPicture.asset(
          ImageAssets.icDiLam,
          width: 10,
          height: 10,
        ),
        if (state != TypeStateDiemDanh.DI_LAM)
          Row(
            children: [
              spaceW6,

              SvgPicture.asset(
                state.getIcon,
                height: 12,
                width: 12,
              ),
            ],
          )
        else
          Container(),
      ],
    );
  }
}
