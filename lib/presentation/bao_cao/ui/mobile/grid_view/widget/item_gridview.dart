import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/widget/item_chi_tiet.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/widget/xem_them_bottom_sheet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemGridView extends StatelessWidget {
  final ReportItem item;

  const ItemGridView({
    Key? key,
    required this.item,
  }) : super(key: key);

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
                  type: item.type ?? 0,
                  isShare: true,
                  fileNumber: item.childrenTotal ?? 0,
                ),
                spaceH18,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    item.name ?? '',
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
                  (item.dateTime ?? '').changeToNewPatternDate(
                    DateFormatApp.dateTimeBackEnd,
                    DateFormatApp.date,
                  ),
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
