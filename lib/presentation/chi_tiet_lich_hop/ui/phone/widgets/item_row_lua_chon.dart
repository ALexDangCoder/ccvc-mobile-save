import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ItemRowLuaChon extends StatelessWidget {
  final int number;
  final String name;
  final Function() onTap;
  final Function() onTapDanhSach;
  final bool isVote;
  final DetailMeetCalenderCubit cubit;

  const ItemRowLuaChon({
    Key? key,
    required this.number,
    required this.name,
    required this.onTap,
    required this.isVote,
    required this.cubit,
    required this.onTapDanhSach,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.textScale(),
              vertical: 4.0.textScale(),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isVote
                  ? colorLineSearch
                  : AppTheme.getInstance().colorField(),
              border: Border.all(
                color: isVote
                    ? colorLineSearch
                    : AppTheme.getInstance().colorField(),
              ),
            ),
            child: Text(
              name,
              style: textNormalCustom(
                color: backgroundColorApp,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onTapDanhSach(),
          child: Container(
            color: Colors.transparent,
            child: Text(
              '$number',
              style: textNormalCustom(
                color: isVote
                    ? colorLineSearch
                    : AppTheme.getInstance().colorField(),
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ItemRowLuaChonUnColor extends StatelessWidget {
  final int number;
  final String name;
  final Function() onTap;
  final Function() onTapDanhSach;
  final DetailMeetCalenderCubit cubit;

  const ItemRowLuaChonUnColor({
    Key? key,
    required this.number,
    required this.name,
    required this.onTap,
    required this.cubit,
    required this.onTapDanhSach,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.textScale(),
              vertical: 4.0.textScale(),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorLineSearch,
              border: Border.all(
                color: colorLineSearch,
              ),
            ),
            child: Text(
              name,
              style: textNormalCustom(
                color: AppTheme.getInstance().colorField(),
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onTapDanhSach(),
          child: Container(
            color: Colors.transparent,
            child: Text(
              '$number',
              style: textNormalCustom(
                color: AppTheme.getInstance().colorField(),
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
