import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_textfield.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/tablet/reset_password_screen_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendMailScreenTablet extends StatefulWidget {
  const SendMailScreenTablet({Key? key}) : super(key: key);

  @override
  _SendMailScreenTabletState createState() => _SendMailScreenTabletState();
}

class _SendMailScreenTabletState extends State<SendMailScreenTablet> {
  @override
  Widget build(BuildContext context) {
    final ForgotPasswordCubit cubit = ForgotPasswordCubit();
    final TextEditingController emailController = TextEditingController();
    final keyGroup = GlobalKey<FormGroupState>();

    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.dat_lai_mat_khau),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 510.0,
            child: FormGroup(
              key: keyGroup,
              child: Column(
                children: [
                  const SizedBox(height: 80.0),
                  Text(
                    S.current.nhan_ma_xac_minh,
                    style: textNormalCustom(color: titleColor, fontSize: 20.0),
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    S.current.de_nhan_ma_xac_minh,
                    style: textNormalCustom(
                      fontSize: 16.0,
                      color: titleColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextFieldValidator(
                    fillColor: backgroundColorApp,
                    controller: emailController,
                    hintText: S.current.email,
                    prefixIcon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: SvgPicture.asset(ImageAssets.ic_email),),
                    ),
                    validator: (value) {
                      return (value ?? '').checkEmail();
                    },
                  ),
                  const SizedBox(height: 36.0),
                  ButtonCustomBottom(
                    isColorBlue: false,
                    title: S.current.tiep_theo,
                    onPressed: () {
                      if (keyGroup.currentState!.validator()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
