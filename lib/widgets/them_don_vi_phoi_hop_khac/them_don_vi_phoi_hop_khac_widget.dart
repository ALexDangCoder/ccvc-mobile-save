import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/follow_key_broash.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/checkbox/checkbox.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemDonViPhoiHopKhacWidget extends StatefulWidget {
  final Function(List<DonViModel> value) onChange;
  final Function(DonViModel)? onDelete;
  final bool isTaoHop;
  final bool isCheckedEmail;
  final List<ItemTypeThanhPhan>? showType;
  const ThemDonViPhoiHopKhacWidget({
    Key? key,
    required this.onChange,
    this.isTaoHop = false,
    this.isCheckedEmail = false,
    this.onDelete,
    this.showType,
  }) : super(key: key);

  @override
  _ThemDonViPhoiHopKhacWidgetState createState() =>
      _ThemDonViPhoiHopKhacWidgetState();
}

class _ThemDonViPhoiHopKhacWidgetState
    extends State<ThemDonViPhoiHopKhacWidget> {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SolidButton(
          onTap: () {
            showDialog(context);
          },
          text: widget.isTaoHop
              ? S.current.them_don_vi_phoi_hop_khac
              : S.current.them_thanh_phan_tham_gia,
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
                  child: widget.isTaoHop
                      ? ItemDonViPhoiHopWidget(
                          data: data[index],
                          cubit: cubit,
                          isCheckedEmail: widget.isCheckedEmail,
                          onDelete: (value) {
                            widget.onDelete?.call(value);
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
                              type: TypeFileShowDonVi.DAU_MOI_LIEN_HE,
                              title: S.current.dau_moi_lam_viec,
                            ),
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.NOI_DUNG,
                              title: S.current.noidung,
                            ),
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.EMAIL,
                              title: S.current.email,
                            ),
                            ItemTypeThanhPhan(
                              type: TypeFileShowDonVi.SDT,
                              title: S.current.so_dien_thoai,
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
        child: ThemDonViPhoiHopKhacScreen(
          cubit: cubit,
        ),
        title: S.current.don_vi_phoi_hop_khac,
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.don_vi_phoi_hop_khac,
        isBottomShow: false,
        child: ThemDonViPhoiHopKhacScreen(
          cubit: cubit,
        ),
        funcBtnOk: () {},
      );
    }
  }
}

class ItemTypeThanhPhan {
  final TypeFileShowDonVi type;
  final String title;

  ItemTypeThanhPhan({required this.type, required this.title});
}

class ItemThanhPhanWidget extends StatelessWidget {
  final DonViModel data;
  final ThanhPhanThamGiaCubit cubit;
  final List<ItemTypeThanhPhan>? showType;
  const ItemThanhPhanWidget({
    Key? key,
    required this.data,
    required this.cubit,
    this.showType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          if (showType == null)
            Column(
              children: [
                rowInfo(
                  value: data.name,
                  key: S.current.ten_don_vi,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(value: data.tenCanBo, key: S.current.ten_can_bo),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                Row(
                  crossAxisAlignment: isMobile()
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2.0.textScale().toInt(),
                      child: Text(
                        S.current.noi_dung,
                        style: textNormal(infoColor, 14),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        data.noidung,
                        style: textNormal(color3D5586, 14.0.textScale()),
                      ),
                    )
                  ],
                )
              ],
            )
          else
            Column(
              children: List.generate(
                showType!.length,
                (index) {
                  final result = showType![index];
                  return Padding(
                    padding: EdgeInsets.only(top: 10.0.textScale(space: 10)),
                    child: rowInfo(
                        key: result.title,
                        value: result.type.valueDonViModel(data)),
                  );
                },
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                cubit.removeDonViPhoiHop(data);
              },
              child: SvgPicture.asset(ImageAssets.icDeleteRed),
            ),
          )
        ],
      ),
    );
  }

  Widget rowInfo({required String key, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 2.0.textScale().toInt(),
          child: Text(
            key,
            style: textNormal(infoColor, 14.0.textScale()),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: textNormal(color3D5586, 14.0.textScale()),
          ),
        )
      ],
    );
  }
}

