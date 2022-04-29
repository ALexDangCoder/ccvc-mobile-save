import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/widgets/button/double_button_bottom.dart';
import '/home_module/widgets/selectdate/custom_selectdate.dart';

class CustomSelectDateWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime startDate, DateTime endDate) onXacNhan;
  const CustomSelectDateWidget({
    Key? key,
    required this.endDate,
    required this.startDate,
    required this.onXacNhan,
  }) : super(key: key);

  @override
  _CustomSelectDateWidgetState createState() => _CustomSelectDateWidgetState();
}

class _CustomSelectDateWidgetState extends State<CustomSelectDateWidget> {
  late DateTime startDate;
  late DateTime endDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startDate = widget.startDate;
    endDate = widget.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(mobileScreen: _mobile(), tabletScreen: _tablet());
  }

  Widget _mobile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        dateSelectCell(
          value: startDate,
          title: S.current.tu_ngay,
          onSelect: selectStartDate,
        ),
        const SizedBox(
          height: 20,
        ),
        dateSelectCell(
          value: endDate,
          title: S.current.den_ngay,
          onSelect: selectEndDate,
        ),
        const SizedBox(
          height: 24,
        ),
        DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.xac_nhan,
          onPressed1: () {
            Navigator.of(context).pop();
          },
          onPressed2: () {
            Navigator.pop(context);
            widget.onXacNhan(startDate, endDate);
          },
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget _tablet() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox.expand(
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 394,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: borderColor.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.current.chon_khoang_thoi_gian,
                    style: textNormalCustom(fontSize: 16, color: textTitle),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: dateSelectCell(
                          value: startDate,
                          title: S.current.tu_ngay,
                          onSelect: selectStartDate,
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      Expanded(
                        child: dateSelectCell(
                          value: endDate,
                          title: S.current.den_ngay,
                          onSelect: selectEndDate,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buttonWidget(
                        S.current.bo_qua,
                        () {},
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      buttonWidget(
                        S.current.hien_thi,
                        () {
                          widget.onXacNhan(startDate, endDate);
                        },
                        isClose: false,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dateSelectCell({
    required String title,
    required Function(DateTime) onSelect,
    required DateTime value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textNormal(titleItemEdit, 14.0.textScale()),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomSelectDate(
          value: value,
          onSelectDate: onSelect,
          leadingIcon: SvgPicture.asset(
            ImageAssets.icCalendar,
            height: 20,
            width: 18,
          ),
        ),
      ],
    );
  }

  void selectStartDate(DateTime value) {
    final int startDateInt = value.millisecondsSinceEpoch;
    final int endDateInt = endDate.millisecondsSinceEpoch;
    if (startDateInt > endDateInt) {
      endDate = value;
      setState(() {});
    }
    startDate = value;
  }

  void selectEndDate(DateTime value) {
    final int endDateInt = value.millisecondsSinceEpoch;
    final int startDateInt = endDate.millisecondsSinceEpoch;
    if (endDateInt < startDateInt) {
      startDate = value;
      setState(() {});
    }
    endDate = value;
  }

  Widget buttonWidget(String title, Function() onTap, {bool isClose = true}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        width: 108,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isClose
              ? AppTheme.getInstance().colorSelect().withOpacity(0.1)
              : AppTheme.getInstance().colorSelect(),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: textNormalCustom(
            fontSize: 16,
            color: isClose ? indicatorColor : backgroundColorApp,
          ),
        ),
      ),
    );
  }
}
