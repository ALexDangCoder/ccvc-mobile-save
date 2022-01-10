import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_textfield.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'change_success_password.dart';

class CreateNewPassWordScreen extends StatefulWidget {
  const CreateNewPassWordScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPassWordScreenState createState() =>
      _CreateNewPassWordScreenState();
}

class _CreateNewPassWordScreenState extends State<CreateNewPassWordScreen> {
  LoginCubit loginCubit = LoginCubit();

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
                  S.current.tao_mk_moi_cho,
                  style: textNormalCustom(color: titleColor, fontSize: 16.0),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'hungto228@gmail.com',
                  style: textNormalCustom(color: textDefault),
                ),
                const SizedBox(height: 30.0),
                CustomTextField(
                  isPass: true,
                  textHint: S.current.mat_khau_moi,
                  loginCubit: loginCubit,
                  prefixIcon: SvgPicture.asset(ImageAssets.icLock),
                  onChange: (text) {
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  isPass: true,
                  textHint: S.current.nhap_lai_mat_khau,
                  loginCubit: loginCubit,
                  prefixIcon: SvgPicture.asset(ImageAssets.icLock),
                  onChange: (text) {
                  },
                ),
                const SizedBox(height: 20.0),
                ButtonCustomBottom(
                  isColorBlue: false,
                  title: S.current.tiep_theo,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChangeSuccessPassword()));
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
