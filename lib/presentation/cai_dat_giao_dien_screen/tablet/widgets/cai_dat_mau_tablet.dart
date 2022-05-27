import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/widgets/check_box_widget.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/widgets/title_cai_dat_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaiDatMauTabletWidget extends StatelessWidget {
  const CaiDatMauTabletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorApp,
      padding: const EdgeInsets.only(top: 28, bottom: 28),
      child: TitleCaiDatWidget(
        title: S.current.cai_dat_mau,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectColorCell(context,
                  icon: ImageAssets.previewDefault,
                  name: S.current.mac_dinh,
                  appMode: AppMode.MAC_DINH),
              selectColorCell(context,
                  icon: ImageAssets.previewBlue,
                  name: S.current.xanh,
                  appMode: AppMode.XANH),
              selectColorCell(context,
                  icon: ImageAssets.previewPink,
                  name: S.current.hong,
                  appMode: AppMode.HONG),
              selectColorCell(context,
                  icon: ImageAssets.previewYellow,
                  name: S.current.vang,
                  appMode: AppMode.VANG),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectColorCell(BuildContext context,
      {required String icon, required String name, required AppMode appMode}) {
    return GestureDetector(
      onTap: () {
        AppStateCt.of(context).appState.setAppMode(appMode);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              // height: 213,
              width: 60.w,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor.withOpacity(0.5)),
                // image: DecorationImage(
                //   image: AssetImage(icon),
                //   fit: BoxFit.fitWidth,
                // ),
              ),
              child: Image.asset(
                icon,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              name,
              style: textNormalCustom(fontSize: 16, color: infoColor),
            ),
            const SizedBox(
              height: 23,
            ),
            CheckBoxWidget(
              value: APP_THEME == appMode,
              onChange: (value) {
                AppStateCt.of(context).appState.setAppMode(appMode);
              },
            )
          ],
        ),
      ),
    );
  }
}
