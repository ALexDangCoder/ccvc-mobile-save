import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  final Function(DateTime?) onSelectDate;
  final String? hintText;
  final Widget? leadingIcon;
  final double? paddings;
  final DateTime? initDateTime;

  const DateInput({
    Key? key,
    required this.onSelectDate,
    this.initDateTime,
    this.hintText,
    this.leadingIcon,
    this.paddings,
  }) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  String? dateSelect;
  String cachedSelect = DateTime(
    DateTime.now().year - 18,
    DateTime.now().month,
    DateTime.now().day - 1,
  ).toString();
  final initDateTime = DateTime.now();
  bool onchangeSelect = false;

  @override
  void initState() {
    super.initState();
    if (widget.initDateTime != null) {
      dateSelect = widget.initDateTime!.toIso8601String();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMobile()) {
          showBottomSheetCustom(
            context,
            title: S.current.chon_ngay,
            child: calenderPicker(),
          );
        } else {
          showDiaLogTablet(
            context,
            title: S.current.chon_ngay,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: FlutterRoundedCupertinoDatePickerWidget(
                      maximumDate: DateTime(
                        initDateTime.year - 18,
                        initDateTime.month,
                        initDateTime.day - 1,
                      ),
                      onDateTimeChanged: (value) {
                        checkEnableDate(value);
                        cachedSelect = value.toString();
                      },
                      textStyleDate: titleAppbar(),
                      initialDateTime: DateTime.tryParse(dateSelect ?? '') ??
                          DateTime(
                            initDateTime.year - 18,
                            initDateTime.month,
                            initDateTime.day - 1,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            isBottomShow: true,
            btnLeftTxt: S.current.dong,
            btnRightTxt: S.current.chon,
            funcBtnOk: () {
              if (!onchangeSelect) {
                setState(() {
                  dateSelect = cachedSelect;
                });
                widget.onSelectDate(DateTime.tryParse(dateSelect ?? ''));
                Navigator.pop(context);
              }
            },
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
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
                        child: dateSelect == null
                            ? Text(
                                DateFormatApp.dateNormal,
                                style: textNormal(
                                  titleItemEdit.withOpacity(0.5),
                                  14,
                                ),
                              )
                            : Text(
                                DateTime.parse(dateSelect ?? '')
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

  void checkEnableDate(DateTime date) {
    final maximumDate = DateTime(
      initDateTime.year - 18,
      initDateTime.month,
      initDateTime.day - 1,
    );
    if (date.millisecondsSinceEpoch - maximumDate.millisecondsSinceEpoch > 0) {
      onchangeSelect = true;
    } else {
      onchangeSelect = false;
    }
  }

  Widget calenderPicker() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: FlutterRoundedCupertinoDatePickerWidget(
            maximumDate: DateTime(
              initDateTime.year - 18,
              initDateTime.month,
              initDateTime.day - 1,
            ),
            onDateTimeChanged: (value) {
              checkEnableDate(value);
              cachedSelect = value.toString();
            },
            textStyleDate: titleAppbar(),
            initialDateTime: DateTime.tryParse(dateSelect ?? '') ??
                DateTime(
                  initDateTime.year - 18,
                  initDateTime.month,
                  initDateTime.day - 1,
                ),
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
              if (!onchangeSelect) {
                setState(() {
                  dateSelect = cachedSelect;
                });
                widget.onSelectDate(DateTime.tryParse(dateSelect ?? ''));
                Navigator.pop(context);
              }
            },
            onClickLeft: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
