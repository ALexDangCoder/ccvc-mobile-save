import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_textfield.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit loginCubit = LoginCubit();
  TextEditingController textTaiKhoanController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 84,
            horizontal: 16,
          ),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color:Colors.red,
                  height: 250,
                  // child: SvgPicture.network(
                  //   'https://ccvc-uat.chinhquyendientu.vn/img/login-v2.72cd8a26.svg',
                  // ),
                ),
                 const SizedBox(height: 32,),
                 Center(child: Column(
                   children: [
                     Text('${S.current.hello} 👋',style: titleAppbar(),),
                     const SizedBox(height: 12,),
                     Text('${S.current.wellcom_login}',style: textNormal(AqiColor,14),)
                   ],
                 ),),
                 const SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  isPass: false,
                  textHint: S.current.account,
                  loginCubit: loginCubit,
                  prefixIcon:  SvgPicture.asset(ImageAssets.imgAcount),
                  onChange: (text) {
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  isPass: true,
                  textHint:S.current.password,
                  loginCubit: loginCubit,
                  prefixIcon: SvgPicture.asset(ImageAssets.imgPassword),
                  onChange: (text) {
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<bool>(
                  stream: loginCubit.savePassword,
                  builder: (context, snapshot) {
                    final isSave = snapshot.data ?? false;
                    return CustomCheckBox(
                      title: S.current.save_password,
                      isCheck: isSave,
                      onChange: (data) {
                        loginCubit.setSavePassword(isSave: !data);
                      },
                    );
                  },
                ),
                ButtonCustomBottom(title:S.current.login, isColorBlue: true,onPressed: (){
                  key.currentState?.validate();
                },)
                // GestureDetector(
                //   onTap: () {
                //     key.currentState?.validate();
                //   },
                //   child: Container(
                //     height: 30,
                //     width: 100,
                //     color: Colors.red,
                //   ),
                // )
              ],
            ),
          ),
        ),
      )
    );
  }
}
