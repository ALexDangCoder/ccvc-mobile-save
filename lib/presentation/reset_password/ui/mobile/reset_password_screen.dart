import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/mobile/create_new_password.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
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
                const SizedBox(height: 30.0),
                Text(
                  S.current.nhap_ma_xac_minh,
                  style: textNormalCustom(color: titleColor, fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  S.current.ma_xac_minh_cua_ban,
                  style: textNormalCustom(
                    color: titleColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'hungto228@gmail.com',
                  style: textNormalCustom(color: textDefault),
                ),
                const SizedBox(height: 80.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: PinCodeTextField(
                    length: 6,
                    cursorColor: colorBlack,
                    //mau nut nhay
                    backgroundColor: backgroundColorApp,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 50,
                      fieldWidth: 32,
                      inactiveColor: unselectLabelColor,
                      //gach chan khi khong duoc chon
                      activeFillColor: backgroundColorApp,
                      //mau khi da dien so
                      activeColor: unselectLabelColor,
                      //gach chan
                      selectedColor: unselectLabelColor,
                      // gach chan khi duoc chon
                      selectedFillColor: backgroundColorApp,
                      //chon mau khi duoc chon
                      errorBorderColor: errorBorderColor,
                      disabledColor: unselectLabelColor,
                      inactiveFillColor: backgroundColorApp
                      //mau khi khong chon mac dinh mau vang
                      ,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    //  errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      setState(() {});
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                ),
                const SizedBox(height: 80.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.ban_khong_nhan_duoc_ma,
                      style: textNormalCustom(
                        color: titleColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        S.current.gui_lai,
                        style: textNormalCustom(color: textDefault),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                ButtonCustomBottom(
                  isColorBlue: false,
                  title: S.current.xac_nhan,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateNewPassWordScreen(),
                      ),
                    );
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
