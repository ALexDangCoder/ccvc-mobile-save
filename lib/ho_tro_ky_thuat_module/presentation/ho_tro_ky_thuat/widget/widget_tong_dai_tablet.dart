import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTongDaiTablet extends StatelessWidget {
  final HoTroKyThuatCubit cubit;

  const WidgetTongDaiTablet({
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
        horizontal: 28,
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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: textIconRow(
                  icon: ImageAssets.ic_call,
                  numberPhone: cubit.listTongDai.value.first.phone.toString(),
                  colorText: Color(
                    cubit.getColor(
                      cubit.listTongDai.value.first.color.toString(),
                    ),
                  ),
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
              spaceW40,
              straightLine(
                height: 32,
              ),
              spaceW40,
              Expanded(
                child: textIconRow(
                  icon: ImageAssets.ic_phone,
                  numberPhone: cubit.listTongDai.value.last.phone.toString(),
                  colorText: Color(
                    cubit.getColor(
                      cubit.listTongDai.value.last.color.toString(),
                    ),
                  ),
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget textIconRow({
  required String icon,
  required Color colorText,
  required String numberPhone,
  required MainAxisAlignment mainAxisAlignment,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment,
    children: [
      SvgPicture.asset(
        icon,
        height: 48,
        width: 48,
      ),
      spaceW16,
      Text(
        numberPhone,
        style: textNormalCustom(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorText,
        ),
      ),
    ],
  );
}
