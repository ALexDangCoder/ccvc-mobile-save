import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/tablet/send_mail_screen_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassWordScreenTablet extends StatefulWidget {
  const ForgotPassWordScreenTablet({Key? key}) : super(key: key);

  @override
  _ForgotPassWordScreenTabletState createState() =>
      _ForgotPassWordScreenTabletState();
}

class _ForgotPassWordScreenTabletState
    extends State<ForgotPassWordScreenTablet> {
  ForgotPasswordCubit cubit = ForgotPasswordCubit();
  TextEditingController matKhauHienTaiController = TextEditingController();
  TextEditingController matKhauMoiController = TextEditingController();
  TextEditingController nhapLaiMatKhauController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.doi_mat_khau),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 510.0,
            child: FormGroup(
              key: keyGroup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 380.0,
                    child: Center(
                      child: SvgPicture.asset(
                        ImageAssets.icImageChangePasswordTablet,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFieldValidator(
                    fillColor: backgroundColorApp,
                    controller: matKhauHienTaiController,
                    obscureText: cubit.isCheckEye,
                    suffixIcon: cubit.isHideEye
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                            cubit.isCheckEye = !cubit.isCheckEye;
                          },
                          child: cubit.isCheckEye
                              ? SvgPicture.asset(ImageAssets.imgViewHide)
                              : SvgPicture.asset(ImageAssets.imgView),
                        ),
                      ),
                    )
                        : const SizedBox(),
                    hintText: S.current.mat_khau_hien_tai,
                    prefixIcon: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Center(
                        child: SvgPicture.asset(ImageAssets.icShieldDone),
                      ),
                    ),
                    onChange: (text) {
                      if (text.isEmpty) {
                        setState(() {});
                        return cubit.isHideEye = false;
                      }
                      setState(() {});
                      return cubit.isHideEye = true;
                    },
                    validator: (value) {
                      return (value ?? '').checkNull();
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFieldValidator(
                    fillColor: backgroundColorApp,
                    controller: matKhauMoiController,
                    obscureText: cubit.isCheckEye1,
                    suffixIcon: cubit.isHideEye1
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                            cubit.isCheckEye1 = !cubit.isCheckEye1;
                          },
                          child: cubit.isCheckEye1
                              ? SvgPicture.asset(ImageAssets.imgViewHide)
                              : SvgPicture.asset(ImageAssets.imgView),
                        ),
                      ),
                    )
                        : const SizedBox(),
                    hintText: S.current.mat_khau_moi,
                    prefixIcon: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Center(
                        child: SvgPicture.asset(ImageAssets.icLock),
                      ),
                    ),
                    onChange: (text) {
                      if (text.isEmpty) {
                        setState(() {});
                        return cubit.isHideEye1 = false;
                      }
                      setState(() {});
                      return cubit.isHideEye1 = true;
                    },
                    validator: (value) {
                      return (value ?? '').checkNull();
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFieldValidator(
                    fillColor: backgroundColorApp,
                    controller: nhapLaiMatKhauController,
                    obscureText: cubit.isCheckEye2,
                    suffixIcon: cubit.isHideEye2
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                            cubit.isCheckEye2 = !cubit.isCheckEye2;
                          },
                          child: cubit.isCheckEye2
                              ? SvgPicture.asset(ImageAssets.imgViewHide)
                              : SvgPicture.asset(ImageAssets.imgView),
                        ),
                      ),
                    )
                        : const SizedBox(),
                    hintText: S.current.nhap_lai_mat_khau,
                    prefixIcon: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Center(
                        child: SvgPicture.asset(ImageAssets.icLock),
                      ),
                    ),
                    onChange: (text) {
                      if (text.isEmpty) {
                        setState(() {});
                        return cubit.isHideEye2 = false;
                      }
                      setState(() {});
                      return cubit.isHideEye2 = true;
                    },
                    validator: (value) {
                      if (value != matKhauMoiController.value.text &&
                          value!.isNotEmpty) {
                        return S.current.khong_trung_mat_khau_moi;
                      } else {
                        return (value ?? '').checkNull();
                      }
                    },
                  ),
                  const SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SendMailScreenTablet(),
                        ),
                      );
                    },
                    child: Text(
                      '${S.current.quen_mat_khau}?',
                      style: textNormalCustom(
                        color: textDefault,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  DoubleButtonBottom(
                    title1: S.current.cancel,
                    title2: S.current.cap_nhat,
                    onPressed1: () {
                      Navigator.of(context).pop();
                    },
                    onPressed2: () {
                      if (keyGroup.currentState!.validator()) {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
