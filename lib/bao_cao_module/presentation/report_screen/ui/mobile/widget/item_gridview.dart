import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/detail_item_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/show_more_bottom_sheet.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemGridView extends StatelessWidget {
  final ReportItem item;
  final ReportListCubit cubit;

  const ItemGridView({
    Key? key,
    required this.item,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DetailItemMobile(),
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
            if (item.isPin ?? false)
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
                    builder: (context) => ShowMoreBottomSheet(
                      reportItem: item,
                      cubit: cubit,
                      isFavorite: item.isPin ?? false,
                    ),
                  ).whenComplete(
                    () => cubit.getListReport(),
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
                  isShare: true, //todo
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