class ItemDonViPhoiHopWidget extends StatefulWidget {
  final DonViModel data;
  final ThanhPhanThamGiaCubit cubit;
  final bool isCheckedEmail;
  final Function(DonViModel)? onDelete;

  const ItemDonViPhoiHopWidget({
    Key? key,
    required this.data,
    required this.cubit,
    required this.isCheckedEmail,
    this.onDelete,
  }) : super(key: key);

  @override
  State<ItemDonViPhoiHopWidget> createState() => _ItemDonViPhoiHopWidgetState();
}

class _ItemDonViPhoiHopWidgetState extends State<ItemDonViPhoiHopWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isCheckedEmail;
  }

  @override
  void didUpdateWidget(covariant ItemDonViPhoiHopWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    isChecked = widget.isCheckedEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              rowInfo(
                value: widget.data.tenDonVi,
                key: S.current.dv_phoi_hop,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: widget.data.dauMoiLienHe,
                key: S.current.nguoi_phoi_hop,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              Row(
                crossAxisAlignment: isMobile()
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.noidung,
                      style: textNormal(infoColor, 14),
                    ),
                  ),
                  spaceW8,
                  Expanded(
                    flex: 7,
                    child: textField(
                      onChange: (value) {
                        widget.data.noidung = value;
                      },
                      initValue: widget.data.noidung,
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.cubit.removeDonViPhoiHop(widget.data);
                    widget.onDelete?.call(widget.data);
                  },
                  child: SvgPicture.asset(ImageAssets.icDeleteRed),
                ),
                spaceW12,
                StreamBuilder<bool>(
                  stream: widget.cubit.phuongThucNhanStream,
                  builder: (context, snapshot) {
                    return CusCheckBox(
                      isChecked: isChecked,
                      onChange: (value) {},
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textField({
    Function(String)? onChange,
    String? hintText,
    String? initValue,
  }) {
    return TextFormField(
      onChanged: (value) {
        onChange?.call(value);
      },
      initialValue: initValue,
      style: textNormal(color3D5586, 16),
      maxLines: isMobile() ? 1 : 3,
      decoration: InputDecoration(
        hintText: hintText ?? S.current.nhap_noi_dung_cong_viec,
        hintStyle: textNormal(textBodyTime, 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }
}

class ThemDonViPhoiHopKhacScreen extends StatefulWidget {
  final ThanhPhanThamGiaCubit cubit;

  const ThemDonViPhoiHopKhacScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThemDonViPhoiHopKhacScreen> createState() =>
      _ThemDonViPhoiHopKhacScreenState();
}

class _ThemDonViPhoiHopKhacScreenState
    extends State<ThemDonViPhoiHopKhacScreen> {
  final _key = GlobalKey<FormState>();
  final _keyFormGroup = GlobalKey<FormGroupState>();

  final TextEditingController _tenDonViController = TextEditingController();
  final TextEditingController _dauMoiLamViecController =
      TextEditingController();
  final TextEditingController _noiDungLamViecController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sdtController = TextEditingController();
  final scroll = ScrollController();

  @override
  void initState() {
    super.initState();
  }

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
                    dauMoiLienHe: _dauMoiLamViecController.text,
                    noidung: _noiDungLamViecController.text,
                    email: _emailController.text,
                    sdt: _sdtController.text,
                    vaiTroThamGia: 4,
                    tenDonVi: _tenDonViController.text,
                    tenCoQuan: _tenDonViController.text,
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
                        title: S.current.ten_don_vi,
                        child: TextFieldValidator(
                          controller: _tenDonViController,
                          hintText: S.current.ten_don_vi,
                          validator: (value) {
                            return (value ?? '').pleaseEnter(
                              S.current.ten_don_vi.toLowerCase(),
                            );
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: S.current.dau_moi_lam_viec,
                        child: TextFieldValidator(
                          controller: _dauMoiLamViecController,
                          hintText: S.current.dau_moi_lam_viec,
                          validator: (value) {
                            return (value ?? '').pleaseEnter(
                              S.current.dau_moi_lam_viec.toLowerCase(),
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
                            return (value ?? '').checkEmailBoolean(
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
