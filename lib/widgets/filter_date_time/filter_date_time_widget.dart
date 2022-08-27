import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/fix_bug_cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterDateTimeWidget extends StatefulWidget {
  final bool isMobile;
  final String? currentStartDate;
  final String? currentEndDate;
  final Function(DateTime startDate, DateTime endDate) onChooseDateFilter;
  final BuildContext context;
  final DateTime? initStartDate;
  final DateTime? initEndDate;

  const FilterDateTimeWidget({
    Key? key,
    required this.onChooseDateFilter,
    required this.context,
    this.currentStartDate,
    this.currentEndDate,
    this.isMobile = true,
    this.initStartDate,
    this.initEndDate,
  }) : super(key: key);

  @override
  _FilterDateTimeWidgetState createState() => _FilterDateTimeWidgetState();
}

class _FilterDateTimeWidgetState extends State<FilterDateTimeWidget>
    with SingleTickerProviderStateMixin {
  late DateTime currentStartDate;
  late DateTime currentEndDate;
  DateTime chooseTime = DateTime.now();

  @override
  void initState() {
    currentStartDate = widget.initStartDate ?? DateTime.now();
    currentEndDate = widget.initEndDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  backgroundColorApp,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.isMobile
              ? [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            S.current.tu_ngay,
                            style: textNormal(titleItemEdit, 14.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showBottomSheetCustom(
                              context,
                              title: S.current.chon_ngay,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child:
                                    FixBugCupertinoDatePicker(
                                      maximumDate: DateTime.now(),
                                      onDateTimeChanged: (value) {
                                        setState(() {
                                          chooseTime = value;
                                        });
                                      },
                                      textStyleDate: titleAppbar(),
                                      initialDateTime: currentStartDate,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 24,
                                      bottom: 32,
                                    ),
                                    child: DoubleButtonBottom(
                                      title2: S.current.chon,
                                      title1: S.current.dong,
                                      onClickRight: () {
                                        setState(() {});
                                        if (validateDay(chooseTime)) {
                                          MessageConfig.show(
                                            title: S.current
                                                .thoi_gian_chon_khong_hop_le,
                                            messState: MessState.error,
                                          );
                                          return;
                                        }
                                        currentStartDate = chooseTime;
                                        widget.onChooseDateFilter(
                                            currentStartDate, DateTime.now());
                                        Navigator.pop(context);
                                      },
                                      onClickLeft: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: cellColorborder),
                              borderRadius: BorderRadius.circular(4.0),
                              color: backgroundColorApp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    currentStartDate.toStringWithListFormat,
                                    style: textNormalCustom(
                                      color: textBodyTime,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SvgPicture.asset(
                                    ImageAssets.icCalendarUnFocus,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.current.den_ngay,
                            style: textNormal(titleItemEdit, 14.0),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: cellColorborder),
                            borderRadius: BorderRadius.circular(4.0),
                            color: blueFilterDateWidget,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  currentEndDate.toStringWithListFormat,
                                  style: textNormalCustom(
                                    color: color3D5586,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: SvgPicture.asset(
                                      ImageAssets.icCalendarUnFocus)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]
              : [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          S.current.tu_ngay,
                          style: textNormal(titleItemEdit, 14.0),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDiaLogTablet(
                            context,
                            title: S.current.chon_ngay,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child:
                                    FixBugCupertinoDatePicker(
                                      maximumDate: DateTime.now(),
                                      onDateTimeChanged: (value) {
                                        setState(() {
                                          chooseTime = value;
                                        });
                                      },
                                      textStyleDate: titleAppbar(),
                                      initialDateTime: currentStartDate,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isBottomShow: true,
                            btnLeftTxt: S.current.dong,
                            btnRightTxt: S.current.chon,
                            funcBtnOk: () {
                              setState(() {});
                              if (validateDay(chooseTime)) {
                                MessageConfig.show(
                                  title: S.current.thoi_gian_chon_khong_hop_le,
                                  messState: MessState.error,
                                );
                                return;
                              }
                              currentStartDate = chooseTime;
                              widget.onChooseDateFilter(
                                  currentStartDate, DateTime.now());
                              Navigator.pop(context);
                            },
                            setHeight: 400,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: cellColorborder),
                            borderRadius: BorderRadius.circular(4.0),
                            color: backgroundColorApp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentStartDate.toStringWithListFormat,
                                style: textNormal(textBodyTime, 14.0),
                              ),
                              spaceW20,
                              ImageAssets.svgAssets(
                                ImageAssets.icCalendarUnFocus,
                                width: 24,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  spaceW25,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          S.current.den_ngay,
                          style: textNormal(titleItemEdit, 14.0),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: cellColorborder),
                          borderRadius: BorderRadius.circular(4.0),
                          color: blueFilterDateWidget,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentEndDate.toStringWithListFormat,
                              style: textNormal(color3D5586, 14.0),
                            ),
                            spaceW20,
                            ImageAssets.svgAssets(
                              ImageAssets.icCalendarUnFocus,
                              width: 24,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
        ),
      ),
    );
  }

  bool validateDay(DateTime value) {
    final dayMax = DateTime.now();

    if (value.millisecondsSinceEpoch > dayMax.millisecondsSinceEpoch) {
      return true;
    }

    return false;
  }
}
