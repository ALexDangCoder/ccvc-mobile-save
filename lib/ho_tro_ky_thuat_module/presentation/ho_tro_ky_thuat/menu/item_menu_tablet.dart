import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemMenuTablet extends StatelessWidget {
  final TypeHoTroKyThuat type;
  final int number;
  final bool isSelect;
  final Function onTap;
  final bool isShowNumber;

  const ItemMenuTablet({
    Key? key,
    this.isShowNumber = false,
    required this.type,
    this.number = 0,
    required this.isSelect,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 12.0,
            top: 12.0,
          ),
          decoration: BoxDecoration(
            color: isSelect
                ? AppTheme.getInstance().colorField()
                : toDayColor.withOpacity(0.1),
            border: Border.all(
              color: toDayColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                height: 15.0.textScale(space: 8),
                width: 15.0.textScale(space: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: isSelect
                      ? backgroundColorApp
                      : AppTheme.getInstance().colorField(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    type.getIconMenu,
                    color: !isSelect
                        ? backgroundColorApp
                        : AppTheme.getInstance().colorField(),
                  ),
                ),
              ),
              SizedBox(
                width: 12.0.textScale(space: 6),
              ),
              Expanded(
                child: Text(
                  type.getTitleMenu,
                  style: textNormalCustom(
                    color: isSelect ? backgroundColorApp : color3D5586,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0.textScale(space: 4),
                  ),
                ),
              ),
              if (isShowNumber)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: numberColorTabletbg,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number.toString(),
                    style: textNormalCustom(
                      color: AppTheme.getInstance().colorField(),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0.textScale(),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}