import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  final String? value;
  final Function(String) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;
  final DateTime? initDateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Function(String selectDate)? callBackSelectDate;

  const SelectDate({
    Key? key,
    this.value,
    required this.onSelectDate,
    this.initDateTime,
    this.hintText,
    this.backgroundColor,
    this.leadingIcon,
    this.paddings,
    this.isObligatory = false,
    this.minimumDate,
    this.maximumDate,
    this.callBackSelectDate,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<SelectDate> {
  String dateSelect = '';
  DateTime timeNow = DateTime.now();
  String initDate = '';
  bool isDateOver = false;

  @override
  void initState() {
    if (!widget.isObligatory) {
      dateSelect = widget.value.toString();
      initDate = dateSelect;
    }
    super.initState();
  }

  void validateDay(DateTime value) {
    final dayMin = widget.minimumDate ?? DateTime(timeNow.year - 50);

    if (value.millisecondsSinceEpoch < dayMin.millisecondsSinceEpoch) {
      isDateOver = true;
      return;
    }
    final dayMax = DateTime.now();
    if (value.millisecondsSinceEpoch > dayMax.millisecondsSinceEpoch) {
      isDateOver = true;
      return;
    }
    isDateOver = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (APP_DEVICE == DeviceType.MOBILE) {
          showBottomSheetCustom(
            context,
            title: S.current.chon_ngay,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: FlutterRoundedCupertinoDatePickerWidget(
                    minimumDate:
                        widget.minimumDate ?? DateTime(timeNow.year - 50),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (value) {
                      validateDay(value);
                      if (!isDateOver) {
                        dateSelect = value.toString();
                      }
                    },
                    textStyleDate: titleAppbar(),
                    initialDateTime:
                        widget.initDateTime ?? DateTime.parse(initDate),
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
                      if (isDateOver) {
                        MessageConfig.show(
                            title: S.current.thoi_gian_chon_khong_hop_le,
                            messState: MessState.error);
                        return;
                      }
                      if (widget.callBackSelectDate != null) {
                        widget.callBackSelectDate!.call(dateSelect);
                      }
                      setState(() {
                        initDate = dateSelect;
                        widget.onSelectDate(dateSelect);
                      });
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
        } else {
          showDiaLogTablet(
            context,
            isBottomShow: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: FlutterRoundedCupertinoDatePickerWidget(
                    minimumDate:
                        widget.minimumDate ?? DateTime(timeNow.year - 50),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (value) {
                      validateDay(value);
                      if (!isDateOver) {
                        dateSelect = value.toString();
                      }
                    },
                    textStyleDate: titleAppbar(),
                    initialDateTime:
                        widget.initDateTime ?? DateTime.parse(initDate),
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
                      if (isDateOver) {
                        MessageConfig.show(
                            title: S.current.thoi_gian_chon_khong_hop_le,
                            messState: MessState.error);
                        return;
                      }
                      if (widget.callBackSelectDate != null) {
                        widget.callBackSelectDate!.call(dateSelect);
                      }
                      setState(() {
                        initDate = dateSelect;
                        widget.onSelectDate(dateSelect);
                      });
                      Navigator.pop(context);
                    },
                    onClickLeft: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            funcBtnOk: () {},
            title: S.current.chon_ngay,
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.isObligatory
                    ? borderColor.withOpacity(0.3)
                    : widget.backgroundColor ?? Colors.transparent,
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 14,
                          left: 10,
                        ),
                        child: widget.value == null
                            ? Text(
                                widget.hintText ?? S.current.vuiLongChon,
                                style: tokenDetailAmount(
                                  fontSize: 14.0.textScale(),
                                  color: color3D5586,
                                ),
                              )
                            : Text(
                                widget.isObligatory
                                    ? '${widget.value}'
                                    : DateTime.parse(dateSelect)
                                        .toStringWithListFormat,
                                style: tokenDetailAmount(
                                  fontSize: 14.0.textScale(),
                                  color: color3D5586,
                                ),
                              ),
                      )
                    ],
                  ),
                  Positioned(
                    right: widget.paddings ?? 3,
                    height: 44,
                    child: Center(
                      child: widget.leadingIcon ?? const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
