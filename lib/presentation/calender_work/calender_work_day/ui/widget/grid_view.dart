import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/widget/wigdet_calender_work_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridViewHeaderLich extends StatefulWidget {
  const GridViewHeaderLich({Key? key}) : super(key: key);

  @override
  _GridViewHeaderLichState createState() => _GridViewHeaderLichState();
}

class _GridViewHeaderLichState extends State<GridViewHeaderLich> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 16,
      mainAxisSpacing: 30,
      childAspectRatio: 1.3,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: List.generate(listCalenderWorkDay.length, (index) {
        final type = listCalenderWorkDay[index];
        if (index == 4) {
          return Container();
        } else if (index == 7) {
          return Container();
        } else {
          return containerType(type, index);
        }
      }),
    );
  }

  Widget containerType(CalenderType type, int index) {
    final CalenderCubit cubit = CalenderCubit();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bgGridView,
        border: Border.all(color: cellColorborder),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: shadowContainerColor.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          spaceH8,
          Expanded(
            child: SvgPicture.asset(
              type.getItem().url,
            ),
          ),
          spaceH8,
          Expanded(
            child: Text(
              cubit.list[index].typeName,
              style: textDetailHDSD(
                fontSize: 16,
                color: titleColor,
                textHeight: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          spaceH6,
          Expanded(
            child: Text(
              '109',
              style: textNormalCustom(fontSize: 26, color: choXuLyColor),
              textAlign: TextAlign.center,
            ),
          ),
          spaceH8
        ],
      ),
    );
  }
}
