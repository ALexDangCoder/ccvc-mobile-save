import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/fix_bug_cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterDateTimeWidgetTablet extends StatefulWidget {
  final String? currentStartDate;
  final String? currentEndDate;
  final Function(DateTime startDate, DateTime endDate) onChooseDateFilter;
  final BuildContext context;

  final DateTime? initStartDate;
  final DateTime? initEndDate;
  final Function(String)? onChange;
  final Function(String)? onClose;
  final bool isBtnClose;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onSubmit;

  const FilterDateTimeWidgetTablet({
    Key? key,
    required this.onChooseDateFilter,
    required this.context,
    this.initStartDate,
    this.initEndDate,
    this.currentStartDate,
    this.currentEndDate,
    this.onChange,
    this.hintText,
    this.controller,
    this.onSubmit,
    this.onClose,
    this.isBtnClose = false,
  }) : super(key: key);

  @override
  _FilterDateTimeWidgetTabletState createState() =>
      _FilterDateTimeWidgetTabletState();
}

class _FilterDateTimeWidgetTabletState extends State<FilterDateTimeWidgetTablet>
    with SingleTickerProviderStateMixin {
  late DateTime currentStartDate;
  late DateTime currentEndDate;
  DateTime chooseTime = DateTime.now();

  @override
  void initState() {
    currentStartDate = widget.initStartDate ?? DateTime.now();
    currentEndDate = widget.initEndDate ?? DateTime.now();
    widget.controller?.addListener(() {
      if (widget.controller?.text == '') {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: backgroundColorApp,
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    S.current.tu_ngay,
                    style: textNormal(titleItemEdit, 14.0),
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
                                child: FixBugCupertinoDatePicker(
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
                            currentStartDate,
                            DateTime.now(),
                          );
                          Navigator.pop(context);
                        },
                        setHeight: 400,
                      );
                    },
                    child: Container(
                      width: 163,
                      height: 40,
                      padding: const EdgeInsets.symmetric(
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
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          SvgPicture.asset(
                            ImageAssets.icCalendarUnFocus,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Row(
                children: [
                  Text(
                    S.current.den_ngay,
                    style: textNormal(titleItemEdit, 14.0),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    width: 163,
                    height: 40,
                    padding: const EdgeInsets.symmetric(
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
                          textAlign: TextAlign.center,
                        ),
                        SvgPicture.asset(ImageAssets.icCalendarUnFocus),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChange,
              onSubmitted: widget.onSubmit,
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 36,
                  height: 14,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: SvgPicture.asset(
                        ImageAssets.ic_KinhRong,
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 26,
                  minHeight: 26,
                ),
                suffixIcon: widget.isBtnClose
                    ? widget.controller?.text != ''
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  widget.onClose?.call(
                                    widget.controller?.text ?? '',
                                  );
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: coloriCon,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                    : const SizedBox(),
                contentPadding: const EdgeInsets.only(left: 20, top: 4),
                isCollapsed: true,
                fillColor: bgDropDown.withOpacity(0.1),
                filled: true,
                hintText: widget.hintText ?? S.current.tiem_kiem,
                hintStyle: textNormal(
                  AppTheme.getInstance().sideTextInactiveColor(),
                  14,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: bgDropDown),
                ),
              ),
            ),
          )
        ],
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
