import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
    as p;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
    widget.cubit.init();
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
                        widget.cubit.addTaskHTKTRequest.name = value;
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
                      onChange: (value) {
                        widget.cubit.addTaskHTKTRequest.phone = value;
                      },
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
                      onChange: (value) {
                        widget.cubit.addTaskHTKTRequest.description = value;
                      },
                      validate: (value) {
                        if ((value ?? '').isEmpty) {
                          return S.current.khong_duoc_de_trong;
                        }
                      },
                    ),
                    spaceH16,
                    _dropDownKhuVuc(),
                    spaceH16,
                    _dropDownToaNha(),
                    spaceH16,
                    textField(
                      isHightLight: true,
                      title: S.current.so_phong,
                      hintText: S.current.so_phong,
                      onChange: (value) {
                        widget.cubit.addTaskHTKTRequest.room = value;
                      },
                      validate: (value) {
                        if ((value ?? '').isEmpty) {
                          return S.current.khong_duoc_de_trong;
                        }
                      },
                    ),
                    spaceH16,
                    _loaiSuCoMultiSelect(),
                    spaceH16,
                    TaiLieuWidget(
                      idRemove: (String id) {},
                      onChange: (files, value) {
                      },
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

  Widget _dropDownToaNha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<List<ChildCategories>>(
          stream: widget.cubit.listToaNha,
          builder: (context, snapshot) {
            final List<String> listResult =
                widget.cubit.getItemsToaNha(snapshot.data ?? []);
            return dropDownField(
              title: S.current.toa_nha,
              listData: listResult,
              function: (value) {
                widget.cubit.addTaskHTKTRequest.buildingName =
                    widget.cubit.listKhuVuc.value[value].name;
                widget.cubit.addTaskHTKTRequest.buildingId =
                    widget.cubit.listKhuVuc.value[value].id;
              },
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: widget.cubit.showErrorToaNha.stream,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      S.current.khong_duoc_de_trong,
                      style: textNormalCustom(
                        color: redChart,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Widget _dropDownKhuVuc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        dropDownField(
          hintText: S.current.chon,
          title: S.current.khu_vuc,
          listData:
              widget.cubit.listKhuVuc.value.map((e) => e.name ?? '').toList(),
          function: (value) {
            widget.cubit.addTaskHTKTRequest.districtName =
                widget.cubit.listKhuVuc.value[value].name;
            widget.cubit.addTaskHTKTRequest.districtId =
                widget.cubit.listKhuVuc.value[value].id;
            widget.cubit.listToaNha.add(
              widget.cubit.listKhuVuc.value[value].childCategories ?? [],
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: widget.cubit.showErrorKhuVuc.stream,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      S.current.khong_duoc_de_trong,
                      style: textNormalCustom(
                        color: redChart,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Widget _loaiSuCoMultiSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: S.current.loai_su_co,
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
        ),
        spaceH8,
        StreamBuilder<bool>(
          stream: widget.cubit.showHintDropDown.stream,
          builder: (context, snapshot) {
            return DropdownSearch<String>.multiSelection(
              dropdownSearchBaseStyle: textNormalCustom(
                color: color3D5586,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              items: widget.cubit.listLoaiSuCo.value
                  .map((e) => e.name ?? '')
                  .toList(),
              mode: Mode.MENU,
              dropdownBuilder: (context, value) {
                Widget item(String i) => Text(
                      '$i,',
                      style: textNormalCustom(
                        color: color3D5586,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                return (snapshot.data ?? true)
                    ? Text(
                        S.current.chon,
                        style: textNormalCustom(
                          color: color3D5586,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Wrap(
                        children: value.map((e) => item(e)).toList(),
                      );
              },
              popupSelectionWidget: (cnt, String item, bool isSelected) {
                return isSelected
                    ? const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: borderColor,
                        ),
                      )
                    : Container();
              },
              onChanged: (value) {
                widget.cubit.loaiSuCoValue = value;
                widget.cubit.addTaskHTKTRequest.danhSachSuCo =
                    widget.cubit.getIdListLoaiSuCo(value);
                widget.cubit.checkShowHintDropDown(value);
              },
              dropdownSearchDecoration: InputDecoration(
                hintText: S.current.chon,
                hintStyle: textNormalCustom(
                  color: titleItemEdit.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: borderColor.withOpacity(0.3),
                filled: false,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: widget.cubit.showErrorLoaiSuCo.stream,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      S.current.khong_duoc_de_trong,
                      style: textNormalCustom(
                        color: redChart,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
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
          widget.cubit.checkAllThemMoiYCHoTro();
          if (_groupKey.currentState?.validator() ??
              true && widget.cubit.validateAllDropDown) {
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
