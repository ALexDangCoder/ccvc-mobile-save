import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/fix_bug_cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDateDSCV extends StatefulWidget {
  final String? value;
  final Function(String) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;
  final DateTime? initDateTime;
  final String? maxDate;

  const SelectDateDSCV({
    Key? key,
    this.value,
    required this.onSelectDate,
    this.initDateTime,
    this.hintText,
    this.backgroundColor,
    this.leadingIcon,
    this.paddings,
    this.isObligatory = false,
    this.maxDate,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<SelectDateDSCV> {
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
        if (isMobile()) {
          showBottomSheetCustom(
            context,
            title: S.current.chon_ngay,
            child: showSelectWidget(),
          );
          return;
        }
        showDiaLogTablet(
          context,
          title: S.current.chon_ngay,
          child: showSelectWidget(),
          isBottomShow: false,
          maxHeight: 500,
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

  Widget showSelectWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: FixBugCupertinoDatePicker(
              onDateTimeChanged: (value) {
                dateSelect = value.toString();
                widget.onSelectDate(dateSelect);
              },
              textStyleDate: titleAppbar(),
              initialDateTime:
                  widget.initDateTime ?? DateTime.parse(dateSelect),
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
                setState(() {
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
      );
}
