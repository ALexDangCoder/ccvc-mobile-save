import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
    as p;
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

///cho phép chỉnh sửa các text filed khi trạng thái đang chờ
class ThemMoiYCHoTroMobile extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const ThemMoiYCHoTroMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThemMoiYCHoTroMobile> createState() => _ThemMoiYCHoTroMobileState();
}

class _ThemMoiYCHoTroMobileState extends State<ThemMoiYCHoTroMobile> {
  final _groupKey = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH20,
            Center(
              child: Container(
                height: 6,
                width: 48,
                decoration: const BoxDecoration(
                  color: colorECEEF7,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 22.5,
                bottom: 16,
              ),
              child: FormGroup(
                key: _groupKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.them_moi_yc_ho_tro,
                      style: p.textNormalCustom(
                        color: textTitle,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    spaceH20,
                    textField(
                      isHightLight: true,
                      title: S.current.ten_thiet_bi,
                      hintText: S.current.ten_thiet_bi,
                      isEnable: true,
                      maxLength: 150,
                      onChange: (value) {
                      },
                      validate: (value) {
                        if ((value ?? '').isEmpty) {
                          return S.current.khong_duoc_de_trong;
                        }
                      },
                    ),
                    spaceH16,
                    textField(
                      isHightLight: true,
                      title: S.current.sdt_lien_he,
                      hintText: S.current.sdt_lien_he,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 11,
                      textInputType: TextInputType.number,
                      onChange: (value) {},
                      validate: (value) {
                        if ((value ?? '').isEmpty) {
                          return S.current.khong_duoc_de_trong;
                        } else {
                          return null;
                        }
                      },
                    ),
                    spaceH16,
                    textField(
                      isHightLight: true,
                      maxLine: 3,
                      title: S.current.nhap_mo_ta,
                      hintText: S.current.nhap_mo_ta,
                      onChange: (value) {},
                      validate: (value) {
                        if ((value ?? '').isEmpty) {
                          return S.current.khong_duoc_de_trong;
                        }
                      },
                    ),
                    spaceH16,
                    dropDownField(
                      hintText: S.current.chon,
                      title: S.current.khu_vuc,
                      listData: widget.cubit.listKhuVuc.value
                          .map((e) => e.name ?? '')
                          .toList(),
                      function: (value) {
                        widget.cubit.listToaNha.add(
                          widget.cubit.listKhuVuc.value[value]
                                  .childCategories ??
                              [],
                        );
                      },
                    ),
                    spaceH16,
                    StreamBuilder<List<ChildCategories>>(
                      stream: widget.cubit.listToaNha,
                      builder: (context, snapshot) {
                        final List<String> listResult =
                            widget.cubit.getList(snapshot.data ?? []);
                        final String initData = listResult.first;
                        return dropDownField(
                          title: S.current.toa_nha,
                          listData: listResult,
                          function: (value) {},
                        );
                      },
                    ),
                    spaceH16,
                    textField(
                      isHightLight: true,
                      title: S.current.so_phong,
                      hintText: S.current.so_phong,
                      onChange: (value) {},
                      validate: (value) {
                        if ((value ?? '').isEmpty) {
                          return S.current.khong_duoc_de_trong;
                        }
                      }
                    ),
                    spaceH16,
                    dropDownField(
                      title: S.current.loai_su_co,
                      initData:
                          widget.cubit.listLoaiSuCo.value.first.name ?? '',
                      listData: widget.cubit.listLoaiSuCo.value
                          .map((e) => e.name ?? '')
                          .toList(),
                      function: (value) {},
                    ),
                    spaceH16,
                    TaiLieuWidget(
                      idRemove: (String id) {},
                      onChange: (files, value) {},
                    ),
                    spaceH20,
                    doubleBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
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
    bool isHightLight = false,
    int? maxLength,
    bool? isEnable,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isHightLight)
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
                TextSpan(
                  text: ' *',
                  style: tokenDetailAmount(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )
        else
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
        TextFieldValidator(
          hintText: hintText,
          onChange: onChange,
          maxLine: maxLine,
          validator: validate,
          inputFormatters: inputFormatter,
          textInputType: textInputType,
          maxLength: maxLength,
          isEnabled: isEnable ?? true,
        ),
      ],
    );
  }

  Widget dropDownField({
    String? hintText,
    int maxLine = 1,
    String? initData,
    required List<String> listData,
    required String title,
    required Function(int) function,
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
          initData: initData ?? S.current.chon,
          placeHoder: S.current.chon,
          onChange: (value) => function(value),
          listData: listData,
          key: UniqueKey(),
        )
      ],
    );
  }

  Widget doubleBtn() => DoubleButtonBottom(
    onPressed1: () {
      Navigator.pop(context);
    },
    onPressed2: () {
      if (_groupKey.currentState?.validator() ?? true) {
        print('-1---okla');
      } else {
        final toast = FToast();
        toast.init(context);
        toast.showToast(
          child: ShowToast(
            text: S.current.sai_dinh_dang_truong,
          ),
          gravity: ToastGravity.BOTTOM,
        );
      }
    },
    title1: S.current.dong,
    title2: S.current.gui_yc,
  );
}
