import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_screen.dart';
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
      appBar: AppBarDefaultBack(S.current.dat_lai_mat_khau),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80.0),
                Text(
                  S.current.doi_lai_mat_khau_thanh_cong,
                  style: textNormalCustom(color: titleColor, fontSize: 16.0),
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
                      color: unselectedLabelColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 80.0),
                ButtonCustomBottom(
                  isColorBlue: true,
                  title: S.current.ok,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
