import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/loai_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_bien_so_xe_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/custom_radio_loai_so_huu.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/widget/select_image_dang_ky_xe_moi.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/item_text_note.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/diem_danh_module/widget/stream/stream_listener.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DangKyThongTinXeMoi extends StatefulWidget {
  final DiemDanhCubit cubit;
  final ImagePermission imagePermission;

  const DangKyThongTinXeMoi(
      {Key? key, required this.cubit, required this.imagePermission})
      : super(key: key);

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
    widget.cubit.fileItemBienSoXe.clear();
    widget.cubit.loaiSoHuu = DanhSachBienSoXeConst.XE_CAN_BO;
    widget.cubit.xeMay = '';
    widget.cubit.isShowErrLoaiXe.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamListener<bool>(
      stream: widget.cubit.isMenuClickedSubject,
      listen: (value) {
        if (value) {
          widget.cubit.isMenuClickedSubject.add(false);
          Navigator.pop(context);
        }
      },
      child: screenDevice(
        mobileScreen: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: widget.cubit.stateStream,
          child: Scaffold(
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.only(bottom: 24.0, right: 16.0, left: 16.0),
              child: DoubleButtonBottom(
                title1: S.current.huy_bo,
                title2: S.current.them_moi,
                onClickLeft: () {
                  Navigator.pop(context);
                },
                onClickRight: () {
                  postDangKyXe();
                },
              ),
            ),
            resizeToAvoidBottomInset: true,
            appBar: BaseAppBar(
              title: S.current.dang_ky_thong_tin_xe_moi,
              leadingIcon: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: SvgPicture.asset(
                  ImageAssets.icBack,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    DrawerSlide.navigatorSlide(
                      context: context,
                      screen: DiemDanhMenuMobile(
                        isThemBienSo: true,
                        cubit: widget.cubit,
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    ImageAssets.icMenuCalender,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FormGroup(
                  key: keyGroup,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SelectImageDangKyXe(
                        imagePermission: widget.imagePermission,
                        isPhone: true,
                        onTapImage: (image) {
                          if (image != null) {
                            widget.cubit.fileItemBienSoXe.clear();
                            widget.cubit.fileItemBienSoXe.add(image);
                          }
                        },
                        removeImage: () {
                          widget.cubit.fileItemBienSoXe.clear();
                        },
                        isTao: true,
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
                            initData: '',
                            placeHoder: S.current.chon_loai_xe,
                            useCustomHintColors: true,
                            listData: data.map((e) => e.ten ?? '').toList(),
                            onChange: (vl) {
                              vl == 0
                                  ? widget.cubit.xeMay =
                                      DanhSachBienSoXeConst.XE_MAY
                                  :  widget.cubit.xeMay =
                                          DanhSachBienSoXeConst.O_TO;
                              widget.cubit.isShowErrLoaiXe.add(false);
                            },
                          );
                        },
                      ),
                      StreamBuilder<bool>(
                        stream: widget.cubit.isShowErrLoaiXe,
                        builder: (context, snapshot) {
                          final isShow = snapshot.data ?? false;
                          return Visibility(
                            visible: isShow,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.current.truong_bat_buoc,
                                style: textNormalCustom(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
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
                        onchange: (isXeLanhDao) {
                          widget.cubit.loaiSoHuu = isXeLanhDao
                              ? DanhSachBienSoXeConst.XE_LANH_DAO
                              : DanhSachBienSoXeConst.XE_CAN_BO;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        tabletScreen: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: widget.cubit.stateStream,
          child: Scaffold(
            backgroundColor: colorF9FAFF,
            resizeToAvoidBottomInset: true,
            appBar: BaseAppBar(
              title: S.current.dang_ky_thong_tin_xe_moi,
              leadingIcon: IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: SvgPicture.asset(
                  ImageAssets.icBack,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    DrawerSlide.navigatorSlide(
                      context: context,
                      screen: DiemDanhMenuMobile(
                        isThemBienSo: true,
                        cubit: widget.cubit,
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    ImageAssets.icMenuCalender,
                  ),
                )
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 28),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormGroup(
                        key: keyGroup,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SelectImageDangKyXe(
                              imagePermission: widget.imagePermission,
                              isPhone: false,
                              onTapImage: (image) {
                                if (image != null) {
                                  widget.cubit.fileItemBienSoXe.clear();
                                  widget.cubit.fileItemBienSoXe.add(image);
                                }
                              },
                              removeImage: () {},
                              isTao: true,
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
                                return Container(
                                  color: colorFFFFFF,
                                  child: CoolDropDown(
                                    initData: '',
                                    placeHoder: S.current.chon_loai_xe,
                                    fontSize: 14.0,
                                    useCustomHintColors: true,
                                    listData:
                                        data.map((e) => e.ten ?? '').toList(),
                                    onChange: (value) {
                                      value == 0
                                          ? widget.cubit.xeMay =
                                          DanhSachBienSoXeConst.XE_MAY
                                          :  widget.cubit.xeMay =
                                          DanhSachBienSoXeConst.O_TO;
                                      widget.cubit.isShowErrLoaiXe.add(false);
                                    },
                                  ),
                                );
                              },
                            ),
                            StreamBuilder<bool>(
                              stream: widget.cubit.isShowErrLoaiXe,
                              builder: (context, snapshot) {
                                final isShow = snapshot.data ?? false;
                                return Visibility(
                                  visible: isShow,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.current.truong_bat_buoc,
                                      style: textNormalCustom(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            spaceH20,
                            ItemTextNote(title: S.current.bien_kiem_soat),
                            TextFieldValidator(
                              fillColor: colorFFFFFF,
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
                                  fontSize: 14.0.textScale(),
                                ),
                              ),
                            ),
                            CustomRadioLoaiSoHuu(
                              onchange: (isXeLanhDao) {
                                widget.cubit.loaiSoHuu = isXeLanhDao
                                    ? DanhSachBienSoXeConst.XE_LANH_DAO
                                    : DanhSachBienSoXeConst.XE_CAN_BO;
                              },
                            ),
                          ],
                        ),
                      ),
                      spaceH32,
                      SizedBox(
                        width: 300,
                        height: 44,
                        child: DoubleButtonBottom(
                          title1: S.current.huy_bo,
                          title2: S.current.them_moi,
                          onClickLeft: () {
                            Navigator.pop(context);
                          },
                          onClickRight: () {
                            postDangKyXe();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postDangKyXe() async {
    final bool isFormValidated = keyGroup.currentState?.validator() ?? false;
    widget.cubit.isShowErrLoaiXe.add(widget.cubit.xeMay?.isEmpty ?? true);
    if (widget.cubit.fileItemBienSoXe.isEmpty) {
      widget.cubit.toast.removeQueuedCustomToasts();
      widget.cubit.toast.showToast(
        child: ShowToast(
          text: S.current.vui_long_them_anh_giay_dang_ky_xe,
        ),
        gravity: ToastGravity.TOP_RIGHT,
      );
      return;
    }
    if (isFormValidated && !widget.cubit.isShowErrLoaiXe.value) {
      await widget.cubit.postImageResgiter(
        bienKiemSoat: bienKiemSoatController.value.text.removeSpace,
        context: context,
        isTao: true,
      );
      return;
    }
  }
}
