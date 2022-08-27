import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/fix_bug_cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  final Function(String?) onSelectDate;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheetCustom(
          context,
          title: S.current.chon_ngay,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: FixBugCupertinoDatePicker(
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (value) {
                    setState(() {
                      dateSelect = value.toString();
                    });
                    widget.onSelectDate(value.toString());
                  },
                  textStyleDate: titleAppbar(),
                  initialDateTime: DateTime.tryParse(dateSelect ?? ''),
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
                    widget.onSelectDate(dateSelect);
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
                          DateFormatApp.date,
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
}