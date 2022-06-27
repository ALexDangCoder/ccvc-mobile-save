import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemMenuDiemDanhWidgetMobile extends StatelessWidget {
  final TypeDiemDanh type;
  final Function onTap;
  final bool isSelect;

  const ItemMenuDiemDanhWidgetMobile({
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
        color: isSelect ? AppTheme.getInstance().colorField() : Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 15.0.textScale(space: 8),
              width: 15.0.textScale(space: 8),
              child: SvgPicture.asset(
                type.getIconMenu,
                color: isSelect
                    ? Colors.white
                    : AppTheme.getInstance().colorField(),
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
                  color: isSelect
                      ? Colors.white
                      : AppTheme.getInstance().titleColor(),
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
