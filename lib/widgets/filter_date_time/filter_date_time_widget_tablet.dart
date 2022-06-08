import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterDateTimeWidgetTablet extends StatefulWidget {
  final String? currentStartDate;
  final String? currentEndDate;
  final Function(DateTime startDate, DateTime endDate) onChooseDateFilter;
  final BuildContext context;

  // DateTime selectedStartDate = DateTime.now();
  // DateTime selectedEndDate = DateTime.now();
  final DateTime? initStartDate;
  final DateTime? initEndDate;
  final Function(String)? onChange;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onSubmit;

  FilterDateTimeWidgetTablet({
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
  }) : super(key: key) {}

  @override
  _FilterDateTimeWidgetTabletState createState() =>
      _FilterDateTimeWidgetTabletState();
}

class _FilterDateTimeWidgetTabletState extends State<FilterDateTimeWidgetTablet>
    with SingleTickerProviderStateMixin {
  late DateTime currentStartDate;
  late DateTime currentEndDate;

  @override
  void initState() {
    currentStartDate = widget.initStartDate ?? DateTime.now();
    currentEndDate = widget.initEndDate ?? DateTime.now();
    super.initState();
  }

  @override
  Future<void> _showDatePicker({required DateTime initialDate}) async {
    final selectedDate = await showDatePicker(
      context: widget.context,
      initialDate: initialDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: purpleChart,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );
    if (selectedDate != null) {
      widget.onChooseDateFilter(selectedDate, DateTime.now());
      setState(() {
        currentStartDate = selectedDate;
      });
    }
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
                      _showDatePicker(
                        initialDate: currentStartDate,
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
              onChanged: (searchText) {
                widget.onChange != null ? widget.onChange!(searchText) : null;
              },
              onSubmitted: (searchText) {
                widget.onSubmit != null ? widget.onSubmit!(searchText) : null;
              },
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 36,
                  height: 14,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
                contentPadding: const EdgeInsets.only(left: 20, bottom: 10),
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
}
