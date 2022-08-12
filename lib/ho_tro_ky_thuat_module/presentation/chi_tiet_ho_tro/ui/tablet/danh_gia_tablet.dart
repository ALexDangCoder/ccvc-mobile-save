import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dialog/show_toat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DanhGiaYeuCauHoTroTabLet extends StatefulWidget {
  const DanhGiaYeuCauHoTroTabLet({Key? key, required this.cubit, this.idTask})
      : super(key: key);
  final ChiTietHoTroCubit cubit;
  final String? idTask;

  @override
  _DanhGiaYeuCauHoTroState createState() => _DanhGiaYeuCauHoTroState();
}

class _DanhGiaYeuCauHoTroState extends State<DanhGiaYeuCauHoTroTabLet> {
  String? note;
  final _groupKey = GlobalKey<FormGroupState>();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.danh_gia_yeu_cau_ho_tro,
                style: textNormalCustom(
                  color: color3D5586,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 24.sp,
                  color: colorA2AEBD,
                ),
              ),
            ],
          ),
          spaceH20,
          FormGroup(
            key: _groupKey,
            child: textField(
              hintText: S.current.nhap_noi_dung,
              title: S.current.noi_dung_danh_gia,
              onChange: (value) {
                note = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} '
                      '${S.current.noi_dung_danh_gia}!';
                }
              },
              maxLine: 5,
            ),
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
                if (_groupKey.currentState?.validator() ?? false) {
                  widget.cubit.commentTask(
                    note ?? '',
                    id: widget.idTask,
                  ).then(
                        (value) {
                      if (value == successCode) {
                        final FToast toast = FToast();
                        toast.init(context);
                        toast.showToast(
                          child: ShowToast(
                            text: S.current.luu_du_lieu_thanh_cong,
                            icon: ImageAssets.icSucces,
                          ),
                          gravity: ToastGravity.BOTTOM,
                        );
                        if (widget.idTask?.isEmpty ?? true) {
                          widget.cubit.getSupportDetail(
                            widget.cubit.supportDetail.id ?? '',
                          );
                        }
                        Navigator.pop(context);
                      } else {
                        final FToast toast = FToast();
                        toast.init(context);
                        toast.showToast(
                          child: ShowToast(
                            text: S.current.thay_doi_that_bai,
                            icon: ImageAssets.icError,
                          ),
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                  );
                }
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
