import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/widgets/title_cai_dat_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaiDatMauWidget extends StatelessWidget {
  const CaiDatMauWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorApp,
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: TitleCaiDatWidget(
        title: S.current.cai_dat_mau,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            selectColorCell(context,
                color: labelColor,
                name: S.current.mac_dinh,
                appMode: AppMode.MAC_DINH),
            selectColorCell(context,
                color: numberOfCalenders,
                name: S.current.xanh,
                appMode: AppMode.XANH),
            selectColorCell(context,
                color: pinkColor, name: S.current.hong, appMode: AppMode.HONG),
            selectColorCell(context,
                color: yellowColor,
                name: S.current.vang,
                appMode: AppMode.VANG),
          ],
        ),
      ),
    );
  }

  Widget selectColorCell(BuildContext context,
      {required Color color, required String name, required AppMode appMode}) {
    return GestureDetector(
      onTap: () {
        AppStateCt.of(context).appState.setAppMode(appMode);
      },
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Center(
              child: APP_THEME == appMode
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colorFFFFFF.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        ImageAssets.icCheckBoxSelect,
                        color: AppTheme.getInstance().colorField(),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            name,
            style: textNormal(infoColor, 14),
          )
        ],
      ),
    );
  }
}
