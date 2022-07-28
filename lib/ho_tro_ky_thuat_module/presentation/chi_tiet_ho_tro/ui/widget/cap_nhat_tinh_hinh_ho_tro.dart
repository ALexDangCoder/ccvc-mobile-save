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

class CapNhatTinhHinhHoTro extends StatefulWidget {
  const CapNhatTinhHinhHoTro({Key? key, required this.cubit, this.idTask})
      : super(key: key);
  final ChiTietHoTroCubit cubit;
  final String? idTask;

  @override
  _CapNhatTinhHinhHoTroState createState() => _CapNhatTinhHinhHoTroState();
}

class _CapNhatTinhHinhHoTroState extends State<CapNhatTinhHinhHoTro> {
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
                BlocBuilder<ChiTietHoTroCubit, ChiTietHoTroState>(
                  bloc: widget.cubit,
                  builder: (context, state) {
                    if (state is ChiTietHoTroSuccess) {
                      return SizedBox(
                        height: widget.cubit.isTruongPhong ? 500.h : 440.h,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceH20,
                              title(S.current.ket_qua_xu_ly),
                              spaceH16,
                              dropDownField(
                                title: S.current.trang_thai_xu_ly,
                                listDropdown: widget.cubit.listTrangThai,
                                maxLine: 2,
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
                              if (isTruongPhong &&
                                  widget.cubit.supportDetail.nguoiXuLy == null)
                                if (widget.idTask?.isNotEmpty ?? false) ...[
                                  StreamBuilder<List<String>>(
                                    stream: widget.cubit.getItSupport,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return dropDownField(
                                          title: S.current.nguoi_xu_ly,
                                          listDropdown:
                                              widget.cubit.listItSupport,
                                          maxLine: 2,
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
                                ] else ...[
                                  dropDownField(
                                    title: S.current.nguoi_xu_ly,
                                    listDropdown: widget.cubit.listItSupport,
                                    maxLine: 2,
                                  ),
                                ]
                              else ...[
                                Text(
                                  S.current.nguoi_xu_ly,
                                  style: tokenDetailAmount(
                                    fontSize: 14,
                                    color: color3D5586,
                                  ),
                                ),
                                spaceH8,
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 12.w,
                                    top: 12.h,
                                    bottom: 12.h,
                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: borderColor.withOpacity(0.2),
                                    border: Border.all(
                                      color: borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.cubit.supportDetail.nguoiXuLy ??
                                            '',
                                        style: tokenDetailAmount(
                                          fontSize: 14,
                                          color: borderColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                    if (snapshot.data?.id != '' &&
                                        snapshot.hasData) {
                                      return DateInput(
                                        paddings: 10,
                                        leadingIcon: SvgPicture.asset(
                                          image_utils.ImageAssets.icCalenders,
                                        ),
                                        onSelectDate: (dateTime) {
                                          birthday = dateTime;
                                        },
                                        minimumDate: (snapshot
                                                    .data
                                                    ?.thoiGianYeuCau
                                                    ?.isNotEmpty ??
                                                false)
                                            ? DateFormat(
                                                DateTimeFormat
                                                    .DATE_BE_RESPONSE_FORMAT,
                                              ).parse(
                                                snapshot.data!.thoiGianYeuCau!,
                                              )
                                            : null,
                                        initDateTime: (snapshot
                                                    .data
                                                    ?.ngayHoanThanh
                                                    ?.isNotEmpty ??
                                                false)
                                            ? DateFormat(
                                                DateTimeFormat
                                                    .DATE_BE_RESPONSE_FORMAT,
                                              ).parse(
                                                snapshot.data!.ngayHoanThanh!,
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
                                  },
                                )
                              ] else
                                DateInput(
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
                                          DateTimeFormat
                                              .DATE_BE_RESPONSE_FORMAT,
                                        ).parse(
                                          widget.cubit.supportDetail
                                              .thoiGianYeuCau!,
                                        )
                                      : null,
                                  initDateTime: (widget.cubit.supportDetail
                                              .ngayHoanThanh?.isNotEmpty ??
                                          false)
                                      ? DateFormat(
                                          DateTimeFormat
                                              .DATE_BE_RESPONSE_FORMAT,
                                        ).parse(
                                          widget.cubit.supportDetail
                                              .ngayHoanThanh!,
                                        )
                                      : null,
                                ),
                              spaceH30,
                              DoubleButtonBottom(
                                title1: S.current.dong,
                                onlyOneButton: widget.cubit.checkOnlyButton(),
                                title2: S.current.luu,
                                disableRightButton: widget
                                        .cubit.isTruongPhong &&
                                    widget.cubit.supportDetail.codeTrangThai ==
                                        ChiTietHoTroCubit.DANG_XU_LY,
                                onPressed1: () {
                                  Navigator.pop(context);
                                },
                                onPressed2: () {
                                  widget.cubit
                                      .capNhatTHXL(
                                    taskId: (widget.cubit.supportDetail.id ??
                                            widget.idTask) ??
                                        '',
                                    name: (trangThai ??
                                            widget.cubit.supportDetail
                                                .trangThaiXuLy) ??
                                        '',
                                    description: note ?? '',
                                    code: (trangThai ??
                                            widget.cubit.supportDetail
                                                .trangThaiXuLy) ??
                                        '',
                                    finishDay: birthday ?? '',
                                    handlerId: (nguoiXuLy ??
                                            widget.cubit.supportDetail
                                                .nguoiXuLy) ??
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
                                            text: S
                                                .current.luu_du_lieu_thanh_cong,
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
                              ),
                              spaceH30,
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 450.h,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: sideBtnUnselected,
                          ),
                        ),
                      );
                    }
                  },
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
    String? initData,
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
          maxLines: maxLine,
          initData: initData ?? '',
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
