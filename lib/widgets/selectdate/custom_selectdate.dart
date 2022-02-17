import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomSelectDate extends StatefulWidget {
  final String? value;
  final Function(DateTime) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;

  const CustomSelectDate({
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

class _CustomDropDownState extends State<CustomSelectDate> {
  String dateSelect = '';

  @override
  void didUpdateWidget(covariant CustomSelectDate oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    dateSelect = widget.value ?? DateTime.now().toString();
  }

  @override
  void initState() {
    if (!widget.isObligatory) {
      dateSelect = widget.value ?? DateTime.now().hour.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isObligatory
          ? null
          : () async {
              final String date = DateFormat(DateFormatApp.date)
                  .format(DateTime.parse(dateSelect));
              final DateTime parseDate =
                  DateFormat(DateFormatApp.date).parse(date);

              final selectedDate = await showDatePicker(
                context: context,
                initialDate: parseDate,
                firstDate: DateTime(1800),
                lastDate: DateTime(2200),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light().copyWith(
                        primary: statusCalenderRed,
                      ),
                    ),
                    child: child ?? Container(),
                  );
                },
              );

              if (selectedDate != null) {
                dateSelect = selectedDate.toString();
                dateSelect = selectedDate.toString();
                setState(() {});
                widget.onSelectDate(selectedDate);
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
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
