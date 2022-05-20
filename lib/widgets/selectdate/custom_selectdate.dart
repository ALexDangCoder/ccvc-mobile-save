import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomSelectDate extends StatefulWidget {
  final DateTime? value;
  final Function(DateTime) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;
  final DateTime? initDateTime;
  const CustomSelectDate(
      {Key? key,
        this.value,
        required this.onSelectDate,
        this.hintText,
        this.backgroundColor,
        this.leadingIcon,
        this.paddings,
        this.isObligatory = false,
        this.initDateTime})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomSelectDate> {
  DateTime dateSelect = DateTime.now();

  @override
  void initState() {
    if (!widget.isObligatory) {
      dateSelect = widget.value ?? DateTime.now();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomSelectDate oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    dateSelect = widget.value ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMobile()) {
          showBottomSheetCustom(
            context,
            title: S.current.chon_ngay,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: FlutterRoundedCupertinoDatePickerWidget(
                    onDateTimeChanged: (value) {
                      dateSelect = value;
                      widget.onSelectDate(value);
                    },
                    textStyleDate: titleAppbar(),
                    initialDateTime: dateSelect,
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
                    onPressed2: () {
                      setState(() {
                        widget.onSelectDate(dateSelect);
                      });
                      Navigator.pop(context);
                    },
                    onPressed1: () {
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
            title: S.current.chon_ngay,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: FlutterRoundedCupertinoDatePickerWidget(
                      onDateTimeChanged: (value) {
                        dateSelect = value;
                        widget.onSelectDate(dateSelect);
                      },
                      textStyleDate: titleAppbar(),
                      initialDateTime: dateSelect,
                    ),
                  ),
                ],
              ),
            ),
            isBottomShow: true,
            btnLeftTxt: S.current.dong,
            btnRightTxt: S.current.chon,
            funcBtnOk: () {
              setState(() {
                widget.onSelectDate(dateSelect);
              });

              Navigator.pop(context);
            },
            setHeight: 400,
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.isObligatory
                    ? colorDBDFEF.withOpacity(0.3)
                    : widget.backgroundColor ?? Colors.transparent,
                border: Border.all(
                  color: colorDBDFEF,
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
                              : dateSelect.toStringWithListFormat,
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
