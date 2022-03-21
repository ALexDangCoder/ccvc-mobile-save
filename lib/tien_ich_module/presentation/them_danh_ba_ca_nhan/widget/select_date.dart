import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

class SelectDate extends StatefulWidget {
  final String? value;
  final Function(String) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;

  const SelectDate({
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

class _CustomDropDownState extends State<SelectDate> {
  String dateSelect = '';
  BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  @override
  void initState() {
    dateSelect = widget.value.toString();
    super.initState();
  }

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
                height: MediaQuery.of(context).size.height * 0.4,
                child: FlutterRoundedCupertinoDatePickerWidget(
                  onDateTimeChanged: (value) {
                    dateSelect = value.toString();
                    widget.onSelectDate(dateSelect);
                    if (dateSelect.isNotEmpty) {
                      behaviorSubject.sink.add(dateSelect);
                    } else {
                      behaviorSubject.sink.add('');
                    }
                  },
                  textStyleDate: titleAppbar(),
                  initialDateTime: DateTime.now(),
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
      },
      child: Row(
        children: [
          Container(
            width: 16.0.textScale(space: 4),
            height: 16.0.textScale(space: 4),
            color: Colors.transparent,
            child: SvgPicture.asset(ImageAssets.icCalenderDb),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    left: 16,
                  ),
                  child: widget.value == null || widget.value == ''
                      ? StreamBuilder<String>(
                          stream: behaviorSubject,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? '';
                            return data.isNotEmpty
                                ? Text(
                                    DateTime.parse(dateSelect)
                                        .toStringWithListFormat,
                                    style: tokenDetailAmount(
                                      fontSize: 14,
                                      color: titleColor,
                                    ),
                                  )
                                : Text(
                                    S.current.ngay_sinh,
                                    style: tokenDetailAmount(
                                      fontSize: 16,
                                      color: AqiColor,
                                    ),
                                  );
                          },
                        )
                      : const SizedBox(),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: lineColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
