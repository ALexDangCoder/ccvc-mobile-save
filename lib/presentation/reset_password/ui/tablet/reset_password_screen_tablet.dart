import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/tablet/create_new_password_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordScreenTablet extends StatefulWidget {
  const ResetPasswordScreenTablet({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreenTablet> createState() =>
      _ResetPasswordScreenTabletState();
}

class _ResetPasswordScreenTabletState extends State<ResetPasswordScreenTablet> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.doi_lai_mat_khau),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 510.0,
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                Text(
                  S.current.nhap_ma_xac_minh,
                  style: textNormalCustom(color: color3D5586, fontSize: 20.0),
                ),
                const SizedBox(height: 28.0),
                Row(
                  children: [
                    Text(
                      '${S.current.ma_xac_minh_cua_ban}: ',
                      style: textNormalCustom(
                        fontSize: 16.0,
                        color: color3D5586,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'tovanhungto228@gmaild.com',
                        overflow: TextOverflow.ellipsis,
                        style: textNormalCustom(color: textDefault),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: PinCodeTextField(
                    length: 6,
                    cursorColor: colorBlack,
                    //mau nut nhay
                    backgroundColor: backgroundColorApp,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 66,
                      fieldWidth: 48,
                      inactiveColor: colorA2AEBD,
                      //gach chan khi khong duoc chon
                      activeFillColor: backgroundColorApp,
                      //mau khi da dien so
                      activeColor: colorA2AEBD,
                      //gach chan
                      selectedColor: colorA2AEBD,
                      // gach chan khi duoc chon
                      selectedFillColor: backgroundColorApp,
                      //chon mau khi duoc chon
                      errorBorderColor: errorBorderColor,
                      disabledColor: colorA2AEBD,
                      inactiveFillColor: backgroundColorApp,
                      //mau khi khong chon mac dinh mau vang
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,

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
                const SizedBox(height: 200.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.ban_khong_nhan_duoc_ma,
                      style: textNormalCustom(
                        fontSize: 16.0,
                        color: color3D5586,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        S.current.gui_lai,
                        style: textNormalCustom(
                          color: textDefault,
                          fontSize: 16.0,
                        ),
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
                        builder: (context) => const CreateNewPassWordTablet(),
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
