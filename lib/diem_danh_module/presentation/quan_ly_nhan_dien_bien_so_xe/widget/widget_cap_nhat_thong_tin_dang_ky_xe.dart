import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_bien_so_xe_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/custom_radio_loai_so_huu.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/select_image_dang_ky_xe_moi.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/item_text_note.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetCapNhatThongTinDangKyXe extends StatefulWidget {
  final BuildContext context;
  final DiemDanhCubit cubit;
  final ChiTietBienSoXeModel chiTietBienSoXeModel;
  final ImagePermission imagePermission;

  const WidgetCapNhatThongTinDangKyXe({
    Key? key,
    required this.cubit,
    required this.chiTietBienSoXeModel,
    required this.context,
    required this.imagePermission,
  }) : super(key: key);

  @override
  _WidgetCapNhatThongTinDangKyXeState createState() =>
      _WidgetCapNhatThongTinDangKyXeState();
}

class _WidgetCapNhatThongTinDangKyXeState
    extends State<WidgetCapNhatThongTinDangKyXe> {
  TextEditingController bienKiemSoatController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();
  bool hasImage = true;

  @override
  void initState() {
    super.initState();
    widget.cubit.toast.init(widget.context);
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
              onClickLeft: () {
                Navigator.pop(widget.context);
                widget.cubit.fileItemBienSoXe.clear();
              },
              onClickRight: () {
                if (hasImage == false) {
                  widget.cubit.toast.removeQueuedCustomToasts();
                  widget.cubit.toast.showToast(
                    child: ShowToast(
                      text: S.current.vui_long_them_anh_giay_dang_ky_xe,
                    ),
                    gravity: ToastGravity.TOP_RIGHT,
                  );
                  return;
                }
                if (keyGroup.currentState!.validator()) {
                  Navigator.pop(context);
                  widget.cubit.postImageResgiter(
                    bienKiemSoat: bienKiemSoatController.value.text,
                    isTao: false,
                    id: widget.chiTietBienSoXeModel.id ?? '',
                    fileId: widget.chiTietBienSoXeModel.fileId ?? '',
                    context: widget.context,
                  );
                }
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
                child: FormGroup(
                  key: keyGroup,
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
                                imagePermission: widget.imagePermission,
                                isPhone: true,
                                image: widget.cubit.getUrlImageBienSoXe(
                                    widget.chiTietBienSoXeModel.fileId),
                                onTapImage: (image) {
                                  if (image != null) {
                                    widget.cubit.fileItemBienSoXe.clear();
                                    widget.cubit.fileItemBienSoXe.add(image);
                                    hasImage = true;
                                  }
                                },
                                removeImage: () {
                                  hasImage = false;
                                  widget.cubit.fileItemBienSoXe.clear();
                                },
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
                            initData: widget.chiTietBienSoXeModel.loaiXeMay
                                    ?.loaiXe() ??
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
                      TextFieldValidator(
                        controller: bienKiemSoatController,
                        hintText: S.current.nhap_bien_kiem_soat,
                        onChange: (value) {},
                        validator: (value) {
                          return (value ?? '').checkTruongNull(
                            '',
                            isCheckLength: true,
                            isTruongBatBuoc: true,
                          );
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
            ),
          ],
        ),
      ),
    );
  }
}
