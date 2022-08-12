import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemMenuMobile extends StatelessWidget {
  final TypeHoTroKyThuat type;
  final Function onTap;
  final bool isSelect;

  const ItemMenuMobile({
    Key? key,
    required this.type,
    required this.onTap,
    required this.isSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 17.0.textScale(space: 13),
          vertical: 10.0.textScale(space: 4),
        ),
        color: isSelect ? color_464646 : null,
        child: Row(
          children: [
            SizedBox(
              height: 15.0.textScale(space: 8),
              width: 15.0.textScale(space: 8),
              child: SvgPicture.asset(
                type.getIconMenu,
              ),
            ),
            SizedBox(
              width: 12.0.textScale(space: 6),
            ),
            Expanded(
              child: Text(
                type.getTitleMenu,
                softWrap: true,
                maxLines: 2,
                style: textNormalCustom(
                  color: backgroundColorApp,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0.textScale(space: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
