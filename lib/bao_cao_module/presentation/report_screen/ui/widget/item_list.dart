import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/widget/show_dialog_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/show_more_bottom_sheet_mobile.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemList extends StatelessWidget {
  final ReportItem item;
  final ReportListCubit cubit;
  final bool isTablet;

  const ItemList({
    Key? key,
    required this.item,
    required this.cubit,
    this.isTablet = false,
  }) : super(key: key);

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
            type: item.type ?? 0,
            isShare: cubit.checkStatus(
              item.status ?? 0,
              item.type ?? 0,
            ),
            fileNumber: item.childrenTotal ?? 0,
            isListView: true,
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
                    item.name ?? '',
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
            ),
          ),
          if (item.isPin ?? false)
            SvgPicture.asset(
              ImageAssets.icStarFocus,
              width: 16,
              height: 16,
            ),
          InkWell(
            onTap: () {
              if (isTablet) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return ShowMoreBottomSheetTablet(
                      reportItem: item,
                      cubit: cubit,
                      isFavorite: item.isPin ?? false,
                    );
                  },
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ShowMoreBottomSheetMobile(
                    reportItem: item,
                    cubit: cubit,
                    isFavorite: item.isPin ?? false,
                  ),
                );
              }
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
