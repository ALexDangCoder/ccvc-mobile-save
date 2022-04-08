import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/popup_choice_date.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupChartItemWidget extends StatefulWidget {
  final String title;
  final Widget child;

  const GroupChartItemWidget({
    Key? key,
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
    startTime = DateTime.now().toString();
    endTime = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
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
                        child: PopupChoiceDate(
                          onChoiceTime: (startDate, endDate) {
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
              const SizedBox(
                height: 6,
              ),
              Text(
                DateTime.parse(startTime).formatApiDDMMYYYYSlash,
                style: textNormalCustom(
                  color: textBodyTime,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
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
    );
  }
}
