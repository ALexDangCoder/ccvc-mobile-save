import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
as p;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/create_tech_suport.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/them_htkt/mobile/widget/area_drop_down.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/them_htkt/mobile/widget/building_drop_down.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dialog/show_toat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/multi_select_list/multi_select_list.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    widget.cubit.init();
    widget.cubit.getApiThemMoiYCHT();
    super.initState();
  }

  @override
  void dispose() {
    widget.cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StateStreamLayout(
        stream: widget.cubit.stateStream,
        textEmpty: '',
        retry: () {
          widget.cubit.getApiThemMoiYCHT();
        },
        error: AppException(S.current.something_went_wrong, ''),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 700,
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
                                return S
                                    .current.ban_phai_nhap_truong_ten_thiet_bi;
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
                                return S.current
                                    .ban_phai_nhap_truong_so_dien_thoai_lien_he;
                              } else {
                                return null;
                              }
                            },
                          ),
                          spaceH16,
                          textField(
                            isHightLight: true,
                            maxLine: 3,
                            title: S.current.mo_ta_su_co,
                            hintText: S.current.mo_ta_su_co,
                            onChange: (value) {
                              widget.cubit.addTaskHTKTRequest.description =
                                  value;
                            },
                            validate: (value) {
                              if ((value ?? '').isEmpty) {
                                return S
                                    .current.ban_phai_nhap_truong_mo_ta_su_co;
                              }
                            },
                          ),
                          spaceH16,
                          AreaDropDown(
                            cubit: widget.cubit,
                            statusHTKT: StatusHTKT.CREATE,
                          ),
                          spaceH16,
                          BuildingDropDown(
                            statusHTKT: StatusHTKT.CREATE,
                            cubit: widget.cubit,
                          ),
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
                                return S.current.ban_phai_nhap_truong_so_phong;
                              }
                            },
                          ),
                          spaceH16,
                          StreamBuilder<List<String>>(
                            stream: widget.cubit.issueListStream.stream,
                            builder: (context, snapshot) {
                              final _issueList = snapshot.data ?? [];
                              return MultiSelectList(
                                isInit: false,
                                cubit: widget.cubit,
                                title: S.current.loai_su_co,
                                isRequire: true,
                                items: _issueList,
                                onChange: (selectIndexList) {
                                  widget.cubit.addIssueListRequest(
                                    selectIndexList,
                                  );
                                  if (selectIndexList.isNotEmpty) {
                                    widget.cubit.showErrorLoaiSuCo.add(false);
                                  } else {
                                    widget.cubit.showErrorLoaiSuCo.add(true);
                                  }
                                },
                              );
                            },
                          ),
                          StreamBuilder<bool>(
                            initialData: false,
                            stream: widget.cubit.showErrorLoaiSuCo.stream,
                            builder: (context, snapshot) {
                              return snapshot.data ?? false
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 8.0,
                                ),
                                child: Text(
                                  S.current
                                      .ban_phai_nhap_truong_loai_su_co,
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
                          spaceH16,
                          TaiLieuWidget(
                            isHaveExpanded: true,
                            isTitle: false,
                            idRemove: (String id) {},
                            onChange: (files, value) {
                              widget.cubit.addTaskHTKTRequest.fileUpload =
                                  files;
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
          ),
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
    TextEditingController? controller,
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
          controller: controller,
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
    required String value,
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
        CustomDropDown(
          hint: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: S.current.chon,
                  style: tokenDetailAmount(
                    fontSize: 14,
                    color: color3D5586,
                  ),
                ),
              ],
            ),
          ),
          value: value,
          onSelectItem: (value) => function(value),
          // value: S.current.chon,
          items: listData,
        )
      ],
    );
  }

  Widget doubleBtn() =>
      DoubleButtonBottom(
        onClickLeft: () {
          Navigator.pop(context);
        },
        onClickRight: () {
          widget.cubit.checkAllThemMoiYCHoTro();
          if ((_groupKey.currentState?.validator() ?? true) &&
              widget.cubit.validateAllDropDown) {
            widget.cubit.postDataThemMoiHTKT().then((value) {
              if (value) {
                final FToast toast = FToast();
                toast.init(context);
                toast.showToast(
                  child: ShowToast(
                    text: S.current.luu_du_lieu_thanh_cong,
                    icon: ImageAssets.icSucces,
                  ),
                  gravity: ToastGravity.BOTTOM,
                );
                Navigator.pop(context);
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
            });
          } else {}
        },
        title1: S.current.dong,
        title2: S.current.gui_yc,
      );
}
