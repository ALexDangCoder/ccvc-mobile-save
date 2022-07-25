import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ItemLoaiXe extends StatelessWidget {
  final String titleXeMay;
  final String titleBienKiemSoat;
  final String titleLoaiSoHuu;

  const ItemLoaiXe({
    Key? key,
    required this.titleXeMay,
    required this.titleBienKiemSoat,
    required this.titleLoaiSoHuu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorE2E8F0),
        borderRadius: BorderRadius.circular(6.0),
        color: colorFFFFFF,
        boxShadow: const [
          BoxShadow(
            color: shadow,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.loai_xe,
                  style: textNormalCustom(
                    color: color667793,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  titleXeMay,
                  style: textNormalCustom(
                    color: color667793,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                color: AppTheme.getInstance().lineColor(),
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.bien_kiem_soat,
                  style: textNormalCustom(
                    color: color667793,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceW16,
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      titleBienKiemSoat,
                      style: textNormalCustom(
                        color: color667793,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                color: AppTheme.getInstance().lineColor(),
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.loai_so_huu,
                  style: textNormalCustom(
                    color: color667793,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  titleLoaiSoHuu,
                  style: textNormalCustom(
                    color: color667793,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
