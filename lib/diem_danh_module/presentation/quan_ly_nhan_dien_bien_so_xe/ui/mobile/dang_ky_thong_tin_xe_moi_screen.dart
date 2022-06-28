import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_bien_so_xe_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/custom_radio_loai_so_huu.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/item_text_note.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DangKyThongTinXeMoi extends StatefulWidget {
  DiemDanhCubit cubit;

  DangKyThongTinXeMoi({Key? key, required this.cubit}) : super(key: key);

  @override
  State<DangKyThongTinXeMoi> createState() => _DangKyThongTinXeMoiState();
}

class _DangKyThongTinXeMoiState extends State<DangKyThongTinXeMoi> {
  TextEditingController bienKiemSoatController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();
  @override
  void initState() {
    super.initState();
    widget.cubit.toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefaultBack(
        S.current.dang_ky_thong_tin_xe_moi,
      ),
      body:  StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.cubit.stateStream,
        child: ProviderWidget<DiemDanhCubit>(
          cubit: widget.cubit,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FormGroup(
                  key: keyGroup,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: colorE2E8F0),
                          borderRadius: BorderRadius.circular(8.0),
                          color: colorFFFFFF,
                          boxShadow: const [
                            BoxShadow(
                              color: shadow,
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImageAssets.icUpAnh,
                              color: color7966FF,
                            ),
                            spaceH14,
                            Text(
                              S.current.tai_anh_len,
                              style: textNormal(
                                color667793,
                                14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH12,
                      Text(
                        S.current.giay_dang_ky_xe,
                        style: textNormalCustom(
                          color: color3D5586,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      spaceH20,
                      ItemTextNote(title: S.current.loai_xe),
                      StreamBuilder<List<LoaiXeModel>>(
                        initialData: [
                          LoaiXeModel(ten: S.current.xe_may),
                          LoaiXeModel(ten: S.current.xe_o_to),
                        ],
                        stream: widget.cubit.loaiXeSubject,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return CoolDropDown(
                            initData: data.map((e) => e.ten ?? '').first,
                            listData: data.map((e) => e.ten ?? '').toList(),
                            onChange: (vl) {
                              vl == 0
                                  ? widget.cubit.xeMay =
                                      DanhSachBienSoXeConst.XE_MAY
                                  : widget.cubit.xeMay = DanhSachBienSoXeConst.O_TO;
                            },
                          );
                        },
                      ),
                      spaceH20,
                      ItemTextNote(title: S.current.bien_kiem_soat),
                      TextFieldValidator(
                        controller: bienKiemSoatController,
                        hintText: S.current.bien_kiem_soat,
                        onChange: (value) {},
                        validator: (value) {
                          return (value ?? '')
                              .checkTruongNull('${S.current.bien_kiem_soat}!');
                        },
                      ),
                      spaceH20,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.current.loai_so_huu,
                          style: textNormalCustom(
                            color: color3D5586,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      CustomRadioLoaiSoHuu(onchange: (onchange) {
                        onchange
                            ? widget.cubit.loaiSoHuu =
                                DanhSachBienSoXeConst.XE_LANH_DAO
                            : widget.cubit.loaiSoHuu =
                                DanhSachBienSoXeConst.XE_CAN_BO;
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: DoubleButtonBottom(
                    title1: S.current.huy_bo,
                    title2: S.current.them_moi,
                    onPressed1: () {
                      Navigator.pop(context);
                    },
                    onPressed2: () async {
                      if (keyGroup.currentState!.validator()) {
                        await widget.cubit.dangKyThongTinXeMoi(
                          bienKiemSoatController.value.text,
                          context
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
