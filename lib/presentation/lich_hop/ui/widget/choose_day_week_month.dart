import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseDayWeedMonth extends StatelessWidget {
  final Function onTapDay;
  final Function onTapWeek;
  final Function onTapmonth;
  final LichHopCubit cubit;

  const ChooseDayWeedMonth({
    Key? key,
    required this.onTapDay,
    required this.onTapWeek,
    required this.onTapmonth,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorApp,
      padding: const EdgeInsets.only(bottom: 13),
      child: StreamBuilder<int>(
        stream: cubit.index.stream,
        builder: (context, snapshot) {
          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.index.sink.add(0);
                    onTapDay();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icCalenderDay,
                          color: cubit.index.value == 0
                              ? AppTheme.getInstance().colorField()
                              : iconColorDown,),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          S.current.ngay,
                          style: textNormal(cubit.index.value == 0
                              ? AppTheme.getInstance().colorField()
                              : iconColorDown, 14.0,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.index.sink.add(1);
                    onTapWeek();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageAssets.icDayCalenderWeek,
                          color: cubit.index.value == 1
                              ? AppTheme.getInstance().colorField()
                              : iconColorDown,),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          S.current.tuan,
                          style: textNormal(cubit.index.value == 1
                              ? AppTheme.getInstance().colorField()
                              : iconColorDown, 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.index.sink.add(2);
                    onTapmonth();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageAssets.icDayCalenderMonth,
                          color: cubit.index.value == 2
                              ? AppTheme.getInstance().colorField()
                              : iconColorDown,),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          S.current.thang,
                          style: textNormal(cubit.index.value == 2
                              ? AppTheme.getInstance().colorField()
                              : iconColorDown, 14.0),
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
