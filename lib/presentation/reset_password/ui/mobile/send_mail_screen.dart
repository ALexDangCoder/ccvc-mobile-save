import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/change_password/bloc/change_password_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendMailScreen extends StatefulWidget {
  const SendMailScreen({Key? key}) : super(key: key);

  @override
  _SendMailScreenState createState() => _SendMailScreenState();
}

class _SendMailScreenState extends State<SendMailScreen> {
  ChangePasswordCubit cubit = ChangePasswordCubit();
  TextEditingController emailController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.doi_lai_mat_khau),
      body: SingleChildScrollView(
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
                    controller: emailController,
                    hintText: '${S.current.email}/${S.current.so_dien_thoai}',
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
                  const SizedBox(height: 20.0),
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
