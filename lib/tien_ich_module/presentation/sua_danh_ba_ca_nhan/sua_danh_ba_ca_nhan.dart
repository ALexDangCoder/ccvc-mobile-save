import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/widget/sua_anh_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/sua_danh_ba_ca_nhan/widget/select_date_sua.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/form_group/form_group.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/radio_button/custom_radio_button.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/textformfield/text_form_field_them_moi.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuaDanhBaCaNhan extends StatefulWidget {
  final Items item;
  final String id;
  final DanhBaDienTuCubit cubit;

  const SuaDanhBaCaNhan({
    Key? key,
    required this.item,
    required this.id,
    required this.cubit,
  }) : super(key: key);

  @override
  _SuaDanhBaCaNhanState createState() => _SuaDanhBaCaNhanState();
}

class _SuaDanhBaCaNhanState extends State<SuaDanhBaCaNhan> {
  final keyGroup = GlobalKey<FormGroupState>();
  TextEditingController hoTenController = TextEditingController();
  TextEditingController diaDiemController = TextEditingController();
  TextEditingController ngaySinhController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cmtndController = TextEditingController();
  TextEditingController sdtController = TextEditingController();
  TextEditingController sdtRiengController = TextEditingController();
  TextEditingController sdtCoquanController = TextEditingController();
  bool gioiTinh = true;
  String ngaySinh = '';
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    hoTenController.text = widget.item.hoTen ?? '';
    diaDiemController.text = widget.item.diaChi ?? '';
    emailController.text = widget.item.email ?? '';
    cmtndController.text = widget.item.cmtnd ?? '';
    sdtController.text = widget.item.phoneDiDong ?? '';
    sdtCoquanController.text = widget.item.phoneCoQuan ?? '';
    sdtRiengController.text = widget.item.phoneNhaRieng ?? '';
    ngaySinh = widget.item.ngaySinh ?? '';
    gioiTinh = widget.item.gioiTinh ?? true;
    widget.cubit.pathAnh = widget.item.anhDaiDienFilePath ?? '';

    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: FollowKeyBoardWidget(
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: widget.cubit.stateStream,
            child: SingleChildScrollView(
              child: FormGroup(
                key: keyGroup,
                child: Column(
                  children: [
                    spaceH24,
                    SuaAvatarDanhBa(
                      toast: toast,
                      cubit: widget.cubit,
                      item: widget.item,
                    ),
                    TextFieldStyle(
                      controller: hoTenController,
                      urlIcon: ImageAssets.icEditDb,
                      hintText: S.current.ho_ten_cb,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return '${S.current.ban_phai_nhap_truong} '
                              '${S.current.ho_ten_cb}!';
                        }
                        return null;
                      },
                    ),
                    TextFieldStyle(
                      controller: diaDiemController,
                      urlIcon: ImageAssets.icLocation,
                      hintText: S.current.dia_diem,
                    ),
                    SelectDateSua(
                      leadingIcon: SvgPicture.asset(ImageAssets.icCalenderDb),
                      value: ngaySinh,
                      onSelectDate: (dateTime) {
                        ngaySinh = dateTime;
                        setState(() {});
                      },
                    ),
                    TextFieldStyle(
                      controller: emailController,
                      urlIcon: ImageAssets.icMessage,
                      hintText: S.current.email,
                      validator: (value) {
                        if ((value ?? '').isNotEmpty) {
                          return (value ?? '')
                              .checkEmailBoolean2(S.current.email);
                        }
                      },
                    ),
                    TextFieldStyle(
                      controller: cmtndController,
                      urlIcon: ImageAssets.icCmt,
                      hintText: S.current.so_cmt,
                      maxLenght: 255,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputType: TextInputType.number,
                      validatorPaste: (value) {
                        if (value.trim().validateCopyPaste() != null) {
                          return true;
                        }
                        return false;
                      },
                    ),
                    TextFieldStyle(
                      controller: sdtController,
                      urlIcon: ImageAssets.icCalling,
                      hintText: S.current.sdt_s,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return '${S.current.ban_phai_nhap_truong} '
                              '${S.current.sdt_s}!';
                        }
                        return (value ?? '').checkSdtRequire3(S.current.sdt_s);
                      },
                      validatorPaste: (value) {
                        if (value.trim().validateCopyPaste() != null) {
                          return true;
                        }
                        return false;
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextFieldStyle(
                      controller: sdtCoquanController,
                      urlIcon: ImageAssets.icPhoneCp,
                      hintText: S.current.sdt_co_quan_require,
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
                      controller: sdtRiengController,
                      urlIcon: ImageAssets.icCallDb,
                      hintText: S.current.sdt_nha_rieng_require,
                      textInputType: TextInputType.number,
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
                      value: widget.item.gioiTinh ?? true
                          ? S.current.Nam
                          : S.current.Nu,
                      title: S.current.gioi_tinh,
                      onchange: (value) {
                        if (value == S.current.Nam) {
                          gioiTinh = true;
                        } else {
                          gioiTinh = false;
                        }
                      },
                    ),
                    spaceH16,
                    DoubleButtonBottom(
                      onPressed2: () {
                        if (keyGroup.currentState!.validator()) {
                          widget.cubit
                              .suaDanhSach(
                            groups: '',
                            hoTen: hoTenController.text,
                            phoneDiDong: sdtController.text,
                            phoneCoQuan: sdtCoquanController.text,
                            phoneNhaRieng: sdtRiengController.text,
                            email: emailController.text,
                            gioiTinh: gioiTinh,
                            ngaySinh: ngaySinh,
                            cmtnd: cmtndController.text,
                            anhDaiDienFilePath: widget.cubit.pathAnh,
                            anhChuKyFilePath: widget.cubit.anhChuKyFilePath,
                            anhChuKyNhayFilePath:
                                widget.cubit.anhChuKyNhayFilePath,
                            diaChi: diaDiemController.text,
                            isDeleted: widget.cubit.isDeleted,
                            thuTu: widget.cubit.thuTu ?? 0,
                            createdAt: widget.cubit.createdAt,
                            createdBy: widget.id,
                            updatedAt: widget.cubit.updatedAt,
                            updatedBy: widget.id,
                            id: widget.id,
                          )
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                            }
                          });
                        } else {}
                      },
                      onPressed1: () {
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
      ),
      tabletScreen: Scaffold(
        body: FollowKeyBoardWidget(
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: widget.cubit.stateStream,
            child: SingleChildScrollView(
              child: FormGroup(
                key: keyGroup,
                child: Column(
                  children: [
                    spaceH24,
                    SuaAvatarDanhBa(
                      toast: toast,
                      cubit: widget.cubit,
                      item: widget.item,
                    ),
                    TextFieldStyle(
                      controller: hoTenController,
                      urlIcon: ImageAssets.icEditDb,
                      hintText: S.current.ho_ten_cb,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return '${S.current.ban_phai_nhap_truong} '
                              '${S.current.ho_ten_cb}!';
                        }
                        return null;
                      },
                    ),
                    SelectDateSua(
                      isTablet: true,
                      leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                      value: ngaySinh,
                      onSelectDate: (dateTime) {
                        ngaySinh = dateTime;
                        setState(() {});
                      },
                    ),
                    spaceH16,
                    CustomRadioButton(
                      value: widget.item.gioiTinh ?? true
                          ? S.current.Nam
                          : S.current.Nu,
                      title: S.current.gioi_tinh,
                      onchange: (value) {
                        if (value == S.current.Nam) {
                          gioiTinh = true;
                        } else {
                          gioiTinh = false;
                        }
                      },
                    ),
                    TextFieldStyle(
                      controller: emailController,
                      urlIcon: ImageAssets.icMessage,
                      hintText: S.current.email,
                      validator: (value) {
                        if ((value ?? '').isNotEmpty) {
                          return (value ?? '')
                              .checkEmailBoolean2(S.current.email);
                        }
                      },
                    ),
                    TextFieldStyle(
                      controller: cmtndController,
                      urlIcon: ImageAssets.icCmt,
                      hintText: S.current.so_cmt,
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
                      controller: sdtController,
                      urlIcon: ImageAssets.icCalling,
                      hintText: S.current.sdt_s,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return '${S.current.ban_phai_nhap_truong} '
                              '${S.current.sdt_s}!';
                        }
                        return (value ?? '').checkSdtRequire2(S.current.sdt_s);
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
                      controller: sdtCoquanController,
                      urlIcon: ImageAssets.icPhoneCp,
                      hintText: S.current.sdt_co_quan_require,
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
                      controller: sdtRiengController,
                      urlIcon: ImageAssets.icCallDb,
                      hintText: S.current.sdt_nha_rieng_require,
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
                      controller: diaDiemController,
                      urlIcon: ImageAssets.icLocation,
                      hintText: S.current.dia_diem,
                    ),
                    DoubleButtonBottom(
                      isTablet: true,
                      onPressed2: () {
                        if (keyGroup.currentState!.validator()) {
                          widget.cubit
                              .suaDanhSach(
                            groups: '',
                            hoTen: hoTenController.text,
                            phoneDiDong: sdtController.text,
                            phoneCoQuan: sdtCoquanController.text,
                            phoneNhaRieng: sdtRiengController.text,
                            email: emailController.text,
                            gioiTinh: gioiTinh,
                            ngaySinh: ngaySinh,
                            cmtnd: cmtndController.text,
                            anhDaiDienFilePath: widget.cubit.pathAnh,
                            anhChuKyFilePath: widget.cubit.anhChuKyFilePath,
                            anhChuKyNhayFilePath:
                                widget.cubit.anhChuKyNhayFilePath,
                            diaChi: diaDiemController.text,
                            isDeleted: widget.cubit.isDeleted,
                            thuTu: widget.cubit.thuTu ?? 0,
                            createdAt: widget.cubit.createdAt,
                            createdBy: widget.id,
                            updatedAt: widget.cubit.updatedAt,
                            updatedBy: widget.id,
                            id: widget.id,
                          )
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                            }
                          });
                        } else {}
                      },
                      onPressed1: () {
                        Navigator.pop(context);
                      },
                      title2: S.current.luu_danh_ba,
                      title1: S.current.huy,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
