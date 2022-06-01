import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/change_password/bloc/change_password_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreenTablet extends StatefulWidget {
  const ForgotPasswordScreenTablet({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenTabletState createState() =>
      _ForgotPasswordScreenTabletState();
}

class _ForgotPasswordScreenTabletState
    extends State<ForgotPasswordScreenTablet> {
  final ChangePasswordCubit cubit = ChangePasswordCubit();
  final TextEditingController emailController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
    cubit.closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.doi_lai_mat_khau),
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
                        style: textNormalCustom(
                            color: color3D5586, fontSize: 20.0),
                      ),
                      const SizedBox(height: 40.0),
                      Text(
                        S.current.de_nhan_ma_xac_minh,
                        style: textNormalCustom(
                          fontSize: 16.0,
                          color: color3D5586,
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
                            child: SvgPicture.asset(ImageAssets.ic_email),
                          ),
                        ),
                        validator: (value) {
                          final isCheckSdt =
                              (value ?? '').checkSdtDinhDangTruong() ?? false;
                          final isCheckEmail =
                              (value ?? '').checkEmailBooleanDinhDangTruong() ??
                                  false;
                          if ((value ?? '').isNotEmpty) {
                            if (isCheckSdt || isCheckEmail) {
                            } else {
                              return '${S.current.sai_dinh_dang_truong} ${S.current.email}/${S.current.so_dien_thoai}';
                            }
                          } else {
                            return (value ?? '').checkTruongNull(
                                '${S.current.email}/${S.current.so_dien_thoai}');
                          }
                        },
                      ),
                      const SizedBox(height: 36.0),
                      ButtonCustomBottom(
                        isColorBlue: false,
                        title: S.current.tiep_theo,
                        onPressed: () async {
                          if (keyGroup.currentState!.validator()) {
                            await cubit.forgotPassword(
                                email: emailController.text.trim(),
                                context: context);
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