import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterDateTablet extends StatefulWidget {
  final String? currentStartDate;
  final String? currentEndDate;
  final Function(DateTime startDate, DateTime endDate) onChooseDateFilter;
  final BuildContext context;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  FilterDateTablet({
    Key? key,
    required this.onChooseDateFilter,
    required this.context,
    this.currentStartDate,
    this.currentEndDate,
  }) : super(key: key) {}

  @override
  _FilterDateTabletState createState() => _FilterDateTabletState();
}

class _FilterDateTabletState extends State<FilterDateTablet>
    with SingleTickerProviderStateMixin {
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
              primary: color8E7EFF,
            ),
          ),
          child: child ?? Container(),
        );
      },
    );
    setState(() {
      widget.selectedStartDate = selectedDate ?? DateTime.now();
    });
    widget.onChooseDateFilter(selectedDate ?? DateTime.now(), DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              S.current.tu_ngay,
              style: textNormal(color586B8B, 14.0),
            ),
            const SizedBox(
              width: 16.0,
            ),
            GestureDetector(
              onTap: () {
                _showDatePicker(
                  initialDate: widget.selectedStartDate,
                );
              },
              child: Container(
                width: 163,
                height: 40,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: color05OpacityDBDFEF),
                  borderRadius: BorderRadius.circular(4.0),
                  color: colorFFFFFF,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget
                          .selectedStartDate.toStringWithListFormat,
                      style: textNormal(colorA2AEBD, 14.0),
                    ),
                    const SizedBox(height: 36,),
                    SvgPicture.asset(
                      ImageAssets.icCalendarUnFocus,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 24,),
        Row(
          children: [
            Text(
              S.current.den_ngay,
              style: textNormal(color586B8B, 14.0),
            ),
            const SizedBox(
              width: 16.0,
            ),

            Container(
              width: 163,
              height: 40,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: color05OpacityDBDFEF),
                borderRadius: BorderRadius.circular(4.0),
                color: colorF1F4FF,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selectedEndDate.toStringWithListFormat,
                    style: textNormal(color3D5586, 14.0),
                  ),
                  SvgPicture.asset(ImageAssets.icCalendarUnFocus),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
