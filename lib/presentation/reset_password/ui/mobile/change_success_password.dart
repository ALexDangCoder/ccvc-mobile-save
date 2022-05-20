import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeSuccessPassword extends StatefulWidget {
  const ChangeSuccessPassword({Key? key}) : super(key: key);

  @override
  _ChangeSuccessPasswordState createState() => _ChangeSuccessPasswordState();
}

class _ChangeSuccessPasswordState extends State<ChangeSuccessPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.dat_lai_mat_khau),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                const SizedBox(height: 80.0),
                Text(
                  S.current.doi_lai_mat_khau_thanh_cong,
                  style: textNormalCustom(color: color3D5586, fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SvgPicture.asset(ImageAssets.image_lock_reset),
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 44,
                  width: 163,
                  child: Text(
                    S.current.chuc_mung_ban,
                    textAlign: TextAlign.center,
                    style: textNormalCustom(
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 80.0),
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
