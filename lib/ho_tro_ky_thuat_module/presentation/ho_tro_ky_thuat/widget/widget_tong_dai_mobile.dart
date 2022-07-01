import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTongDai extends StatelessWidget {
  final HoTroKyThuatCubit cubit;

  const WidgetTongDai({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        bottom: 20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColorApp,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: containerColorTab,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.tong_dai,
            style: textNormalCustom(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.getInstance().titleColor(),
            ),
          ),
          spaceH12,
          Row(
            children: [
              Expanded(
                child: textIconColumn(
                  icon: ImageAssets.ic_call,
                  numberPhone: cubit.listTongDai.value.first.phone.toString(),
                  colorText: Color(
                    int.parse(
                      cubit.getColor(
                        cubit.listTongDai.value.first.color.toString(),
                      ),
                    ),
                  ),
                ),
              ),
              straightLine(
                height: 52,
              ),
              Expanded(
                child: textIconColumn(
                  icon: ImageAssets.ic_phone,
                  numberPhone: cubit.listTongDai.value.last.phone.toString(),
                  colorText: Color(
                    int.parse(
                      cubit.getColor(
                        cubit.listTongDai.value.first.color.toString(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget textIconColumn({
  required String icon,
  required Color colorText,
  required String numberPhone,
}) {
  return Column(
    children: [
      SvgPicture.asset(
        icon,
        height: 48,
        width: 48,
      ),
      spaceH12,
      Text(
        numberPhone,
        style: textNormalCustom(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.getInstance().titleColor(),
        ),
      ),
    ],
  );
}
