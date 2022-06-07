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
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ChangePasswordCubit cubit = ChangePasswordCubit();
  TextEditingController emailController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
    cubit.closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: FormGroup(
                  key: keyGroup,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      TextFieldValidator(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(' '),
                          FilteringTextInputFormatter(RegExp(r'[{}]'),allow: false),
                        ],
                        controller: emailController,
                        hintText:
                            '${S.current.email}/${S.current.so_dien_thoai}',
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
                              return '${S.current.sai_dinh_dang_truong} ${S.current.email}/${S.current.so_dien_thoai}!';
                            }
                          } else {
                            return (value ?? '').checkTruongNull(
                              '${S.current.email}/${S.current.so_dien_thoai}!',
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ButtonCustomBottom(
                        isColorBlue: false,
                        title: S.current.tiep_theo,
                        onPressed: () async {
                          if (keyGroup.currentState!.validator()) {
                            await cubit.forgotPassword(
                              email: emailController.text.trim(),
                              context: context,
                            );
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
