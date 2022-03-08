import 'dart:io';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/material.dart';

import 'chon_ngay_widget.dart';

class VBGiaoNhiemVu extends StatelessWidget {
  final TextEditingController soKyHieuController;
  final TextEditingController trichYeuController;
  final Function(String value) onChangeSoKyHieu;
  final Function(String value) onChangeTrichYeu;
  final Function(DateTime value) onChangeDateTime;

  const VBGiaoNhiemVu(
      {Key? key,
        required this.soKyHieuController,
        required this.trichYeuController,
        required this.onChangeSoKyHieu,
        required this.onChangeTrichYeu,
        required this.onChangeDateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb20(),
        ItemTextFieldWidget(
          title: S.current.so_ky_hieu,
          hint: S.current.so_ky_hieu,
          controller: soKyHieuController,
          onChange: (value) {
            onChangeSoKyHieu(value);
          },
          validator: (value) {},
        ),
        sb20(),
        PickDateWidget(
          title: S.current.ngay_van_ban,
          onChange: (value) {
            onChangeDateTime(value);
          },
        ),
        sb20(),
        ItemTextFieldWidget(
          title: S.current.trich_yeu,
          hint: S.current.trich_yeu,
          controller: trichYeuController,
          onChange: (value) {
            onChangeTrichYeu(value);
          },
          validator: (value) {},
        ),
        sb20(),
        ButtonSelectFile(
          title: S.current.tai_lieu_dinh_kem,
          onChange: (List<File> files) {
            print(files);
          },
          files: [],
        ),

        Row(
          children: [
            Expanded(
              child: btnSuaLich(
                name: S.current.dong,
                bgr: buttonColor.withOpacity(0.1),
                colorName: textDefault,
                onTap: () {},
              ),
            ),
            SizedBox(
              width: 16.0.textScale(),
            ),
            Expanded(
              child: btnSuaLich(
                name: S.current.luu,
                bgr: labelColor,
                colorName: Colors.white,
                onTap: () {
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 20.0.textScale(),)
      ],
    );
  }

  Widget sb20() {
    return SizedBox(
      height: 20.0.textScale(),
    );
  }

  Widget btnSuaLich({
    required String name,
    required Color bgr,
    required Color colorName,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgr,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          name,
          style: textNormalCustom(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorName,
          ),
        ),
      ),
    );
  }
}
