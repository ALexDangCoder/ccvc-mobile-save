import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_cubit.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_state.dart';
import 'package:ccvc_mobile/presentation/login/ui/login_provider.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/mobile/send_mail_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
    loginCubit.closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return LoginProvider(
      loginCubit: loginCubit,
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('1', ''),
        stream: loginCubit.stateStream,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocListener<LoginCubit, LoginState>(
            bloc: loginCubit,
            listener: (context, state) {
              if (state is LoginSuccess) {
                AppStateCt.of(context).appState.setToken(state.token);
              }
            },
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 60, left: 16.0, right: 16.0),
                child: FormGroup(
                  key: keyGroup,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              ImageAssets.imgLoginPng,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              '${S.current.hello}!',
                              style: titleAppbar(),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              S.current.wellcom_login,
                              style: textNormal(AqiColor, 14),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldValidator(
                        controller: textTaiKhoanController,
                        suffixIcon: loginCubit.isHideClearData
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      textTaiKhoanController.clear();
                                      loginCubit.isHideClearData = false;
                                    },
                                    child: SvgPicture.asset(
                                      ImageAssets.icClearLogin,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        hintText: S.current.account,
                        prefixIcon: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: Center(
                            child: SvgPicture.asset(ImageAssets.imgAcount),
                          ),
                        ),
                        onChange: (text) {
                          if (text.isEmpty) {
                            setState(() {});
                            return loginCubit.isHideClearData = false;
                          }
                          setState(() {});
                          return loginCubit.isHideClearData = true;
                        },
                        validator: (value) {
                          return (value ?? '').checkNull();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldValidator(
                        controller: textPasswordController,
                        obscureText: loginCubit.isCheckEye1,
                        suffixIcon: loginCubit.isHideEye1
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      loginCubit.isCheckEye1 =
                                          !loginCubit.isCheckEye1;
                                    },
                                    child: loginCubit.isCheckEye1
                                        ? SvgPicture.asset(ImageAssets.imgView)
                                        : SvgPicture.asset(
                                            ImageAssets.imgViewHide,
                                          ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        hintText: S.current.password,
                        prefixIcon: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: Center(
                            child: SvgPicture.asset(ImageAssets.imgPassword),
                          ),
                        ),
                        onChange: (text) {
                          if (text.isEmpty) {
                            setState(() {});
                            return loginCubit.isHideEye1 = false;
                          }
                          setState(() {});
                          return loginCubit.isHideEye1 = true;
                        },
                        validator: (value) {
                          return (value ?? '').checkNull();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SendMailScreen(),
                            ),
                          );
                        },
                        child: Text(
                          '${S.current.quen_mat_khau}?',
                          style: textNormalCustom(color: textDefault),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        bloc: loginCubit,
                        builder: (context, state) {
                          return ButtonCustomBottom(
                            title: S.current.login,
                            isColorBlue: true,
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const DetailMeetCalenderScreen(id: '',)),
                              );
                              // if (keyGroup.currentState!.validator()) {
                              //   await loginCubit.loginAndSaveinfo(
                              //     context: context,
                              //     passWord: textPasswordController.text,
                              //     userName: textTaiKhoanController.text,
                              //     appCode: APP_CODE,
                              //   );
                              // } else {}
                              //
                              // if (loginCubit.passIsError == true) {
                              //   _showToast(context);
                              // }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: buttonColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child:
                                    SvgPicture.asset(ImageAssets.icFingerprint),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: buttonColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(ImageAssets.icFaceId),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(S.current.dang_nhap_that_bai),
      ),
    );
  }
}
