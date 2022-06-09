import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/danh_sach_bao_cao_dang_girdview.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/xem_them_bottom_sheet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: backgroundColorApp,
        border: Border.all(color: borderColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ItemFolder(
            type: TypeLoai.THU_MUC,
            isChiaSe: true,
            isItemListView: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'S.current.bac_caodfsadfsadfsadfsadfasdfsadf',
                    maxLines: 1,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH4,
                  Text(
                    '18/5/2022',
                    style: textNormalCustom(
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SvgPicture.asset(
            ImageAssets.icStarFocus,
            width: 16,
            height: 16,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => XemThemBottomSheet(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 18,
              ),
              child: SvgPicture.asset(
                ImageAssets.icMore,
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
