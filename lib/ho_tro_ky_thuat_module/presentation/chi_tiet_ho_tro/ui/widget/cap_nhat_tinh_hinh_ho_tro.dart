import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CapNhatTinhHinhHoTro extends StatefulWidget {
  const CapNhatTinhHinhHoTro({Key? key, required this.cubit}) : super(key: key);
  final ChiTietHoTroCubit cubit;

  @override
  _CapNhatTinhHinhHoTroState createState() => _CapNhatTinhHinhHoTroState();
}

class _CapNhatTinhHinhHoTroState extends State<CapNhatTinhHinhHoTro> {
  String? note;
  String? birthday;
  String? trangThai;
  String? nguoiXuLy;

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
                  S.current.cap_nhat_tinh_hinh_ho_tro,
                  style: textNormalCustom(
                    color: color3D5586,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 500.h,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH20,
                        title(S.current.ket_qua_xu_ly),
                        spaceH16,
                        dropDownField(
                          title: S.current.trang_thai_xu_ly,
                          listDropdown: widget.cubit.listTrangThai,
                        ),
                        spaceH16,
                        textField(
                          title: S.current.ket_qua_xu_ly,
                          onChange: (value) {
                            note = value;
                          },
                          maxLine: 4,
                        ),
                        spaceH16,
                        dropDownField(
                          title: S.current.nguoi_xu_ly,
                          listDropdown: widget.cubit.listItSupport,
                        ),
                        spaceH16,
                        Text(
                          S.current.ngay_hoan_thanh,
                          textAlign: TextAlign.start,
                          style: tokenDetailAmount(
                            fontSize: 14,
                            color: color3D5586,
                          ),
                        ),
                        spaceH8,
                        DateInput(
                          paddings: 10,
                          leadingIcon: SvgPicture.asset(
                            image_utils.ImageAssets.icCalenders,
                          ),
                          onSelectDate: (dateTime) {
                            birthday = dateTime;
                          },
                          initDateTime:
                              DateFormat(DateTimeFormat.DATE_BE_RESPONSE_FORMAT)
                                  .parse(
                            widget.cubit.supportDetail.thoiGianYeuCau ?? '',
                          ),
                        ),
                        spaceH30,
                        DoubleButtonBottom(
                          title1: S.current.dong,
                          title2: S.current.cap_nhat_thxl,
                          onPressed1: () {
                            Navigator.pop(context);
                          },
                          onPressed2: () {
                            widget.cubit.capNhatTHXL(
                              taskId: widget.cubit.supportDetail.id ?? '',
                              name: '',
                              description: note ?? '',
                              code: trangThai ?? '',
                              finishDay: birthday ?? '',
                              handlerId: nguoiXuLy ?? '',
                              id: widget.cubit.supportDetail.id ?? '',
                              comment: '',
                            );
                            Navigator.pop(context);
                          },
                          noPadding: true,
                        ),
                        spaceH30,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Text(
      title,
      style: textNormalCustom(
        color: color3D5586,
        fontSize: 14,
        fontWeight: FontWeight.w500,
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
          onlyTextField: true,
        )
      ],
    );
  }

  Widget dropDownField({
    String? hintText,
    int maxLine = 1,
    required String title,
    required List<String> listDropdown,
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
          initData: '',
          placeHoder: S.current.chon,
          onChange: (value) {
            if (title == S.current.trang_thai_xu_ly) {
              trangThai = listDropdown[value];
              nguoiXuLy = nguoiXuLy;
            } else {
              trangThai = trangThai;
              nguoiXuLy = listDropdown[value];
            }
          },
          listData: listDropdown,
        )
      ],
    );
  }
}
