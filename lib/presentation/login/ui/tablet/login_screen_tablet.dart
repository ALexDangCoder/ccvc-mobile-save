import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_cubit.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_state.dart';
import 'package:ccvc_mobile/presentation/login/ui/login_provider.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/text_error.dart';
import 'package:ccvc_mobile/presentation/reset_password/ui/tablet/fogot_password_screen_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginTabletScreen extends StatefulWidget {
  const LoginTabletScreen({Key? key}) : super(key: key);

  @override
  _LoginTabletScreenState createState() => _LoginTabletScreenState();
}

class _LoginTabletScreenState extends State<LoginTabletScreen> {
  LoginCubit loginCubit = LoginCubit();
  TextEditingController textTaiKhoanController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();
  bool? isAndroid;
  bool? isIOS;

  @override
  void initState() {
    super.initState();
    loginCubit.canCheckIsDevice();
    loginCubit.closeDialog();
    loginCubit.toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    isAndroid = Theme.of(context).platform == TargetPlatform.android;
    return LoginProvider(
      loginCubit: loginCubit,
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: loginCubit.stateStream,
        child: BlocListener<LoginCubit, LoginState>(
          bloc: loginCubit,
          listener: (context, state) async {
            if (state is LoginSuccess) {
              await PrefsService.saveToken(state.token);
              await loginCubit.getPermission();
              AppStateCt.of(context).appState.setToken(state.token);
            }
          },
          child: Scaffold(
            backgroundColor: bgQLVBTablet,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Center(
                child: FormGroup(
                  key: keyGroup,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 590.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Container(
                            height: 350,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  ImageAssets.imgLoginPng,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 510.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    '${S.current.hello} 👋',
                                    style: titleAppbar(fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    S.current.wellcom_login,
                                    style: textNormal(
                                        textBodyTime,
                                        16.0.textScale()),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextFieldValidator(
                              fillColor: backgroundColorApp,
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
                                  child:
                                      SvgPicture.asset(ImageAssets.imgAcount),
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
                                if ((value ?? '').contains('@')) {
                                  if ((value ?? '')
                                      .contains('@', value!.indexOf('@') + 1)) {
                                  } else {
                                    return value.checkEmailBoolean();
                                  }
                                } else {
                                  return (value ?? '')
                                      .checkTruongNull('Tài khoản!');
                                }
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldValidator(
                              maxLength: 32,
                              fillColor: backgroundColorApp,
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
                                              ? SvgPicture.asset(
                                                  ImageAssets.imgViewHide,
                                                )
                                              : SvgPicture.asset(
                                                  ImageAssets.imgView,
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
                                  child:
                                      SvgPicture.asset(ImageAssets.imgPassword),
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
                                return (value ?? '')
                                    .checkTruongNull('Mật khẩu!');
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            StreamBuilder<String>(
                                stream: loginCubit.thongBao,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? '';
                                  if (data.isNotEmpty) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 24.0),
                                      child: WidgetTextError(
                                        text: data,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreenTablet(),
                                  ),
                                );
                              },
                              child: Text(
                                '${S.current.quen_mat_khau}?',
                                style: textNormalCustom(
                                    color: AppTheme.getInstance().colorField()),
                              ),
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            ButtonCustomBottom(
                              title: S.current.login,
                              isColorBlue: true,
                              onPressed: () async {
                                if (keyGroup.currentState!.validator()) {
                                  await loginCubit.loginAndSaveinfo(
                                    passWord:
                                        textPasswordController.text.trim(),
                                    userName:
                                        textTaiKhoanController.text.trim(),
                                    appCode: APP_CODE,
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            if (PrefsService.getLoginUserName() != '')
                              Column(
                                children: [
                                  StreamBuilder<bool>(
                                      stream: loginCubit.canCheckIsDeviceSupportedSubject,
                                    builder: (context, snapshot) {
                                      final data=snapshot.data;
                                      return Visibility(
                                        visible:data??false,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Visibility(
                                              visible: isAndroid ?? true,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    loginCubit.checkBiometrics();
                                                  });
                                                },
                                                child: Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(12.0),
                                                    color: AppTheme.getInstance()
                                                        .colorField()
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      ImageAssets.icFingerprint,
                                                      color: AppTheme.getInstance()
                                                          .colorField(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: isIOS ?? true,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    loginCubit.checkBiometrics();
                                                  });
                                                },
                                                child: Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(12.0),
                                                    color: AppTheme.getInstance()
                                                        .colorField()
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      ImageAssets.icFaceId,
                                                      color: AppTheme.getInstance()
                                                          .colorField(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  ),
                                  const SizedBox(
                                    height: 32.0,
                                  ),
                                ],
                              )
                            else
                              const SizedBox()
                          ],
                        ),
                      ),
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
}
