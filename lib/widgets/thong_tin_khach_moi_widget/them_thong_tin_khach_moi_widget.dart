import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/follow_key_broash.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/widgets/thanh_phan_tham_gia_tao_hop.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_phoi_hop_khac/them_don_vi_phoi_hop_khac_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemThongTinKhachMoiWidget extends StatefulWidget {
  final Function(List<DonViModel> value) onChange;
  final Function(DonViModel)? onDelete;
  final bool isMoiHop;
  final bool isCheckedEmail;
  final List<ItemTypeThanhPhan>? showType;
  const ThemThongTinKhachMoiWidget({
    Key? key,
    required this.onChange,
    this.isMoiHop = false,
    this.isCheckedEmail = false,
    this.onDelete,
    this.showType,
  }) : super(key: key);

  @override
  _ThemDonViPhoiHopKhacWidgetState createState() =>
      _ThemDonViPhoiHopKhacWidgetState();
}

class _ThemDonViPhoiHopKhacWidgetState
    extends State<ThemThongTinKhachMoiWidget> {
  ThanhPhanThamGiaCubit cubit = ThanhPhanThamGiaCubit();

  @override
  void initState() {
    super.initState();
    cubit.listPeopleThamGia.listen((event) {
      widget.onChange(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isMoiHop ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        SolidButton(
          onTap: () {
            showDialog(context);
          },
          text: S.current.them_thong_tin_khach_moi,
          urlIcon: ImageAssets.icAddButtonCalenderTablet,
        ),
        StreamBuilder<List<DonViModel>>(
          stream: cubit.listPeopleThamGia,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <DonViModel>[];
            return Column(
              children: List.generate(
                data.length,
                (index) => Padding(
                  padding: EdgeInsets.only(top: 20.0.textScale(space: -2)),
                  child: widget.isMoiHop
                      ? ItemPeopleThamGia(
                          donVi: data[index],
                          cubit: cubit,
                          isKhachMoi: widget.isMoiHop,
                          isSendEmail: widget.isCheckedEmail,
                          onDelete: () {
                            widget.onDelete?.call(data[index]);
                          },
                        )
                      : ItemThanhPhanWidget(
                          data: data[index],
                          cubit: cubit,
                          showType: [
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.TEN_DON_VI,
                              title: S.current.ten_don_vi,
                            ),
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.HO_VA_TEN,
                              title: S.current.ho_va_ten,
                            ),
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.SO_LUONG,
                              title: S.current.so_luong,
                            ),
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.NOI_DUNG,
                              title: S.current.noidung,
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  void showDialog(BuildContext context) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        child: ThemThongTinKhachMoiScreen(
          cubit: cubit,
        ),
        title: S.current.thong_tin_khach_moi,
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.thong_tin_khach_moi,
        isBottomShow: false,
        child: ThemThongTinKhachMoiScreen(
          cubit: cubit,
        ),
        funcBtnOk: () {},
      );
    }
  }
}

class ThemThongTinKhachMoiScreen extends StatefulWidget {
  final ThanhPhanThamGiaCubit cubit;

  const ThemThongTinKhachMoiScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThemThongTinKhachMoiScreen> createState() =>
      _ThemDonViPhoiHopKhacScreenState();
}

class _ThemDonViPhoiHopKhacScreenState
    extends State<ThemThongTinKhachMoiScreen> {
  final _key = GlobalKey<FormState>();
  final _keyFormGroup = GlobalKey<FormGroupState>();

  final TextEditingController _hoTenController = TextEditingController();
  final TextEditingController _tenDonViController = TextEditingController();
  final TextEditingController _noiDungLamViecController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sdtController = TextEditingController();
  final TextEditingController _soLuongController = TextEditingController();
final scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      child: FollowKeyBoardEdt(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
          child: DoubleButtonBottom(
            isTablet: isMobile() == false,
            title1: S.current.dong,
            title2: S.current.them,
            onClickLeft: () {
              Navigator.pop(context);
            },
            onClickRight: () {
              if (_keyFormGroup.currentState!.validator()) {
                widget.cubit.addDonViPhoiHopKhac(
                  DonViModel(
                    name: _hoTenController.text.trim(),
                    tenDonVi: _tenDonViController.text.trim(),
                    noidung: _noiDungLamViecController.text.trim(),
                    email: _emailController.text.trim(),
                    sdt: _sdtController.text.trim(),
                    tenCoQuan: _tenDonViController.text.trim(),
                    vaiTroThamGia: 5,
                    dauMoiLienHe: _hoTenController.text.trim(),
                    tenCanBo: _hoTenController.text.trim(),
                    soLuong: int.parse(_soLuongController.text.trim()),
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: scroll,
                reverse: true,
                child: FormGroup(
                  scrollController: scroll,
                  key: _keyFormGroup,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InputInfoUserWidget(
                        title: S.current.ho_va_ten,
                        isObligatory: true,
                        child: TextFieldValidator(
                          controller: _hoTenController,
                          hintText: S.current.ho_va_ten,
                          validator: (value) {
                            return (value ?? '').pleaseEnter(
                              S.current.ho_va_ten.toLowerCase(),
                            );
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: S.current.ten_don_vi,
                        isObligatory: true,
                        child: TextFieldValidator(
                          controller: _tenDonViController,
                          hintText: S.current.ten_don_vi,
                          validator: (value) {
                            return (value ?? '').pleaseEnter(
                              S.current.ten_don_vi,
                            );
                          },
                        ),
                      ),
                      spaceH20,
                      BlockTextView(
                        formKey: _key,
                        title: S.current.noi_dung_lam_viec,
                        isRequired: false,
                        contentController: _noiDungLamViecController,
                      ),
                      InputInfoUserWidget(
                        title: S.current.email,
                        child: TextFieldValidator(
                          controller: _emailController,
                          hintText: S.current.email,
                          textInputType: TextInputType.emailAddress,
                          suffixIcon: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: SvgPicture.asset(ImageAssets.ic_email),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return null;
                            }
                            return (value ?? '')
                              .checkEmailBoolean(
                                errMessage: '${S.current.sai_dinh_dang_truong} '
                                    '${S.current.email}',
                              );
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: S.current.so_dien_thoai,
                        child: TextFieldValidator(
                          controller: _sdtController,
                          hintText: S.current.so_dien_thoai,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          suffixIcon: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: SvgPicture.asset(ImageAssets.icPhone),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return null;
                            }
                            return (value ?? '').checkSdt();
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: S.current.tong_so_luong_khach,
                        isObligatory: true,
                        child: TextFieldValidator(
                          controller: _soLuongController,
                          hintText: S.current.nhap_so_luong,
                          textInputType: TextInputType.number,
                          suffixIcon: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child:
                                  SvgPicture.asset(ImageAssets.icGroupPeople),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            return (value ?? '').pleaseEnter(
                              S.current.nhap_so_luong.toLowerCase(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
