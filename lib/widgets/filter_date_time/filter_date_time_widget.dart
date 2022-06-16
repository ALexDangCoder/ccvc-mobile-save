import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterDateTimeWidget extends StatefulWidget {
  final bool isMobile;
  final String? currentStartDate;
  final String? currentEndDate;
  final Function(DateTime startDate, DateTime endDate) onChooseDateFilter;
  final BuildContext context;
  final DateTime? initStartDate;
  final DateTime? initEndDate;

  FilterDateTimeWidget({
    Key? key,
    required this.onChooseDateFilter,
    required this.context,
    this.currentStartDate,
    this.currentEndDate,
    this.isMobile = true,
    this.initStartDate,
    this.initEndDate,
  }) : super(key: key) {}

  @override
  _FilterDateTimeWidgetState createState() => _FilterDateTimeWidgetState();
}

class _FilterDateTimeWidgetState extends State<FilterDateTimeWidget>
    with SingleTickerProviderStateMixin {
  late DateTime currentStartDate;
  late DateTime currentEndDate;

  @override
  void initState() {
    currentStartDate = widget.initStartDate ?? DateTime.now();
    currentEndDate = widget.initEndDate ?? DateTime.now();
    super.initState();
  }

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
      color: widget.isMobile ? bgTabletColor : backgroundColorApp,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.isMobile
              ? [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            S.current.tu_ngay,
                            style: textNormal(titleItemEdit, 14.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDatePicker(
                              initialDate: currentStartDate,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
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
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    currentStartDate.toStringWithListFormat,
                                    style: textNormalCustom(
                                      color: textBodyTime,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SvgPicture.asset(
                                    ImageAssets.icCalendarUnFocus,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.current.den_ngay,
                            style: textNormal(titleItemEdit, 14.0),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
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
                              Expanded(
                                flex: 4,
                                child: Text(
                                  currentEndDate.toStringWithListFormat,
                                  style: textNormalCustom(color: color3D5586, fontSize: 14.0, fontWeight: FontWeight.w400,),
                                ),
                              ),
                              Expanded(child: SvgPicture.asset(ImageAssets.icCalendarUnFocus)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]
              : [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          S.current.tu_ngay,
                          style: textNormal(titleItemEdit, 14.0),
                        ),
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
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
                              ),
                              spaceW20,
                              ImageAssets.svgAssets(
                                ImageAssets.icCalendarUnFocus,
                                width: 24,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  spaceW25,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          S.current.den_ngay,
                          style: textNormal(titleItemEdit, 14.0),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
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
                            ),
                            spaceW20,
                            ImageAssets.svgAssets(
                              ImageAssets.icCalendarUnFocus,
                              width: 24,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
        ),
      ),
    );
  }
}
