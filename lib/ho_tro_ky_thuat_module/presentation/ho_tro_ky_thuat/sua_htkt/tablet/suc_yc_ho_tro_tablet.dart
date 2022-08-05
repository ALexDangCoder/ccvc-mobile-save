import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
    as p;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuaDoiYcHoTroTablet extends StatefulWidget {
  const SuaDoiYcHoTroTablet({
    Key? key,
    required this.cubit,
    required this.idHTKT,
    required this.idKhuVuc,
  }) : super(key: key);
  final HoTroKyThuatCubit cubit;
  final String idHTKT;

  final String idKhuVuc;

  @override
  State<SuaDoiYcHoTroTablet> createState() => _SuaDoiYcHoTroTabletState();
}

class _SuaDoiYcHoTroTabletState extends State<SuaDoiYcHoTroTablet> {
  final _groupKey = GlobalKey<FormGroupState>();

  @override
  void initState() {
    widget.cubit.init();
    widget.cubit.loadApiEditYCHT(id: widget.idHTKT, idKhuVuc: widget.idKhuVuc);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.cubit.disposeEdit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StateStreamLayout(
        stream: widget.cubit.stateStream,
        textEmpty: '',
        retry: () {
          widget.cubit
              .loadApiEditYCHT(id: widget.idHTKT, idKhuVuc: widget.idKhuVuc);
        },
        error: AppException(S.current.something_went_wrong, ''),
        child: Center(
          child: Container(
            height: 836,
            width: 592,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: shadowContainerColor.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                spaceH20,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.chinh_sua_htkt,
                        style: p.textNormalCustom(
                          color: textTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          ImageAssets.icClose,
                          color: AppTheme.getInstance().unselectedLabelColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 22.5,
                            bottom: 16,
                          ),
                          child: FormGroup(
                            key: _groupKey,
                            child: StreamBuilder<SupportDetail>(
                              stream: widget.cubit.editModelHTKT.stream,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? SupportDetail();
                                if (data.id != null) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textField(
                                        controller: TextEditingController(
                                            text: data.tenThietBi),
                                        initValue: data.tenThietBi,
                                        isHightLight: true,
                                        title: S.current.ten_thiet_bi,
                                        hintText: S.current.ten_thiet_bi,
                                        isEnable: true,
                                        maxLength: 150,
                                        onChange: (value) {
                                          widget.cubit.editTaskHTKTRequest
                                              .name = value;
                                        },
                                        validate: (value) {
                                          if ((value ?? '').isEmpty) {
                                            return S.current
                                                .ban_phai_nhap_truong_ten_thiet_bi;
                                          }
                                        },
                                      ),
                                      spaceH16,
                                      textField(
                                        initValue: data.soDienThoai,
                                        isHightLight: true,
                                        title: S.current.sdt_lien_he,
                                        hintText: S.current.sdt_lien_he,
                                        inputFormatter: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        maxLength: 11,
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          widget.cubit.editTaskHTKTRequest
                                              .phone = value;
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
                                        initValue: data.moTaSuCo,
                                        isHightLight: true,
                                        maxLine: 3,
                                        title: S.current.mo_ta_su_co,
                                        hintText: S.current.mo_ta_su_co,
                                        onChange: (value) {
                                          widget.cubit.editTaskHTKTRequest
                                              .description = value;
                                        },
                                        validate: (value) {
                                          if ((value ?? '').isEmpty) {
                                            return S.current
                                                .ban_phai_nhap_truong_mo_ta_su_co;
                                          }
                                        },
                                      ),
                                      spaceH16,
                                      AreaDropDown(
                                        cubit: widget.cubit,
                                        statusHTKT: StatusHTKT.EDIT,
                                      ),
                                      spaceH16,
                                      BuildingDropDown(
                                        statusHTKT: StatusHTKT.EDIT,
                                        cubit: widget.cubit,
                                      ),
                                      spaceH16,
                                      textField(
                                        initValue: data.room,
                                        isHightLight: true,
                                        title: S.current.so_phong,
                                        hintText: S.current.so_phong,
                                        onChange: (value) {
                                          widget.cubit.editTaskHTKTRequest
                                              .room = value;
                                        },
                                        validate: (value) {
                                          if ((value ?? '').isEmpty) {
                                            return S.current
                                                .ban_phai_nhap_truong_so_phong;
                                          }
                                        },
                                      ),
                                      spaceH16,
                                      _multiSelect(),
                                      spaceH16,
                                      TaiLieuWidget(
                                        isHaveExpanded: true,
                                        files: widget.cubit.editModelHTKT.value
                                            .filesDinhKem
                                            ?.map(
                                              (e) => Files(
                                                id: e.id,
                                                name: e.fileName,
                                                extension: null,
                                                size: null,
                                                path: e.filePath,
                                                entityId: null,
                                                entityName: null,
                                                fileId: e.fileId,
                                                taskId: e.taskId,
                                              ),
                                            )
                                            .toList(),
                                        onChange: (files, value) {
                                          widget.cubit.editTaskHTKTRequest
                                              .fileUpload = files;
                                        },
                                        idRemove: (String id) {
                                          widget.cubit.removeFileId(id);
                                        },
                                      ),
                                      spaceH20,
                                      _doubleBtn(),
                                    ],
                                  );
                                } else {
                                  return Container(
                                    color: Colors.transparent,
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _multiSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<String>>(
          stream: widget.cubit.issueListStream,
          builder: (context, snapshot) {
            final _issueList = snapshot.data ?? [];
            return MultiSelectList(
              cubit: widget.cubit,
              isInit: widget.cubit.isLoadDidUpdateWidget,
              initSelectedItems: widget.cubit.issuesEditHTKT
                  .map((e) => e.tenSuCo ?? '')
                  .toList(),
              title: S.current.loai_su_co,
              isRequire: true,
              items: _issueList,
              onChange: (selectIndexList) {
                widget.cubit.addIssuesEdit(selectIndexList);
                widget.cubit.checkAllEditYCHT();
              },
              onChangeSearch: (String? value) {},
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
                      S.current.ban_phai_nhap_truong_loai_su_co,
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
    String? initValue,
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
          initialValue: initValue,
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
          items: listData,
        )
      ],
    );
  }

  Widget _doubleBtn() => DoubleButtonBottom(
        isTablet: true,
        onClickLeft: () {
          Navigator.pop(context);
        },
        onClickRight: () {
          widget.cubit.checkAllEditYCHT();
          if ((_groupKey.currentState?.validator() ?? true) &&
              widget.cubit.validateAllDropDown) {
            widget.cubit.postEditHTKT().then((value) {
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
