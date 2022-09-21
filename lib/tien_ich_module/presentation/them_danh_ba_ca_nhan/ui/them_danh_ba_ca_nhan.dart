import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/widget/chon_anh.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/widget/select_date.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/form_group/form_group.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/radio_button/custom_radio_button.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/textformfield/text_form_field_them_moi.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ThemDanhBaCaNhan extends StatefulWidget {
  final DanhBaDienTuCubit cubit;

  const ThemDanhBaCaNhan({Key? key, required this.cubit}) : super(key: key);

  @override
  _ThemDanhBaCaNhanState createState() => _ThemDanhBaCaNhanState();
}

class _ThemDanhBaCaNhanState extends State<ThemDanhBaCaNhan> {
  final keyGroup = GlobalKey<FormGroupState>();
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
    widget.cubit.dateDanhSach = '';
    widget.cubit.isCheckValidate.add(' ');
    widget.cubit.pathAnh = '';
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: FollowKeyBoardWidget(
          child: SingleChildScrollView(
            child: FormGroup(
              key: keyGroup,
              child: Column(
                children: [
                  spaceH24,
                  AvatarDanhBa(
                    toast: toast,
                    cubit: widget.cubit,
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icEditDb,
                    hintText: S.current.ho_ten_cb,
                    onChange: (value) {
                      widget.cubit.hoTen = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.ho_ten_cb}!';
                      }
                      return null;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icLocation,
                    hintText: S.current.dia_diem,
                    onChange: (value) {
                      widget.cubit.diaChi = value;
                    },
                  ),
                  SelectDateThem(
                    leadingIcon: SvgPicture.asset(ImageAssets.icCalenderDb),
                    hintText: S.current.ngay_sinh_require,
                    onSelectDate: (dateTime) {
                      widget.cubit.dateDanhSach = dateTime;
                      widget.cubit.isCheckValidate.sink
                          .add(widget.cubit.dateDanhSach);
                    },
                    cubit: widget.cubit,
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icMessage,
                    hintText: S.current.email,
                    onChange: (value) {
                      widget.cubit.email = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isNotEmpty) {
                        return (value ?? '')
                            .checkEmailBoolean2(S.current.email);
                      }
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icCmt,
                    hintText: S.current.so_cmt,
                    onChange: (value) {
                      widget.cubit.cmtnd = value;
                    },
                    maxLenght: 255,
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icCalling,
                    hintText: S.current.sdt_s,
                    onChange: (value) {
                      widget.cubit.phoneDiDong = value;
                    },
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.sdt_s}!';
                      }
                      return (value ?? '').checkSdtRequire3(S.current.sdt_s);
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icPhoneCp,
                    hintText: S.current.sdt_co_quan_require,
                    onChange: (value) {
                      widget.cubit.phoneCoQuan = value;
                    },
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.sdt_co_quan_require}!';
                      }
                      return (value ?? '')
                          .checkSdtRequire2(S.current.sdt_co_quan_require);
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icCallDb,
                    hintText: S.current.sdt_nha_rieng_require,
                    onChange: (value) {
                      widget.cubit.phoneNhaRieng = value;
                    },
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.sdt_nha_rieng_require}!';
                      }
                      return (value ?? '')
                          .checkSdtRequire2(S.current.sdt_nha_rieng_require);
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  spaceH16,
                  CustomRadioButton(
                    title: S.current.gioi_tinh,
                    onchange: (value) {
                      if (value == S.current.Nam) {
                        widget.cubit.gioiTinh = true;
                      }
                      return widget.cubit.gioiTinh = false;
                    },
                  ),
                  spaceH16,
                  DoubleButtonBottom(
                    onPressed2: () async {
                      if (keyGroup.currentState!.validator() &&
                          widget.cubit.dateDanhSach.isNotEmpty) {
                        widget.cubit.isCheckValidate.sink
                            .add(widget.cubit.dateDanhSach);
                        await widget.cubit
                            .postDanhSach(
                          hoTen: widget.cubit.hoTen,
                          phoneDiDong: widget.cubit.phoneDiDong,
                          phoneCoQuan: widget.cubit.phoneCoQuan,
                          phoneNhaRieng: widget.cubit.phoneNhaRieng,
                          email: widget.cubit.email,
                          gioiTinh: widget.cubit.gioiTinh,
                          ngaySinh: widget.cubit.dateDanhSach,
                          cmtnd: widget.cubit.cmtnd,
                          anhDaiDienFilePath: widget.cubit.pathAnh,
                          anhChuKyFilePath: widget.cubit.anhChuKyFilePath,
                          anhChuKyNhayFilePath:
                              widget.cubit.anhChuKyNhayFilePath,
                          diaChi: widget.cubit.diaChi,
                          isDeleted: widget.cubit.isDeleted,
                          thuTu: widget.cubit.thuTu ?? 0,
                          groupIds: widget.cubit.groupIds ?? [],
                        )
                            .then((value) {
                          if (value) {
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        widget.cubit.isCheckValidate.sink.add(
                          widget.cubit.dateDanhSach,
                        );
                      }
                    },
                    onPressed1: () {
                      widget.cubit.dateDanhSach = '';
                      Navigator.pop(context);
                    },
                    title2: S.current.luu_danh_ba,
                    title1: S.current.huy,
                  ),
                  spaceH24
                ],
              ),
            ),
          ),
        ),
      ),
      tabletScreen: Scaffold(
        body: FollowKeyBoardWidget(
          child: SingleChildScrollView(
            child: FormGroup(
              key: keyGroup,
              child: Column(
                children: [
                  spaceH24,
                  AvatarDanhBa(
                    toast: toast,
                    cubit: widget.cubit,
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icEditDb,
                    hintText: S.current.ho_ten_cb,
                    onChange: (value) {
                      widget.cubit.hoTen = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.ho_ten_cb}!';
                      }
                      return null;
                    },
                  ),
                  SelectDateThem(
                    //key: UniqueKey(),
                    leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                    hintText: S.current.ngay_sinh_require,
                    isTablet: true,
                    onSelectDate: (dateTime) {
                      widget.cubit.dateDanhSach = dateTime;
                      widget.cubit.isCheckValidate.sink
                          .add(widget.cubit.dateDanhSach);
                    },
                    cubit: widget.cubit,
                  ),
                  spaceH14,
                  CustomRadioButton(
                    title: S.current.gioi_tinh,
                    onchange: (value) {
                      if (value == S.current.Nam) {
                        widget.cubit.gioiTinh = true;
                      }
                      return widget.cubit.gioiTinh = false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icMessage,
                    hintText: S.current.email,
                    onChange: (value) {
                      widget.cubit.email = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isNotEmpty) {
                        return (value ?? '')
                            .checkEmailBoolean2(S.current.email);
                      }
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icCmt,
                    hintText: S.current.so_cmt,
                    maxLenght: 255,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChange: (value) {
                      widget.cubit.cmtnd = value;
                    },
                    textInputType: TextInputType.number,
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icCalling,
                    hintText: S.current.sdt_s,
                    onChange: (value) {
                      widget.cubit.phoneDiDong = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.sdt_s}!';
                      }
                      return (value ?? '').checkSdtRequire3(S.current.sdt_s);
                    },
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icPhoneCp,
                    hintText: S.current.sdt_co_quan_require,
                    onChange: (value) {
                      widget.cubit.phoneCoQuan = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.sdt_co_quan_require}!';
                      }
                      return (value ?? '')
                          .checkSdtRequire2(S.current.sdt_co_quan_require);
                    },
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icCallDb,
                    hintText: S.current.sdt_nha_rieng_require,
                    onChange: (value) {
                      widget.cubit.phoneNhaRieng = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return '${S.current.ban_phai_nhap_truong} '
                            '${S.current.sdt_nha_rieng_require}!';
                      }
                      return (value ?? '')
                          .checkSdtRequire2(S.current.sdt_nha_rieng_require);
                    },
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorPaste: (value) {
                      if (value.trim().validateCopyPaste() != null) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  TextFieldStyle(
                    urlIcon: ImageAssets.icLocation,
                    hintText: S.current.dia_diem,
                    onChange: (value) {
                      widget.cubit.diaChi = value;
                    },
                  ),
                  DoubleButtonBottom(
                    isTablet: true,
                    onPressed2: () async {
                      if (keyGroup.currentState!.validator() &&
                          widget.cubit.dateDanhSach.isNotEmpty) {
                        widget.cubit.isCheckValidate.sink
                            .add(widget.cubit.dateDanhSach);
                        await widget.cubit
                            .postDanhSach(
                          hoTen: widget.cubit.hoTen,
                          phoneDiDong: widget.cubit.phoneDiDong,
                          phoneCoQuan: widget.cubit.phoneCoQuan,
                          phoneNhaRieng: widget.cubit.phoneNhaRieng,
                          email: widget.cubit.email,
                          gioiTinh: widget.cubit.gioiTinh,
                          ngaySinh: widget.cubit.dateDanhSach,
                          cmtnd: widget.cubit.cmtnd,
                          anhDaiDienFilePath: widget.cubit.pathAnh,
                          anhChuKyFilePath: widget.cubit.anhChuKyFilePath,
                          anhChuKyNhayFilePath:
                              widget.cubit.anhChuKyNhayFilePath,
                          diaChi: widget.cubit.diaChi,
                          isDeleted: widget.cubit.isDeleted,
                          thuTu: widget.cubit.thuTu ?? 0,
                          groupIds: widget.cubit.groupIds ?? [],
                        )
                            .then((value) {
                          if (value) {
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        widget.cubit.isCheckValidate.sink
                            .add(widget.cubit.dateDanhSach);
                      }
                    },
                    onPressed1: () {
                      widget.cubit.dateDanhSach = '';
                      Navigator.pop(context);
                    },
                    title2: S.current.luu_danh_ba,
                    title1: S.current.huy,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
