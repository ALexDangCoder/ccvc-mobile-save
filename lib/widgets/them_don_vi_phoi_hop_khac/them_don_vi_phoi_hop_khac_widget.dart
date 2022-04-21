import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemDonViPhoiHopKhacWidget extends StatefulWidget {
  final Function(List<DonViModel> value) onChange;

  const ThemDonViPhoiHopKhacWidget({
    Key? key,
    required this.onChange,
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
          text: S.current.them_thanh_phan_tham_gia,
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
                  child: ItemThanhPhanWidget(
                    data: data[index],
                    cubit: cubit,
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

class ItemThanhPhanWidget extends StatelessWidget {
  final DonViModel data;
  final ThanhPhanThamGiaCubit cubit;

  const ItemThanhPhanWidget({
    Key? key,
    required this.data,
    required this.cubit,
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
                      style: textNormal(titleColor, 14.0.textScale()),
                    ),
                  )
                ],
              )
            ],
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
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: textNormal(titleColor, 14.0.textScale()),
          ),
        )
      ],
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
          child: DoubleButtonBottom(
            isTablet: isMobile() == false,
            title1: S.current.dong,
            title2: S.current.them,
            onPressed1: () {
              Navigator.pop(context);
            },
            onPressed2: () {
              if (_keyFormGroup.currentState!.validator()) {
                widget.cubit.addDonViPhoiHopKhac(
                  DonViModel(
                    id: '',
                    name: _tenDonViController.text,
                    dauMoiLienHe: _dauMoiLamViecController.text,
                    noidung: _noiDungLamViecController.text,
                    email: _emailController.text,
                    sdt: _sdtController.text,
                    vaiTroThamGia: 4,
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
                reverse: true,
                child: FormGroup(
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
                            return (value ?? '').checkNull();
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: S.current.dau_moi_lam_viec,
                        child: TextFieldValidator(
                          controller: _dauMoiLamViecController,
                          hintText: S.current.dau_moi_lam_viec,
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
                          suffixIcon: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                                child: SvgPicture.asset(ImageAssets.ic_email)),
                          ),
                          validator: (value) {
                            return (value ?? '').checkEmail();
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: S.current.so_dien_thoai,
                        child: TextFieldValidator(
                          controller: _sdtController,
                          hintText: S.current.so_dien_thoai,
                          suffixIcon: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: SvgPicture.asset(ImageAssets.icPhone),
                            ),
                          ),
                          validator: (value) {
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
