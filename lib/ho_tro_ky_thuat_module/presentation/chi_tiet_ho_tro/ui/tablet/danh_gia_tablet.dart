import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DanhGiaYeuCauHoTroTabLet extends StatefulWidget {
  const DanhGiaYeuCauHoTroTabLet({Key? key, required this.cubit}) : super(key: key);
  final ChiTietHoTroCubit cubit;

  @override
  _DanhGiaYeuCauHoTroState createState() => _DanhGiaYeuCauHoTroState();
}

class _DanhGiaYeuCauHoTroState extends State<DanhGiaYeuCauHoTroTabLet> {
  String? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 592.w,
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: cellColorborder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          spaceH20,
          Text(
            S.current.danh_gia_yeu_cau_ho_tro,
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          spaceH20,
          textField(
            title: S.current.noi_dung_danh_gia,
            onChange: (value) {
              note = value;
            },
            validate: (value){
              if ((value ?? '').isEmpty) {
                return S.current.khong_duoc_de_trong;
              }
            },
            maxLine: 4,
          ),
          spaceH10,
          Padding(
            padding: EdgeInsets.only(
              left: 119.w,
              right: 119.w,
            ),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.danh_gia,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                widget.cubit.commentTask(note ?? '');
                Navigator.pop(context);
              },
              noPadding: true,
              isTablet: true,
            ),
          ),
          spaceH10,
        ],
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: tokenDetailAmount(
              fontSize: 16,
              color: color3D5586,
            ),
          ),
        ),
        spaceH8,
        TextFieldValidator(
          hintText: hintText,
          onChange: onChange,
          maxLine: maxLine,
          validator: validate,
          textInputType: textInputType,
          onlyTextField: true,
        )
      ],
    );
  }
}
