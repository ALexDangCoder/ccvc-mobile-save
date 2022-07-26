import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewDayCalendarWidget extends StatefulWidget {
  final List<TypeStateDiemDanh> state;
  final String timeIn;
  final String timeOut;
  final double dayWage;

  const ViewDayCalendarWidget({
    Key? key,
    required this.state,
    required this.dayWage,
    required this.timeIn,
    required this.timeOut,
  }) : super(key: key);

  @override
  State<ViewDayCalendarWidget> createState() => _ViewDayCalendarWidgetState();
}

class _ViewDayCalendarWidgetState extends State<ViewDayCalendarWidget> {
  bool isShowDate = false;
  final List<TypeStateDiemDanh> rowViewData = [];

  @override
  void initState() {
    super.initState();

    ///nếu nhiều hơn 1 trạng thái thì truyền các trạng thái (trừ cái đầu tiên) để hiển thị bên trên
    if (widget.state.length > 1) {
      for (int state = 1; state < widget.state.length; state++) {
        rowViewData.add(widget.state[state]);
      }
    }
  }

  @override
  void didUpdateWidget(ViewDayCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    ///nếu nhiều hơn 1 trạng thái thì truyền các trạng thái (trừ cái đầu tiên) để hiển thị bên trên
    if (widget.state.length > 1) {
      for (int state = 1; state < widget.state.length; state++) {
        rowViewData.add(widget.state[state]);
      }
    }
  }

  String get getStringDate {
    if (widget.timeIn.isEmpty && widget.timeOut.isNotEmpty) {
      return '??:??-${widget.timeOut.getTime}';
    }

    if (widget.timeOut.isEmpty && widget.timeIn.isNotEmpty) {
      return '${widget.timeIn.getTime}-??:??';
    }

    if (widget.timeIn.isEmpty && widget.timeOut.isEmpty) {
      return '??:??-??:??';
    }

    if (widget.timeIn.isNotEmpty && widget.timeOut.isNotEmpty) {
      return '${widget.timeIn.getTime}-${widget.timeOut.getTime}';
    }

    return '??:??-??:??';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.dayWage == 0.0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.state
                .map(
                  (dataState) => Row(
                    children: [
                      SvgPicture.asset(
                        dataState.getIcon,
                        height: 12,
                        width: 12,
                      ),
                      spaceW3,
                    ],
                  ),
                )
                .toList(),
          )
        else
          dayWageWidget(),
        spaceH12,
        GestureDetector(
          onTap: () {
            isShowDate = !isShowDate;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              color: widget.timeIn.isEmpty || widget.timeOut.isEmpty
                  ? colorEA5455
                  : color20C997,
              borderRadius: BorderRadius.circular(2),
            ),
            child: isShowDate
                ? Text(
                    getStringDate,
                    style: textNormalCustom(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 9,
                    ),
                  )
                : Text(
                    getStringDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textNormalCustom(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 9,
                    ),
                  ),
          ),
        ),
        spaceH4,
      ],
    );
  }

  Widget dayWageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.state.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: rowViewData
                .map(
                  (dataState) => Row(
                    children: [
                      SvgPicture.asset(
                        dataState.getIcon,
                        height: 12,
                        width: 12,
                      ),
                      spaceW2,
                    ],
                  ),
                )
                .toList(),
          )
        else
          Container(),
        spaceH3,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.dayWage.toString(),
              style: textNormalCustom(
                color: color667793,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            spaceW2,
            SvgPicture.asset(
              ImageAssets.icDiLam,
              width: 10,
              height: 10,
            ),
            getViewState(),
          ],
        ),
      ],
    );
  }

  Widget getViewState() {
    if (widget.state.isEmpty) {
      return Container();
    } else if (widget.state.isNotEmpty) {
      return Row(
        children: [
          spaceW6,
          SvgPicture.asset(
            widget.state[0].getIcon,
            height: 12,
            width: 12,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
