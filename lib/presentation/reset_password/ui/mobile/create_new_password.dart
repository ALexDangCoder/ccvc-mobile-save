import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_textfield.dart';
import 'package:ccvc_mobile/presentation/reset_password/bloc/reset_password_cubit.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/mobile/change_success_password.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateNewPassWordScreen extends StatefulWidget {
  const CreateNewPassWordScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPassWordScreenState createState() =>
      _CreateNewPassWordScreenState();
}

class _CreateNewPassWordScreenState extends State<CreateNewPassWordScreen> {
  ResetPasswordCubit cubit = ResetPasswordCubit();
  TextEditingController matKhauMoiController = TextEditingController();
  TextEditingController nhapLaiMatKhauController = TextEditingController();
  final keytextmatKhauMoi = GlobalKey<FormState>();
  final keytextnhapLaiMatKhau = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.doi_lai_mat_khau),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
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
                Form(
                  key: keytextmatKhauMoi,
                  child: CustomTextField(
                    controller: matKhauMoiController,
                    isPass: true,
                    textHint: S.current.mat_khau_moi,
                    prefixIcon: SvgPicture.asset(ImageAssets.icLock),
                    onChange: (text) {
                      keytextmatKhauMoi.currentState?.validate();
                    },
                    validate: (value) {
                      return cubit.validateInputText(value!);
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: keytextnhapLaiMatKhau,
                  child: CustomTextField(
                    controller: nhapLaiMatKhauController,
                    isPass: true,
                    textHint: S.current.nhap_lai_mat_khau,
                    prefixIcon: SvgPicture.asset(ImageAssets.icLock),
                    onChange: (text) {
                      keytextnhapLaiMatKhau.currentState?.validate();
                    },
                    validate: (value) {
                      if (value != matKhauMoiController.text &&
                          value!.isNotEmpty) {
                        return S.current.khong_trung_mat_khau_moi;
                      } else {
                        return cubit.validateInputText(value!);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                ButtonCustomBottom(
                  isColorBlue: false,
                  title: S.current.tiep_theo,
                  onPressed: () {
                    keytextmatKhauMoi.currentState?.validate();
                    keytextnhapLaiMatKhau.currentState?.validate();
                    if (matKhauMoiController.value.text.isNotEmpty &&
                        nhapLaiMatKhauController.value.text.isNotEmpty &&
                        matKhauMoiController.value.text ==
                            nhapLaiMatKhauController.value.text) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChangeSuccessPassword(),
                        ),
                        (Route<dynamic> route) => route.isFirst,
                      );
                    }
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
