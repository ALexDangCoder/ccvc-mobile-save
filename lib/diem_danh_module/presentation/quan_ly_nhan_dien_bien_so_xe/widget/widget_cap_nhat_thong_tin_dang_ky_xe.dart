import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_bien_so_xe_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/custom_radio_loai_so_huu.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/select_image_dang_ky_xe_moi.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/item_text_note.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';

class WidgetCapNhatThingTinDangKyXe extends StatefulWidget {
  final DiemDanhCubit cubit;
  final ChiTietBienSoXeModel chiTietBienSoXeModel;

  const WidgetCapNhatThingTinDangKyXe({
    Key? key,
    required this.cubit,
    required this.chiTietBienSoXeModel,
  }) : super(key: key);

  @override
  _WidgetCapNhatThingTinDangKyXeState createState() =>
      _WidgetCapNhatThingTinDangKyXeState();
}

class _WidgetCapNhatThingTinDangKyXeState
    extends State<WidgetCapNhatThingTinDangKyXe> {
  TextEditingController bienKiemSoatController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
    bienKiemSoatController.text =
        widget.chiTietBienSoXeModel.bienKiemSoat ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 30),
          child: SizedBox(
            width: isMobile() ? MediaQuery.of(context).size.width : 300,
            child: DoubleButtonBottom(
              title1: S.current.huy,
              title2: S.current.cap_nhat,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                if (keyGroup.currentState!.validator()) {}
              },
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    spaceH20,
                    Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SelectImageDangKyXe(
                              isPhone: true,
                              image: widget.cubit.getUrlImageBienSoXe(
                                  widget.chiTietBienSoXeModel.pictureId),
                              onTapImage: (image) {
                                if (image != null) {
                                  widget.cubit.fileItemBienSoXe.clear();
                                  widget.cubit.fileItemBienSoXe.add(image);
                                }
                              },
                              removeImage: () {},
                              isTao: false,
                            ),
                          ],
                        ),
                      ],
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
                          initData:
                              widget.chiTietBienSoXeModel.loaiXeMay?.loaiXe() ??
                                  S.current.xe_may,
                          listData: data.map((e) => e.ten ?? '').toList(),
                          onChange: (value) {
                            value == 0
                                ? widget.cubit.xeMay =
                                    DanhSachBienSoXeConst.XE_MAY
                                : widget.cubit.xeMay =
                                    DanhSachBienSoXeConst.O_TO;
                          },
                        );
                      },
                    ),
                    spaceH20,
                    ItemTextNote(title: S.current.bien_kiem_soat),
                    FormGroup(
                      key: keyGroup,
                      child: TextFieldValidator(
                        controller: bienKiemSoatController,
                        hintText: S.current.bien_kiem_soat,
                        onChange: (value) {},
                        validator: (value) {
                          return (value ?? '')
                              .checkTruongNull('${S.current.bien_kiem_soat}!');
                        },
                      ),
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
                    CustomRadioLoaiSoHuu(
                      onchange: (onchange) {
                        onchange
                            ? widget.cubit.loaiSoHuu =
                                DanhSachBienSoXeConst.XE_LANH_DAO
                            : widget.cubit.loaiSoHuu =
                                DanhSachBienSoXeConst.XE_CAN_BO;
                      },
                      groupValueInit:
                          widget.chiTietBienSoXeModel.loaiSoHuu?.loaiSoHuu(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
