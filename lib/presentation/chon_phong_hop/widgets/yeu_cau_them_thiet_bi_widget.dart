import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/bloc/chon_phong_hoc_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YeuCauThemThietBiWidget extends StatefulWidget {
  final ChonPhongHopCubit chonPhongHopCubit;
  final Function() onClose;

  const YeuCauThemThietBiWidget({
    Key? key,
    required this.chonPhongHopCubit,
    required this.onClose,
  }) : super(key: key);

  @override
  State<YeuCauThemThietBiWidget> createState() =>
      _YeuCauThemThietBiWidgetState();
}

class _YeuCauThemThietBiWidgetState extends State<YeuCauThemThietBiWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SolidButton(
          onTap: () {
            showSelect();
          },
          text: S.current.yeu_cau_them_thiet_bi,
          urlIcon: ImageAssets.icChonPhongHop,
        ),
        StreamBuilder<List<ThietBiValue>>(
          stream: widget.chonPhongHopCubit.listThietBiStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <ThietBiValue>[];
            if (data.isNotEmpty) {
              return Column(
                children: List.generate(
                  data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: thietBiWidget(
                      value: data[index],
                      onDelete: () {
                        widget.chonPhongHopCubit.removeThietBi(data[index]);
                      },
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }

  void showSelect() {
    if (isMobile()) {
      showBottomSheetCustom<ThietBiValue>(
        context,
        title: S.current.them_thiet_bi_trong_phong,
        child: const ThemThietBiScreen(),
      ).then((value) {
        if (value != null) {
          widget.chonPhongHopCubit.addThietBi(value);
        }
        widget.onClose();
      });
    } else {
      showDiaLogTablet<ThietBiValue>(
        context,
        title: S.current.them_thiet_bi_trong_phong,
        child: const ThemThietBiScreen(),
        funcBtnOk: () {},
        isBottomShow: false,
      ).then((value) {
        if (value != null) {
          widget.chonPhongHopCubit.addThietBi(value);
        }
        widget.onClose();
      });
    }
  }
}

Widget thietBiWidget({
  required ThietBiValue value,
  required Function() onDelete,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: containerColorTab.withOpacity(0.1),
      border: Border.all(color: borderItemCalender),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowInfo(
                key: S.current.ten_thiet_bi,
                value: value.tenThietBi,
              ),
              spaceH10,
              rowInfo(
                key: S.current.so_luong,
                value: value.soLuong < 10
                    ? '0${value.soLuong}'
                    : value.soLuong.toString(),
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () {
              onDelete();
            },
            child: SvgPicture.asset(ImageAssets.icDeleteRed),
          ),
        )
      ],
    ),
  );
}

class ThemThietBiScreen extends StatefulWidget {
  const ThemThietBiScreen({Key? key}) : super(key: key);

  @override
  State<ThemThietBiScreen> createState() => _ThemThietBiScreenState();
}

class _ThemThietBiScreenState extends State<ThemThietBiScreen> {
  TextEditingController tenThietBi = TextEditingController();
  TextEditingController soLuong = TextEditingController();
  final _key = GlobalKey<FormGroupState>();
  EdgeInsets _viewInsert = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _viewInsert = mediaQuery.viewPadding.copyWith(
      bottom: mediaQuery.viewInsets.bottom,
    );
    return FormGroup(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _viewInsert.bottom),
            child: Column(
              children: [
                InputInfoUserWidget(
                  title: S.current.ten_thiet_bi,
                  isObligatory: true,
                  child: TextFieldValidator(
                    hintText: S.current.nhap_ten_thiet_bi,
                    controller: tenThietBi,
                    validator: (value) {
                      return (value ?? '').pleaseEnter(
                        S.current.ten_thiet_bi.toLowerCase(),
                      );
                    },
                  ),
                ),
                InputInfoUserWidget(
                  title: S.current.so_luong,
                  isObligatory: true,
                  child: TextFieldValidator(
                    textInputType: TextInputType.number,
                    controller: soLuong,
                    hintText: S.current.nhap_so_luong,
                    maxLength: 9,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      final result =
                          (value ?? '').pleaseEnter(S.current.so_luong.toLowerCase());
                      if (result != null) {
                        return result;
                      }
                      try {
                        int.parse(value ?? '');
                      } catch (e) {
                        return S.current.check_so_luong;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _viewInsert.bottom <= kHeightKeyBoard,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
              child: DoubleButtonBottom(
                isTablet: isMobile() == false,
                title1: S.current.dong,
                title2: S.current.xac_nhan,
                onClickLeft: () {
                  Navigator.pop(context);
                },
                onClickRight: () {
                  if (_key.currentState!.validator()) {
                    Navigator.pop(
                      context,
                      ThietBiValue(
                        tenThietBi: tenThietBi.text.trim(),
                        soLuong: int.parse(soLuong.text),
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
