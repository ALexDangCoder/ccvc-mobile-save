import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDanhSachHoTro extends StatelessWidget {
  final bool isLine;

  const ItemDanhSachHoTro({
    Key? key,
    this.isLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.getInstance().choXuLyColor(),
                    ),
                    child: Center(
                      child: Text(
                        'FU',
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.getInstance().dfBtnTxtColor(),
                        ),
                      ),
                    ),
                  ),
                  spaceW12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nguyễn Văn A - Phó trưởng phòng',
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.getInstance().infoColors(),
                        ),
                      ),
                      spaceH6,
                      Text(
                        '0963094221',
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.getInstance().unselectColor(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                ImageAssets.ic_call,
                width: 32,
                height: 32,
              ),
            ],
          ),
          spaceH16,
          if (!isLine) line(),
        ],
      ),
    );
  }
}
