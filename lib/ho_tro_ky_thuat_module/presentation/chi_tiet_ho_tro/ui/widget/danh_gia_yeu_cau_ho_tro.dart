import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DanhGiaYeuCauHoTro extends StatefulWidget {
  const DanhGiaYeuCauHoTro({Key? key, required this.cubit}) : super(key: key);
  final ChiTietHoTroCubit cubit;

  @override
  _DanhGiaYeuCauHoTroState createState() => _DanhGiaYeuCauHoTroState();
}

class _DanhGiaYeuCauHoTroState extends State<DanhGiaYeuCauHoTro> {
  String? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                spaceH20,
                Center(
                  child: Container(
                    height: 6.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      color: colorECEEF7,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                  ),
                ),
                spaceH20,
                Text(
                  S.current.danh_gia_yeu_cau_ho_tro,
                  style: textNormalCustom(
                    color: color3D5586,
                    fontSize: 16,
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
                spaceH16,
                DoubleButtonBottom(
                  title1: S.current.dong,
                  title2: S.current.danh_gia,
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onPressed2: () {
                    widget.cubit.commentTask(note ?? '');
                  },
                  noPadding: true,
                ),
              ],
            ),
          ),
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
              fontSize: 14,
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
        )
      ],
    );
  }
}
