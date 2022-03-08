import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/vb_giao_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chon_ngay_widget.dart';
import 'dropdown_widget.dart';

class TaoMoiNhiemVuWidget extends StatefulWidget {
  const TaoMoiNhiemVuWidget({Key? key}) : super(key: key);

  @override
  State<TaoMoiNhiemVuWidget> createState() => _TaoMoiNhiemVuWidgetState();
}

class _TaoMoiNhiemVuWidgetState extends State<TaoMoiNhiemVuWidget> {
  final TextEditingController dvTheoDoiController = TextEditingController();
  final TextEditingController ngTheoDoiController = TextEditingController();
  final TextEditingController ndTheoDoiController = TextEditingController();
  final TextEditingController soKyHieuController = TextEditingController();
  final TextEditingController trichYeuController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: MediaQuery.of(context).size.height * 0.96,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: FormGroup(
        key: keyGroup,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 6,
                        width: 57,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Text(
                      S.current.tao_moi_nhiem_vu,
                      style: textNormalCustom(
                        color: titleColor,
                        fontSize: 18.0.textScale(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sb20(),
                    DropDownWidget(
                      isNote: true,
                      title: S.current.loai_nhiem_vu,
                      hint: S.current.loai_nhiem_vu,
                      listData: [
                        S.current.nhiem_vu_ubnd,
                        S.current.nhiem_vu_cpvpcp,
                        S.current.nhiem_vu_dv,
                      ],
                      onChange: (value) {},
                    ),
                    sb20(),
                    ItemTextFieldWidget(
                      hint: S.current.don_vi_theo_doi,
                      title: S.current.don_vi_theo_doi,
                      controller: dvTheoDoiController,
                      validator: (String? value) {},
                      onChange: (String value) {},
                    ),
                    sb20(),
                    ItemTextFieldWidget(
                      hint: S.current.nguoi_theo_doi,
                      title: S.current.nguoi_theo_doi,
                      controller: ngTheoDoiController,
                      validator: (String? value) {},
                      onChange: (String value) {},
                    ),
                    sb20(),
                    ItemTextFieldWidget(
                      hint: '',
                      title: S.current.noi_dung_theo_doi,
                      controller: ndTheoDoiController,
                      isNote: true,
                      maxLine: 8,
                      validator: (String? value) {
                        return value?.checkNull();
                      },
                      onChange: (String value) {},
                    ),
                    sb20(),
                    PickDateWidget(
                      title: S.current.han_xu_ly,
                      minimumDate: DateTime.now(),
                      onChange: (DateTime value) {},
                    ),
                    sb20(),
                    DropDownWidget(
                      title: S.current.nguoi_giao_nhiem_vu,
                      hint: S.current.nguoi_giao_nhiem_vu,
                      listData: [''],
                      onChange: (value) {},
                    ),
                    sb20(),
                    btnWidget(
                      name: S.current.van_ban_giao_nhiem_vu,
                      onTap: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.van_ban_giao_nhiem_vu,
                          child: Container(
                            child: VBGiaoNhiemVu(
                              soKyHieuController: soKyHieuController,
                              onChangeSoKyHieu: (String value) {},
                              onChangeDateTime: (DateTime value) {},
                              trichYeuController: trichYeuController,
                              onChangeTrichYeu: (String value) {},
                            ),
                          ),
                        );
                      },
                    ),
                    sb20(),
                    btnWidget(
                      name: S.current.van_ban_khac,
                      onTap: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.van_ban_khac,
                          child: Container(
                            child: VBGiaoNhiemVu(
                              soKyHieuController: soKyHieuController,
                              onChangeSoKyHieu: (String value) {},
                              onChangeDateTime: (DateTime value) {},
                              trichYeuController: trichYeuController,
                              onChangeTrichYeu: (String value) {},
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            sb20(),
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
                    name: S.current.xac_nhan,
                    bgr: labelColor,
                    colorName: Colors.white,
                    onTap: () {
                      keyGroup.currentState!.validator();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sb20() {
    return SizedBox(
      height: 20.0.textScale(),
    );
  }
}

Widget btnWidget({required String name, required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.0.textScale(),
        vertical: 8.0.textScale(),
      ),
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(ImageAssets.icDocument2),
          SizedBox(
            width: 9.0.textScale(),
          ),
          Text(
            name,
            style: textNormalCustom(
              color: buttonColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.0.textScale(),
            ),
          ),
        ],
      ),
    ),
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
