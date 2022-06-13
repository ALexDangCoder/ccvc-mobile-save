import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/ui/mobile/chia_se_bao_cao.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class XemThemBottomSheet extends StatefulWidget {
  const XemThemBottomSheet({Key? key}) : super(key: key);

  @override
  State<XemThemBottomSheet> createState() => _XemThemBottomSheetState();
}

class _XemThemBottomSheetState extends State<XemThemBottomSheet> {
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
                const ItemFolder(
                  type: FOLDER,
                  isShare: true,
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
                    return const ChiaSeBaoCaoMobile(

                    );
                  },
                );
              },
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
          lineBaoCao(),
          spaceH18,
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

Widget lineBaoCao() {
  return Padding(
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
}
