import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CellMenuCustom extends StatelessWidget {
  final String icon;
  final String name;
  final bool isSelect;
  final Function onTap;
  final int number;
  final bool margin;

  const CellMenuCustom({
    Key? key,
    required this.icon,
    required this.name,
    required this.isSelect,
    required this.onTap,
    required this.number,
    this.margin = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 24,
        left: margin ? 30 : 0,
        right: margin ? 30 : 0,
      ),
      decoration: BoxDecoration(
        color: toDayColor.withOpacity(0.1),
        border: Border.all(
          color: toDayColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: 17.0.textScale(space: 13),
            vertical: 10.0.textScale(space: 4),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 15.0.textScale(space: 8),
                width: 15.0.textScale(space: 8),
                child: SvgPicture.asset(
                  icon,
                  color: AppTheme.getInstance().colorField(),
                ),
              ),
              SizedBox(
                width: 12.0.textScale(space: 6),
              ),
              Text(
                name,
                style: textNormalCustom(
                  color: color3D5586,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0.textScale(space: 4),
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppTheme.getInstance().colorField(),
                ),
                alignment: Alignment.center,
                child: Text(
                  number.toString(),
                  style: textNormalCustom(
                    color: backgroundColorApp,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0.textScale(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
