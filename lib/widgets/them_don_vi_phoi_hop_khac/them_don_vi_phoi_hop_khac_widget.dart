import 'dart:ui';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemDonViPhoiHopKhacWidget extends StatefulWidget {
  const ThemDonViPhoiHopKhacWidget({Key? key}) : super(key: key);

  @override
  _ThemDonViPhoiHopKhacWidgetState createState() =>
      _ThemDonViPhoiHopKhacWidgetState();
}

class _ThemDonViPhoiHopKhacWidgetState
    extends State<ThemDonViPhoiHopKhacWidget> {
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showBottomSheetCustom(
          context,
          child: const ThemDonViPhoiHopKhacScreen(),
          title: S.current.don_vi_phoi_hop_khac,
        );
      },
      text: S.current.them_thanh_phan_tham_gia,
      urlIcon: ImageAssets.icAddButtonCalenderTablet,
    );
  }
}

class ThemDonViPhoiHopKhacScreen extends StatefulWidget {
  const ThemDonViPhoiHopKhacScreen({Key? key}) : super(key: key);

  @override
  State<ThemDonViPhoiHopKhacScreen> createState() =>
      _ThemDonViPhoiHopKhacScreenState();
}

class _ThemDonViPhoiHopKhacScreenState
    extends State<ThemDonViPhoiHopKhacScreen> {
  final _key = GlobalKey<FormState>();
  final _keyFormGroup = GlobalKey<FormGroupState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              reverse: true,
              child: FormGroup(
                key: _keyFormGroup,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputInfoUserWidget(
                      title: S.current.ten_don_vi,
                      child: TextFieldValidator(
                        hintText: S.current.ten_don_vi,
                        validator: (value) {
                          return (value ?? '').checkNull();
                        },
                      ),
                    ),
                    InputInfoUserWidget(
                      title: S.current.dau_moi_lam_viec,
                      child: TextFieldValidator(
                        hintText: S.current.dau_moi_lam_viec,
                      ),
                    ),
                    spaceH20,
                    BlockTextView(
                      formKey: _key,
                      title: S.current.noi_dung_lam_viec,
                      isRequired: false,
                      contentController: TextEditingController(),
                    ),
                    InputInfoUserWidget(
                      title: S.current.email,
                      child: TextFieldValidator(
                        hintText: S.current.email,
                        suffixIcon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                              child: SvgPicture.asset(ImageAssets.ic_email)),
                        ),
                        validator: (value) {
                          return (value ?? '').checkEmail();
                        },
                      ),
                    ),
                    InputInfoUserWidget(
                      title: S.current.so_dien_thoai,
                      child: TextFieldValidator(
                        hintText: S.current.so_dien_thoai,
                        suffixIcon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                              child: SvgPicture.asset(ImageAssets.icPhone)),
                        ),
                        validator: (value) {
                          return (value ?? '').checkSdt();
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.keyBoardHeight.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: SizeConfig.keyBoardHeight.bottom <= kHeightKeyBoard,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: DoubleButtonBottom(
                title1: S.current.dong,
                title2: S.current.them,
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  if (_keyFormGroup.currentState!.validator()) {}
                },
              ),
            ),
          )
        ],
      ),
    );
  }

//  void listenKeyBoard() {
//    EdgeInsets _viewInsets = EdgeInsets.zero;
//    if (mounted) {
//      final window = this.window;
//      if (window != null) {
//        _viewInsets = EdgeInsets.fromWindowPadding(
//          window.viewInsets,
//          window.devicePixelRatio,
//        ).add(
//          EdgeInsets.fromWindowPadding(
//            window.padding,
//            window.devicePixelRatio,
//          ),
//        ) as EdgeInsets;
//      }
//      if (_viewInsets.bottom != 0) {
//        insertPadding = _viewInsets.bottom;
//      } else {
//        insertPadding = 0;
//      }
//      setState(() {});
//    }
//  }
}
