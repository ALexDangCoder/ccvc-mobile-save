import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopupChoiceTimeWidget extends StatefulWidget {
  final Function(String startDate, String endDate) onChoiceTime;
  const PopupChoiceTimeWidget({Key? key,required this.onChoiceTime}) : super(key: key);

  @override
  _PopupChoiceDateState createState() => _PopupChoiceDateState();
}

class _PopupChoiceDateState extends State<PopupChoiceTimeWidget> {
  late String startDate;
  late String endDate;

  @override
  void initState() {
    super.initState();
    initDateTime();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                S.current.tu_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Text(
                S.current.den_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: SelectDate(
                key: UniqueKey(),
                paddings: 10,
                leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                value:startDate,
                onSelectDate: (dateTime) {
                  startDate=dateTime;
                },
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: SelectDate(
                key: UniqueKey(),
                paddings: 10,
                leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                value: endDate,
                onSelectDate: (dateTime) {
                  endDate=dateTime;
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ButtonCustomBottom(
                title: S.current.bo_qua,
                isColorBlue: false,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonCustomBottom(
                title: S.current.hien_thi,
                isColorBlue: true,
                onPressed: () {
                  widget.onChoiceTime(startDate, endDate);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
  void initDateTime() {
    const int millisecondOfWeek = 7 * 24 * 60 * 60 * 1000;
    final int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    final int prevWeek = millisecondNow - millisecondOfWeek;
    endDate = DateTime.now().toString();
    startDate = DateTime.fromMillisecondsSinceEpoch(prevWeek).toString();
  }
}
