// ignore_for_file: lines_longer_than_80_chars

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/tablet/widgets/pop_up_choice_time_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/buttom_sheet_choice_time.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupChartItemWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isTablet;
  final Function(String startDate, String endDate) onChoiceDate;

  const GroupChartItemWidget({
    Key? key,
    required this.onChoiceDate,
    required this.title,
    required this.child,
    this.isTablet = false,
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
      padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 24 : 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: widget.isTablet ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.isTablet ? 24 : 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: textNormalCustom(
                            color: titleCalenderWork,
                            fontSize: widget.isTablet ? 20.0 : 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                     const  SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () {
                          widget.isTablet?showDialog(context: context, builder: (context){
                            return Dialog(
                              child: PopupChoiceTimeTablet(
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
                            );
                          },):
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.isTablet ? 24 : 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: widget.isTablet ? 24 : 16),
                  child: Text(
                    '${DateTime
                        .parse(startTime)
                        .formatApiDDMMYYYYSlash}~${DateTime
                        .parse(endTime)
                        .formatApiDDMMYYYYSlash}',
                    style: textNormalCustom(
                      color: textBodyTime,
                      fontSize: widget.isTablet ? 16 : 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.isTablet ? 16 : 20,
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
    final int millisecondNow = DateTime
        .now()
        .millisecondsSinceEpoch;
    final int prevWeek = millisecondNow - millisecondOfWeek;
    endTime = DateTime.now().toString();
    startTime = DateTime.fromMillisecondsSinceEpoch(prevWeek).toString();
  }
}
