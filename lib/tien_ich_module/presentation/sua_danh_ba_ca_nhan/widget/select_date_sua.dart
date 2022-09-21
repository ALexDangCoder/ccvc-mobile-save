import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/dialog_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/fix_bug_cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SelectDateSua extends StatefulWidget {
  final String? value;
  final Function(String) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;
  final bool isTablet;

  const SelectDateSua({
    Key? key,
    this.value,
    required this.onSelectDate,
    this.hintText,
    this.backgroundColor,
    this.leadingIcon,
    this.paddings,
    this.isObligatory = false,
    this.isTablet = false,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<SelectDateSua> {
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
    return widget.isTablet
        ? GestureDetector(
            onTap: () {
              showDiaLogTablet(
                context,
                isBottomShow: false,
                title: S.current.chon_ngay,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: FixBugCupertinoDatePicker(
                          onDateTimeChanged: (value) {
                            dateSelect = value.toString();
                            final dateFormat = DateFormat(
                              'yyyy-MM-dd HH:mm:ss',
                            ).parse(dateSelect).formatApiDanhBa;
                            dateSelect = dateFormat;
                          },
                          textStyleDate: titleAppbar(),
                          initialDateTime:
                              DateTime.parse(widget.value.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
                btnRightTxt: S.current.chon,
                funcBtnOk: () {
                  setState(() {
                    widget.onSelectDate(dateSelect);
                  });
                },
                setHeight: 400,
                funcBtnPop: () {},
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 16.0.textScale(space: 4),
                    height: 16.0.textScale(space: 4),
                    color: Colors.transparent,
                    child: widget.leadingIcon ??
                        SvgPicture.asset(ImageAssets.icCalenderDb),
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
                                      ? DateFormat('yyyy-MM-ddTHH:mm:ss')
                                          .parse(widget.value ?? '')
                                          .toStringWithListFormat
                                      : DateFormat('yyyy-MM-ddTHH:mm:ss')
                                          .parse(dateSelect)
                                          .toStringWithListFormat,
                                  style: tokenDetailAmount(
                                    fontSize: 14.0.textScale(),
                                    color: color3D5586,
                                  ),
                                ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colorECEEF7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              showBottomSheetCustom(
                context,
                title: S.current.chon_ngay,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: FixBugCupertinoDatePicker(
                          onDateTimeChanged: (value) {
                            dateSelect = value.toString();
                            final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss')
                                .parse(
                                  dateSelect,
                                )
                                .formatApiDanhBa;
                            dateSelect = dateFormat;
                          },
                          textStyleDate: titleAppbar(),
                          initialDateTime: DateTime.parse(
                            widget.value.toString(),
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
                            setState(() {
                              widget.onSelectDate(
                                dateSelect,
                              );
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
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: 16.0.textScale(space: 4),
                  height: 16.0.textScale(space: 4),
                  color: Colors.transparent,
                  child: widget.leadingIcon ??
                      SvgPicture.asset(ImageAssets.icCalenderDb),
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
                        child: widget.value == null
                            ? Text(
                                widget.value ?? S.current.vuiLongChon,
                                style: tokenDetailAmount(
                                  fontSize: 14.0.textScale(),
                                  color: color3D5586,
                                ),
                              )
                            : Text(
                                widget.isObligatory
                                    ? DateFormat('yyyy-MM-ddTHH:mm:ss')
                                        .parse(widget.value ?? '')
                                        .toStringWithListFormat
                                    : DateFormat('yyyy-MM-ddTHH:mm:ss')
                                        .parse(dateSelect)
                                        .toStringWithListFormat,
                                style: tokenDetailAmount(
                                  fontSize: 14.0.textScale(),
                                  color: color3D5586,
                                ),
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: colorECEEF7),
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
