import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeSuccessPasswordTablet extends StatefulWidget {
  const ChangeSuccessPasswordTablet({Key? key}) : super(key: key);

  @override
  _ChangeSuccessPasswordTabletState createState() =>
      _ChangeSuccessPasswordTabletState();
}

class _ChangeSuccessPasswordTabletState
    extends State<ChangeSuccessPasswordTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.dat_lai_mat_khau),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 510.0,
            child: Column(
              children: [
                const SizedBox(height: 80.0),
                Text(
                  S.current.doi_lai_mat_khau_thanh_cong,
                  style: textNormalCustom(color: color3D5586, fontSize: 20.0),
                ),
                const SizedBox(height: 60.0),
                Center(
                  child: SvgPicture.asset(ImageAssets.image_lock_reset_tablet),
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 52,
                  width: 186,
                  child: Text(
                    S.current.chuc_mung_ban,
                    textAlign: TextAlign.center,
                    style: textNormalCustom(
                      fontSize: 16.0,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 120.0),
                ButtonCustomBottom(
                  isColorBlue: true,
                  title: S.current.ok,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
