import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/select_date.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateTimeFilterWidget extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final Function(String time) onChangeStarDate;
  final Function(String time) onChangeEndDate;

  const DateTimeFilterWidget({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.onChangeStarDate,
    required this.onChangeEndDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: SelectDate(
              backgroundColor: backgroundColorApp,
              key: UniqueKey(),
              paddings: 10,
              leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
              value: startDate.toString(),
              onSelectDate: (dateTime) {
                onChangeStarDate(dateTime);
              },
            ),
          ),
          spaceW16,
          Expanded(
            child: SelectDate(
              backgroundColor: backgroundColorApp,
              key: UniqueKey(),
              paddings: 10,
              leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
              value: endDate.toString(),
              onSelectDate: (dateTime) {
                onChangeStarDate(dateTime);
              },
            ),
          )
        ],
      ),
    );
  }
}
