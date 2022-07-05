import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
    as p;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemMoiYCHoTroMobile extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const ThemMoiYCHoTroMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThemMoiYCHoTroMobile> createState() => _ThemMoiYCHoTroMobileState();
}

class _ThemMoiYCHoTroMobileState extends State<ThemMoiYCHoTroMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH20,
            Center(
              child: Container(
                height: 6,
                width: 48,
                decoration: const BoxDecoration(
                  color: colorECEEF7,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 22.5,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.them_moi_yc_ho_tro,
                    style: p.textNormalCustom(
                      color: textTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  spaceH20,
                  textField(
                    isHightLight: true,
                    title: S.current.ten_thiet_bi,
                    hintText: S.current.ten_thiet_bi,
                    onChange: (value) {},
                  ),
                  spaceH16,
                  textField(
                    isHightLight: true,
                    title: S.current.sdt_lien_he,
                    hintText: S.current.sdt_lien_he,
                    onChange: (value) {},
                  ),
                  spaceH16,
                  textField(
                    isHightLight: true,
                    maxLine: 3,
                    title: S.current.mo_ta_su_co,
                    hintText: S.current.mo_ta_su_co,
                    onChange: (value) {},
                  ),
                  spaceH16,
                  dropDownField(
                    title: S.current.khu_vuc,
                    initData: widget.cubit.listKhuVuc.value.first.name ?? '',
                    listData: widget.cubit.listKhuVuc.value
                        .map((e) => e.name ?? '')
                        .toList(),
                    function: (value) {
                      widget.cubit.listToaNha.add(
                        widget.cubit.listKhuVuc.value[value].childCategories ??
                            [],
                      );
                    },
                  ),
                  spaceH16,
                  StreamBuilder<List<ChildCategories>>(
                    stream: widget.cubit.listToaNha,
                    builder: (context, snapshot) {
                      final List<String> listResult =
                          widget.cubit.getList(snapshot.data ?? []);
                      final String initData = listResult.first;
                      return dropDownField(
                        title: S.current.toa_nha,
                        initData: initData,
                        listData: listResult,
                        function: (value) {},
                      );
                    },
                  ),
                  spaceH16,
                  textField(
                    isHightLight: true,
                    title: S.current.so_phong,
                    hintText: S.current.so_phong,
                    onChange: (value) {},
                  ),
                  spaceH16,
                  dropDownField(
                    title: S.current.khu_vuc,
                    initData: widget.cubit.listKhuVuc.value.first.name ?? '',
                    listData: widget.cubit.listKhuVuc.value
                        .map((e) => e.name ?? '')
                        .toList(),
                    function: (value) {},
                  ),
                  spaceH20,
                  doubleBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textField({
    String? hintText,
    int maxLine = 1,
    required String title,
    required Function(String) onChange,
    String? Function(String?)? validate,
    List<TextInputFormatter>? inputFormatter,
    TextInputType? textInputType,
    bool isHightLight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isHightLight)
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: title,
                  style: tokenDetailAmount(
                    fontSize: 14,
                    color: color3D5586,
                  ),
                ),
                TextSpan(
                  text: ' *',
                  style: tokenDetailAmount(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )
        else
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: title,
                  style: tokenDetailAmount(
                    fontSize: 14,
                    color: color3D5586,
                  ),
                ),
              ],
            ),
          ),
        spaceH8,
        TextFieldValidator(
          hintText: hintText,
          onChange: onChange,
          maxLine: maxLine,
          validator: validate,
          inputFormatters: inputFormatter,
          textInputType: textInputType,
        ),
      ],
    );
  }

  Widget dropDownField({
    String? hintText,
    int maxLine = 1,
    required String initData,
    required List<String> listData,
    required String title,
    required Function(int) function,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: color3D5586,
                ),
              ),
            ],
          ),
        ),
        spaceH8,
        CoolDropDown(
          initData: initData,
          placeHoder: S.current.chon,
          onChange: (value) => function(value),
          listData: listData,
          key: UniqueKey(),
        )
      ],
    );
  }

  Widget doubleBtn() => Padding(
        padding: const EdgeInsets.only(
          left: 21,
          right: 21,
          top: 24,
        ),
        child: DoubleButtonBottom(
          onPressed1: () {},
          title1: S.current.dong,
          title2: S.current.gui_yc,
          onPressed2: () {},
        ),
      );
}
