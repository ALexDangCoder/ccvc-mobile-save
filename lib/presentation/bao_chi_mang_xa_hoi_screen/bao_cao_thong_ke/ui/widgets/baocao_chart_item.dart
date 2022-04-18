// ignore_for_file: lines_longer_than_80_chars

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/buttom_sheet_choice%20_time.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupChartItemWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final Function(String startDate, String endDate) onChoiceDate;

  const GroupChartItemWidget({
    Key? key,
    required this.onChoiceDate,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  State<GroupChartItemWidget> createState() => _GroupChartItemWidgetState();
}

class _GroupChartItemWidgetState extends State<GroupChartItemWidget> {
  late String startTime;
  late String endTime;

  @override
  void initState() {
    super.initState();
    initDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          color: titleCalenderWork,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showBottomSheetCustom(
                            context,
                            child: PopupChoiceTimeWidget(
                              initEndDate: endTime,
                              initStartDate: startTime,
                              onChoiceTime: (startDate, endDate) {
                                widget.onChoiceDate(startDate, endDate);
                                setState(() {
                                  startTime = startDate;
                                  endTime = endDate;
                                });
                              },
                            ),
                            title: '',
                          );
                        },
                        child: SvgPicture.asset(ImageAssets.ic_three_dot_doc),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '${DateTime.parse(startTime).formatApiDDMMYYYYSlash}~${DateTime.parse(endTime).formatApiDDMMYYYYSlash}',
                    style: textNormalCustom(
                      color: textBodyTime,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: widget.child,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void initDateTime() {
    const int millisecondOfWeek = 7 * 24 * 60 * 60 * 1000;
    final int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    final int prevWeek = millisecondNow - millisecondOfWeek;
    endTime = DateTime.now().toString();
    startTime = DateTime.fromMillisecondsSinceEpoch(prevWeek).toString();
  }
}
