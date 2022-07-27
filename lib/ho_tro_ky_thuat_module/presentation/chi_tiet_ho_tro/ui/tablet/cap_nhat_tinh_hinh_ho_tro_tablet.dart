import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dialog/show_toat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CapNhatTinhHinhHoTroTabLet extends StatefulWidget {
  const CapNhatTinhHinhHoTroTabLet({Key? key, required this.cubit, this.idTask})
      : super(key: key);
  final ChiTietHoTroCubit cubit;
  final String? idTask;

  @override
  _CapNhatTinhHinhHoTroTabLetState createState() =>
      _CapNhatTinhHinhHoTroTabLetState();
}

class _CapNhatTinhHinhHoTroTabLetState
    extends State<CapNhatTinhHinhHoTroTabLet> {
  String? note;
  String? birthday;
  String? trangThai;
  String? nguoiXuLy;
  bool isTruongPhong = false;

  @override
  void initState() {
    super.initState();
    if (widget.idTask?.isNotEmpty ?? false) {
      widget.cubit.getSupportDetail(widget.idTask ?? '');
    }
    isTruongPhong = HiveLocal.checkPermissionApp(
      permissionType: PermissionType.HTKT,
      permissionTxt: QUYEN_TRUONG_PHONG,
    );
  }

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
          spaceH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.cap_nhat_tinh_hinh_ho_tro,
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
          BlocBuilder<ChiTietHoTroCubit, ChiTietHoTroState>(
            bloc: widget.cubit,
            builder: (context, state) {
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                    if (isTruongPhong)
                      if (widget.idTask?.isNotEmpty ?? false) ...[
                        StreamBuilder<List<String>>(
                          stream: widget.cubit.getItSupport,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return dropDownField(
                                title: S.current.nguoi_xu_ly,
                                listDropdown: widget.cubit.listItSupport,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: sideBtnUnselected,
                                ),
                              );
                            }
                          },
                        ),
                      ] else
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
                    if (widget.idTask?.isNotEmpty ?? false) ...[
                      StreamBuilder<SupportDetail>(
                          stream: widget.cubit.ngayHoanThanhStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data?.id != '') {
                              return DateInput(
                                paddings: 10,
                                leadingIcon: SvgPicture.asset(
                                  image_utils.ImageAssets.icCalenders,
                                ),
                                onSelectDate: (dateTime) {
                                  birthday = dateTime;
                                },
                                minimumDate: (widget.cubit.supportDetail
                                    .thoiGianYeuCau?.isNotEmpty ??
                                    false)
                                    ? DateFormat(
                                  DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
                                ).parse(
                                  widget.cubit.supportDetail.thoiGianYeuCau!,
                                )
                                    : null,
                                initDateTime: (widget.cubit.supportDetail
                                    .ngayHoanThanh?.isNotEmpty ??
                                    false)
                                    ? DateFormat(
                                  DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
                                ).parse(
                                  widget.cubit.supportDetail.ngayHoanThanh!,
                                )
                                    : null,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: sideBtnUnselected,
                                ),
                              );
                            }
                          })
                    ] else
                      DateInput(
                        paddings: 10,
                        leadingIcon: SvgPicture.asset(
                          image_utils.ImageAssets.icCalenders,
                        ),
                        onSelectDate: (dateTime) {
                          birthday = dateTime;
                        },
                        minimumDate: (widget.cubit.supportDetail.thoiGianYeuCau
                            ?.isNotEmpty ??
                            false)
                            ? DateFormat(
                          DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
                        ).parse(
                          widget.cubit.supportDetail.thoiGianYeuCau!,
                        )
                            : null,
                        initDateTime:
                        (widget.cubit.supportDetail.ngayHoanThanh?.isNotEmpty ??
                            false)
                            ? DateFormat(
                          DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
                        ).parse(
                          widget.cubit.supportDetail.ngayHoanThanh!,
                        )
                            : null,
                      ),
                    spaceH10,
                    Padding(
                      padding: EdgeInsets.only(
                        left: 119.w,
                        right: 119.w,
                      ),
                      child: DoubleButtonBottom(
                        title1: S.current.dong,
                        title2: S.current.cap_nhat_thxl,
                        disableRightButton: widget.cubit.isTruongPhong &&
                            widget.cubit.supportDetail.codeTrangThai ==
                                ChiTietHoTroCubit.DANG_XU_LY,
                        onPressed1: () {
                          Navigator.pop(context);
                        },
                        onPressed2: () {
                          widget.cubit
                              .capNhatTHXL(
                            taskId:
                            (widget.cubit.supportDetail.id ?? widget.idTask) ??
                                '',
                            name: (trangThai ??
                                widget.cubit.supportDetail.trangThaiXuLy) ??
                                '',
                            description: note ?? '',
                            code: (trangThai ??
                                widget.cubit.supportDetail.trangThaiXuLy) ??
                                '',
                            finishDay: birthday ?? '',
                            handlerId: (nguoiXuLy ??
                                widget.cubit.supportDetail.nguoiXuLy) ??
                                '',
                            id: (widget.cubit.supportDetail.id ??
                                widget.idTask) ??
                                '',
                            comment: '',
                          )
                              .then(
                                (value) {
                              if (value == successCode) {
                                Navigator.pop(context, true);
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
                        },
                        noPadding: true,
                        isTablet: true,
                      ),
                    ),
                    spaceH10,
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget title(String title) {
    return Text(
      title,
      style: textNormalCustom(
        color: color3D5586,
        fontSize: 16,
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
                  fontSize: 16,
                  color: color3D5586,
                ),
              ),
            ],
          ),
        ),
        spaceH8,
        CoolDropDown(
          initData: title == S.current.trang_thai_xu_ly
              ? (widget.cubit.supportDetail.trangThaiXuLy ?? '')
              : (widget.cubit.supportDetail.nguoiXuLy ?? ''),
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
