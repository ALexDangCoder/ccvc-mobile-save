import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/ui/mobile/chia_se_bao_cao.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowMoreBottomSheet extends StatefulWidget {
  const ShowMoreBottomSheet({
    Key? key,
    required this.reportItem,
  }) : super(key: key);
  final ReportItem reportItem;

  @override
  State<ShowMoreBottomSheet> createState() => _ShowMoreBottomSheetState();
}

class _ShowMoreBottomSheetState extends State<ShowMoreBottomSheet> {
  final bool isLove = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH20,
          Center(
            child: Container(
              height: 6,
              width: 48,
              decoration: const BoxDecoration(
                color: colorECEEF7,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 22.5,
              bottom: 16,
            ),
            child: Row(
              children: [
                ItemFolder(
                  type: widget.reportItem.type ?? 0,
                  isShare: true,
                  isListView: true,
                  fileNumber: widget.reportItem.childrenTotal ?? 0,
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
                          widget.reportItem.name ?? '',
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
                          (widget.reportItem.dateTime ?? '')
                              .changeToNewPatternDate(
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
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: borderColor.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 18,
              bottom: 18,
            ),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return const ChiaSeBaoCaoMobile();
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.icUploadSvg,
                      width: 20,
                      height: 20,
                      color: AppTheme.getInstance().unselectColor(),
                    ),
                    spaceW13,
                    Text(
                      S.current.chia_se,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().unselectedColor(),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          reportLine,
          if (widget.reportItem.type == REPORT) spaceH18,
          if (widget.reportItem.type == REPORT)
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.icStarFocus,
                        width: 16,
                        height: 16,
                        color: AppTheme.getInstance().unselectColor(),
                      ),
                      spaceW13,
                      Text(
                        S.current.yeu_thich,
                        style: textNormalCustom(
                          color: AppTheme.getInstance().unselectedColor(),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  customSwitch(
                    isLove,
                    (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          spaceH30,
        ],
      ),
    );
  }
}

Widget reportLine = Padding(
  padding: const EdgeInsets.only(
    right: 16,
    left: 48,
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: borderColor.withOpacity(0.5),
  ),
);
