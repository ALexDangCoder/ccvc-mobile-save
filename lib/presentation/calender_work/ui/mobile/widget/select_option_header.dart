import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectOptionHeader extends StatefulWidget {
  final CalenderCubit cubit;
  final Function onTapDay;
  final Function onTapWeek;
  final Function onTapmonth;

  const SelectOptionHeader({
    Key? key,
    required this.cubit,
    required this.onTapDay,
    required this.onTapWeek,
    required this.onTapmonth,
  }) : super(key: key);

  @override
  State<SelectOptionHeader> createState() => _SelectOptionHeaderState();
}

class _SelectOptionHeaderState extends State<SelectOptionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorFFFFFF,
      padding: const EdgeInsets.only(bottom: 13),
      child: StreamBuilder<int>(
        stream: widget.cubit.index,
        builder: (context, snapshot) {
          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.cubit.index.sink.add(0);
                    widget.onTapDay();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icCalenderDay,
                          color: widget.cubit.index.value == 0
                              ? AppTheme.getInstance().colorField()
                              : colorA2AEBD,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          S.current.ngay,
                          style: textNormal(
                            widget.cubit.index.value == 0
                                ? AppTheme.getInstance().colorField()
                                : colorA2AEBD,
                            14.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.cubit.index.sink.add(1);
                    widget.onTapWeek();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icDayCalenderWeek,
                          color: widget.cubit.index.value == 1
                              ? AppTheme.getInstance().colorField()
                              : colorA2AEBD,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          S.current.tuan,
                          style: textNormal(
                            widget.cubit.index.value == 1
                                ? AppTheme.getInstance().colorField()
                                : colorA2AEBD,
                            14.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.cubit.index.sink.add(2);
                    widget.onTapmonth();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icDayCalenderMonth,
                          color: widget.cubit.index.value == 2
                              ? AppTheme.getInstance().colorField()
                              : colorA2AEBD,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          S.current.thang,
                          style: textNormal(
                            widget.cubit.index.value == 2
                                ? AppTheme.getInstance().colorField()
                                : colorA2AEBD,
                            14.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
