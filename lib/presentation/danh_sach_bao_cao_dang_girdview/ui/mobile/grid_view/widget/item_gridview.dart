import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/item_chi_tiet.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/xem_them_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

import '../danh_sach_bao_cao_dang_girdview.dart';

class ItemGridView extends StatelessWidget {
  const ItemGridView({
    Key? key,
    this.type = TypeLoai.BAO_CAO,
  }) : super(key: key);
  final TypeLoai type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ItemChiTiet(),
          ),
        );
      },
      child: Container(
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: SvgPicture.asset(
                ImageAssets.icStarFocus,
                width: 16,
                height: 16,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
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
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: SvgPicture.asset(
                    ImageAssets.icMore,
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ItemFolder(
                  type: type,
                  isChiaSe: true,
                ),
                spaceH18,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'S.current.bac_caodfsadfsadfsadfsadfasdfsadf',
                    maxLines: 1,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
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
          ],
        ),
      ),
    );
  }
}
