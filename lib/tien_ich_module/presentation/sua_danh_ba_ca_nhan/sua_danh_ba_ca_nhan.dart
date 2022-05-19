import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool gioiTinh = false;
  String ngaySinh = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hoTenController.text = widget.item.hoTen ?? '';
    diaDiemController.text = widget.item.diaChi ?? '';
    emailController.text = widget.item.email ?? '';
    cmtndController.text = widget.item.cmtnd ?? '';
    sdtController.text = widget.item.phoneDiDong ?? '';
    sdtCoquanController.text = widget.item.phoneCoQuan ?? '';
    sdtRiengController.text = widget.item.phoneNhaRieng ?? '';
    ngaySinh = widget.item.ngaySinh ?? '';
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
                  const AvatarDanhBa(),
                  TextFieldStyle(
                    controller: hoTenController,
                    urlIcon: ImageAssets.icEditDb,
                    hintText: S.current.ho_ten_cb,
                    onChange: (value) {
                      if (value.isEmpty) {
                        widget.cubit.hoTen = value;
                      }
                      return widget.cubit.hoTen = hoTenController.text;
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
                    controller: diaDiemController,
                    urlIcon: ImageAssets.icLocation,
                    hintText: S.current.dia_diem,
                    onChange: (value) {
                      widget.cubit.diaChi = value;
                    },
                  ),
                  SelectDate(
                    leadingIcon: SvgPicture.asset(ImageAssets.icCalenderDb),
                    value: widget.item.ngaySinh ?? '',
                    onSelectDate: (dateTime) {
                      ngaySinh = dateTime;
                    },
                  ),
                  TextFieldStyle(
                    controller: emailController,
                    urlIcon: ImageAssets.icMessage,
                    hintText: S.current.email,
                    onChange: (value) {
                      widget.cubit.email = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkEmailBoolean();
                    },
                  ),
                  TextFieldStyle(
                    controller: cmtndController,
                    urlIcon: ImageAssets.icCmt,
                    hintText: S.current.so_cmt,
                    onChange: (value) {
                      widget.cubit.cmtnd = value;
                    },
                    textInputType: TextInputType.number,
                  ),
                  TextFieldStyle(
                    controller: sdtController,
                    urlIcon: ImageAssets.icCalling,
                    hintText: S.current.sdt_s,
                    onChange: (value) {
                      widget.cubit.phoneDiDong = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkSdtRequire();
                    },
                    textInputType: TextInputType.number,
                  ),
                  TextFieldStyle(
                    controller: sdtCoquanController,
                    urlIcon: ImageAssets.icPhoneCp,
                    hintText: S.current.sdt_co_quan_require,
                    onChange: (value) {
                      widget.cubit.phoneCoQuan = value;
                    },
                    textInputType: TextInputType.number,
                    validator: (value) {
                      return (value ?? '').checkSdtRequire();
                    },
                  ),
                  TextFieldStyle(
                    controller: sdtRiengController,
                    urlIcon: ImageAssets.icCallDb,
                    hintText: S.current.sdt_co_quan_require,
                    onChange: (value) {
                      widget.cubit.phoneNhaRieng = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkSdtRequire();
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
                          anhDaiDienFilePath: widget.cubit.anhDaiDienFilePath,
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
      tabletScreen: Scaffold(
        body: FollowKeyBoardWidget(
          child: SingleChildScrollView(
            child: FormGroup(
              key: keyGroup,
              child: Column(
                children: [
                  spaceH24,
                  const AvatarDanhBa(),
                  TextFieldStyle(
                    controller: hoTenController,
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
                  SelectDate(
                    isTablet: true,
                    leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
                    value: widget.item.ngaySinh,
                    onSelectDate: (dateTime) {
                      ngaySinh = dateTime;
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
                    onChange: (value) {
                      widget.cubit.email = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkEmailBoolean();
                    },
                  ),
                  TextFieldStyle(
                    controller: cmtndController,
                    urlIcon: ImageAssets.icCmt,
                    hintText: S.current.so_cmt,
                    onChange: (value) {
                      widget.cubit.cmtnd = value;
                    },
                    textInputType: TextInputType.number,
                  ),
                  TextFieldStyle(
                    controller: sdtController,
                    urlIcon: ImageAssets.icCalling,
                    hintText: S.current.sdt_s,
                    onChange: (value) {
                      widget.cubit.phoneDiDong = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkSdtRequire();
                    },
                    textInputType: TextInputType.number,
                  ),
                  TextFieldStyle(
                    controller: sdtCoquanController,
                    urlIcon: ImageAssets.icPhoneCp,
                    hintText: S.current.sdt_co_quan_require,
                    onChange: (value) {
                      widget.cubit.phoneCoQuan = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkSdtRequire();
                    },
                    textInputType: TextInputType.number,
                  ),
                  TextFieldStyle(
                    controller: sdtRiengController,
                    urlIcon: ImageAssets.icCallDb,
                    hintText: S.current.sdt_nha_rieng_require,
                    onChange: (value) {
                      widget.cubit.phoneNhaRieng = value;
                    },
                    validator: (value) {
                      return (value ?? '').checkSdtRequire();
                    },
                    textInputType: TextInputType.number,
                  ),
                  TextFieldStyle(
                    controller: diaDiemController,
                    urlIcon: ImageAssets.icLocation,
                    hintText: S.current.dia_diem,
                    onChange: (value) {
                      widget.cubit.diaChi = value;
                    },
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
                          anhDaiDienFilePath: widget.cubit.anhDaiDienFilePath,
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
    );
  }
}
