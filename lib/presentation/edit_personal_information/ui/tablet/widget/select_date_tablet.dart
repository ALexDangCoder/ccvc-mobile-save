import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDateTablet extends StatefulWidget {
  final String? value;
  final Function(String) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;

  const SelectDateTablet({
    Key? key,
    this.value,
    required this.onSelectDate,
    this.hintText,
    this.backgroundColor,
    this.leadingIcon,
    this.paddings,
    this.isObligatory = false,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<SelectDateTablet> {
  String dateSelect = '';

  @override
  void initState() {
    if (!widget.isObligatory) {
      dateSelect = widget.value.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                      dateSelect = value.toString();
                      widget.onSelectDate(dateSelect);
                    },
                    textStyleDate: titleAppbar(),
                    initialDateTime: DateTime.parse(dateSelect),
                  ),
                ),
              ],
            ),
          ),
          isBottomShow: true,
          btnLeftTxt: S.current.dong,
          btnRightTxt: S.current.chon,
          funcBtnOk: (context) {
            if (mounted) {
              setState(() {
                widget.onSelectDate(dateSelect);
              });
            }
            Navigator.pop(context);
          },
          setHeight: 400,
        );
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
                                  color: titleColor,
                                ),
                              )
                            : Text(
                                widget.isObligatory
                                    ? '${widget.value}'
                                    : DateTime.parse(dateSelect)
                                        .toStringWithListFormat,
                                style: tokenDetailAmount(
                                  fontSize: 14.0.textScale(),
                                  color: titleColor,
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
