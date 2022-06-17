import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class TaoHopSuccess extends StatelessWidget {
  const TaoHopSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ImageAssets.svgAssets(
              ImageAssets.img_calendar,
            ),
          ),
          spaceH24,
          Text(
            S.current.tao_hop_thanh_cong,
            style: textNormal(textTitle, 18),
          ),
          spaceH32,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppTheme.getInstance().colorField().withOpacity(0.1),
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 12,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              S.current.quay_lai,
              style:
                  textNormal(AppTheme.getInstance().colorField(), 14).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
