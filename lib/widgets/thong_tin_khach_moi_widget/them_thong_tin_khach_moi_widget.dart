import 'dart:ui';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemThongTinKhachMoiWidget extends StatefulWidget {
  const ThemThongTinKhachMoiWidget({Key? key}) : super(key: key);

  @override
  _ThemDonViPhoiHopKhacWidgetState createState() =>
      _ThemDonViPhoiHopKhacWidgetState();
}

class _ThemDonViPhoiHopKhacWidgetState
    extends State<ThemThongTinKhachMoiWidget> {
  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showDialog(context);
      },
      text: S.current.them_thong_tin_khach_moi,
      urlIcon: ImageAssets.icAddButtonCalenderTablet,
    );
  }

  void showDialog(BuildContext context) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        child: const ThemThongTinKhachMoiScreen(),
        title: S.current.thong_tin_khach_moi,
      );
    } else {
      showDiaLogTablet(context,
          title: S.current.thong_tin_khach_moi,
          isBottomShow: false,
          child: const ThemThongTinKhachMoiScreen(),
          funcBtnOk: () {});
    }
  }
}

class ThemThongTinKhachMoiScreen extends StatefulWidget {
  const ThemThongTinKhachMoiScreen({Key? key}) : super(key: key);

  @override
  State<ThemThongTinKhachMoiScreen> createState() =>
      _ThemDonViPhoiHopKhacScreenState();
}

class _ThemDonViPhoiHopKhacScreenState
    extends State<ThemThongTinKhachMoiScreen> {
  final _key = GlobalKey<FormState>();
  final _keyFormGroup = GlobalKey<FormGroupState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
          child: DoubleButtonBottom(
            isTablet: isMobile() == false,
            title1: S.current.dong,
            title2: S.current.them,
            onPressed1: () {
              Navigator.pop(context);
            },
            onPressed2: () {
              if (_keyFormGroup.currentState!.validator()) {
                Navigator.pop(context);
              }
            },
          ),
        ),
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
                      InputInfoUserWidget(
                        title: S.current.tong_so_luong_khach,
                        isObligatory: true,
                        child: TextFieldValidator(
                          hintText: S.current.nhap_so_luong,
                          textInputType: TextInputType.number,
                          suffixIcon: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child:
                                  SvgPicture.asset(ImageAssets.icGroupPeople),
                            ),
                          ),
                          validator: (value) {
                            return (value ?? '').checkInt();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
