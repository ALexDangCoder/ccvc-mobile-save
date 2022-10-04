import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/change_password/bloc/change_password_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/text_error.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../main.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({Key? key}) : super(key: key);

  @override
  _ChangePassWordScreenState createState() => _ChangePassWordScreenState();
}

class _ChangePassWordScreenState extends State<ChangePassWordScreen> {
  ChangePasswordCubit cubit = ChangePasswordCubit();
  TextEditingController matKhauHienTaiController = TextEditingController();
  TextEditingController matKhauMoiController = TextEditingController();
  TextEditingController nhapLaiMatKhauController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
    cubit.closeDialog();
    cubit.toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.doi_mat_khau),
      body: ProviderWidget<ChangePasswordCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: FormGroup(
                  key: keyGroup,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child:
                            SvgPicture.asset(ImageAssets.icImageChangePassword),
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldValidator(
                          maxLength: 32,
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
                                          ? SvgPicture.asset(
                                              ImageAssets.imgView)
                                          : SvgPicture.asset(
                                              ImageAssets.imgViewHide),
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
                            return (value ?? '')
                                .checkTruongNull('Mật khẩu hiện tại!');
                          }),
                      const SizedBox(height: 16.0),
                      StreamBuilder<String>(
                          stream: cubit.thongBao,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? '';
                            if (data.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: WidgetTextError(
                                  text: data,
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                      TextFieldValidator(
                        maxLength: 32,
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
                                        ? SvgPicture.asset(ImageAssets.imgView)
                                        : SvgPicture.asset(
                                            ImageAssets.imgViewHide),
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
                          if ((value ?? '').isEmpty) {
                            return (value ?? '')
                                .checkTruongNull('Mật khẩu mới!');
                          } else if (value ==
                                  matKhauHienTaiController.value.text &&
                              value!.isNotEmpty) {
                            return S.current.khong_trung_mat_khau_moi;
                          } else {
                            return (value ?? '')
                                .checkPassWordChangePass('Mật khẩu mới!');
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFieldValidator(
                        maxLength: 32,
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
                                        ? SvgPicture.asset(ImageAssets.imgView)
                                        : SvgPicture.asset(
                                            ImageAssets.imgViewHide),
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
                            return S.current.mat_khau_chua_khop;
                          } else {
                            return (value ?? '')
                                .checkTruongNull('Nhập lại mật khẩu mới!');
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      DoubleButtonBottom(
                        title1: S.current.cancel,
                        title2: S.current.cap_nhat,
                        onClickLeft: () {
                          Navigator.of(context).pop();
                        },
                        onClickRight: () async {
                          if (keyGroup.currentState!.validator()) {
                            await cubit
                                .changePassWord(
                              password: matKhauMoiController.text.trim(),
                              passwordOld: matKhauHienTaiController.text.trim(),
                              repeatPassword:
                                  nhapLaiMatKhauController.text.trim(),
                              context: context,
                            )
                                .then((value) {
                              if (cubit.isSuccess == true) {
                                PrefsService.saveOpenFaceId('');
                                MessageConfig.show(
                                  messState: MessState.customIcon,
                                  title: S.current.cap_nhat_mk_thanh_cong,
                                  urlIcon: ImageAssets.image_lock_reset,
                                );
                                Navigator.pop(context);
                                AppStateCt.of(context).appState.setToken('');
                                HiveLocal.clearData();
                              }
                            });
                          }
                        },
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
