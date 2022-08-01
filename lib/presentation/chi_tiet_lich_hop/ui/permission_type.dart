
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/cong_tac_chuan_bi_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cu_can_bo_di_thay_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cu_can_bo_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/phan_cong_thu_ky.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/sua_lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thu_hoi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/radio_option_dialog.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum PERMISSION_DETAIL {
  THU_HOI,
  XOA,
  SUA,
  CU_CAN_BO,
  TU_CHOI_THAM_GIA,
  DUYET_LICH,
  PHAN_CONG_THU_KY,
  CU_CAN_BO_DI_THAY,
  TAO_BOC_BANG_CUOC_HOP,
  HUY_LICH,
  XAC_NHAN_THAM_GIA,
  HUY_XAC_NHAN,
  XAC_NHAN_LAI,
  TU_CHOI,
  HUY_DUYET
}

enum PERMISSION_TAB {
  HUY_DUYET,
  TU_CHOI,
  DUYET,
  DUYET_KY_THUAT,
  TU_CHOI_DUYET_KY_THUAT,
  HUY_DUYET_KY_THUAT,
}

extension GetDataPermissionTab on PERMISSION_TAB {
  String getString() {
    switch (this) {
      case PERMISSION_TAB.DUYET:
        return S.current.duyet;
      case PERMISSION_TAB.TU_CHOI:
        return S.current.tu_choi;
      case PERMISSION_TAB.HUY_DUYET:
        return S.current.huy_duyet;
      case PERMISSION_TAB.DUYET_KY_THUAT:
        return S.current.duyet_ky_thuat;
      case PERMISSION_TAB.TU_CHOI_DUYET_KY_THUAT:
        return S.current.tu_choi_duyet_ky_thuat;
      case PERMISSION_TAB.HUY_DUYET_KY_THUAT:
        return S.current.huy_duyet_ky_thuat;
    }
  }
}

extension GetDataPermission on PERMISSION_DETAIL {
  String getString() {
    switch (this) {
      case PERMISSION_DETAIL.THU_HOI:
        return S.current.thu_hoi;
      case PERMISSION_DETAIL.XOA:
        return S.current.xoa_lich;
      case PERMISSION_DETAIL.SUA:
        return S.current.sua_lich;
      case PERMISSION_DETAIL.CU_CAN_BO:
        return S.current.cu_can_bo;
      case PERMISSION_DETAIL.TU_CHOI_THAM_GIA:
        return S.current.tu_choi_tham_gia;
      case PERMISSION_DETAIL.DUYET_LICH:
        return S.current.duyet_lich;
      case PERMISSION_DETAIL.PHAN_CONG_THU_KY:
        return S.current.phan_cong_thu_ky;
      case PERMISSION_DETAIL.CU_CAN_BO_DI_THAY:
        return S.current.cu_can_bo_di_thay;
      case PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP:
        return S.current.tao_boc_bang_cuoc_hop;
      case PERMISSION_DETAIL.HUY_LICH:
        return S.current.huy_lich;
      case PERMISSION_DETAIL.XAC_NHAN_THAM_GIA:
        return S.current.xac_nhan_tham_gia;
      case PERMISSION_DETAIL.HUY_XAC_NHAN:
        return S.current.huy_xac_nhan;
      case PERMISSION_DETAIL.XAC_NHAN_LAI:
        return S.current.xac_nhan_lai;
      case PERMISSION_DETAIL.TU_CHOI:
        return S.current.tu_choi;
      case PERMISSION_DETAIL.HUY_DUYET:
        return S.current.huy_duyet;
    }
  }

  String getIcon() {
    switch (this) {
      case PERMISSION_DETAIL.THU_HOI:
        return checkDevice(
          iconMobile: ImageAssets.icThuHoi,
          iconTablet: ImageAssets.icThuHoi,
        );
      case PERMISSION_DETAIL.XOA:
        return checkDevice(
          iconMobile: ImageAssets.ic_delete_do,
          iconTablet: ImageAssets.ic_delete_do,
        );
      case PERMISSION_DETAIL.SUA:
        return checkDevice(
          iconMobile: ImageAssets.icEditBlue,
          iconTablet: ImageAssets.icEditBlue,
        );
      case PERMISSION_DETAIL.PHAN_CONG_THU_KY:
        return checkDevice(
          iconMobile: ImageAssets.icPhanCongThuKy,
          iconTablet: ImageAssets.icPhanCongThuKy,
        );
      case PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP:
        return checkDevice(
          iconMobile: ImageAssets.icTaoBocBangLichHop,
          iconTablet: ImageAssets.icTaoBocBangLichHop,
        );
      case PERMISSION_DETAIL.CU_CAN_BO_DI_THAY:
        return checkDevice(
          iconMobile: ImageAssets.icCuCanBoDiThay,
          iconTablet: ImageAssets.icCuCanBoDiThay,
        );
      case PERMISSION_DETAIL.HUY_LICH:
        return checkDevice(
          iconMobile: ImageAssets.icHuyLichHop,
          iconTablet: ImageAssets.icHuyLichHop,
        );
      case PERMISSION_DETAIL.XAC_NHAN_THAM_GIA:
        return checkDevice(
          iconMobile: ImageAssets.icXacNhanThamGia,
          iconTablet: ImageAssets.icXacNhanThamGia,
        );
      case PERMISSION_DETAIL.XAC_NHAN_LAI:
        return checkDevice(
          iconMobile: ImageAssets.icXacNhanLai,
          iconTablet: ImageAssets.icXacNhanLai,
        );
      case PERMISSION_DETAIL.HUY_XAC_NHAN:
        return checkDevice(
          iconMobile: ImageAssets.icTuChoiThamGia,
          iconTablet: ImageAssets.icTuChoiThamGia,
        );
      case PERMISSION_DETAIL.TU_CHOI_THAM_GIA:
        return checkDevice(
          iconMobile: ImageAssets.icTuChoiThamGia,
          iconTablet: ImageAssets.icTuChoiThamGia,
        );
      case PERMISSION_DETAIL.CU_CAN_BO:
        return checkDevice(
          iconMobile: ImageAssets.icCuCanBo,
          iconTablet: ImageAssets.icCuCanBo,
        );
      case PERMISSION_DETAIL.DUYET_LICH:
        return checkDevice(
          iconMobile: ImageAssets.icDuyetLich,
          iconTablet: ImageAssets.icDuyetLich,
        );
      case PERMISSION_DETAIL.TU_CHOI:
        return checkDevice(
          iconMobile: ImageAssets.icHuy,
          iconTablet: ImageAssets.icHuy,
        );
      case PERMISSION_DETAIL.HUY_DUYET:
        return checkDevice(
          iconMobile: ImageAssets.icHuyLichHop,
          iconTablet: ImageAssets.icHuyLichHop,
        );
    }
  }

  CellPopPupMenu getMenuLichHop(
    BuildContext context,
    DetailMeetCalenderCubit cubit,
    ThanhPhanThamGiaCubit cubitThanhPhanTG,
    ThemCanBoCubit themCanBoCubit,
    ThemDonViCubit themDonViCubit,
  ) {
    switch (this) {
      case PERMISSION_DETAIL.THU_HOI:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.THU_HOI.getIcon(),
          text: PERMISSION_DETAIL.THU_HOI.getString(),
          onTap: () {
            isMobile()
                ? showBottomSheetCustom(
                    context,
                    title: S.current.thu_hoi_lich,
                    child: ThuHoiLichWidget(
                      cubit: cubit,
                      id: cubit.idCuocHop,
                    ),
                  )
                : showDiaLogTablet(
                    context,
                    maxHeight: 280,
                    title: S.current.thu_hoi_lich,
                    child: ThuHoiLichWidget(
                      cubit: cubit,
                      id: cubit.idCuocHop,
                    ),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
          },
        );

      case PERMISSION_DETAIL.XOA:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.XOA.getIcon(),
          text: PERMISSION_DETAIL.XOA.getString(),
          onTap: () {
            if (cubit.getChiTietLichHopModel.typeRepeat == 1) {
              showDiaLog(
                context,
                textContent: S.current.xoa_chi_tiet_lich_hop,
                btnLeftTxt: S.current.khong,
                funcBtnRight: () {
                  cubit.deleteChiTietLichHop();
                  Navigator.pop(context, true);
                },
                title: S.current.xoa_lich_hop,
                btnRightTxt: S.current.dong_y,
                icon: SvgPicture.asset(ImageAssets.icXoaHopPoppup),
                showTablet: true,
                isThisPopAfter: true,
              );
              return;
            }
            showDialog(
              context: context,
              builder: (context) => RadioOptionDialog(
                title: S.current.xoa_lich_hop,
                textConfirm: S.current.xoa_chi_tiet_lich_hop,
                textRadioBelow: S.current.tu_hien_tai_ve_sau,
                textRadioAbove: S.current.chi_lich_hien_tai,
                imageUrl: ImageAssets.icXoaHopPoppup,
                onChange: (value) {
                  cubit.deleteChiTietLichHop(isMulti: value);
                  Navigator.pop(context, true);
                },
              ),
            );
          },
        );
      case PERMISSION_DETAIL.SUA:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.SUA.getIcon(),
          text: PERMISSION_DETAIL.SUA.getString(),
          onTap: () {
            if (cubit.getChiTietLichHopModel.typeRepeat == 1) {
              if (isMobile()) {
                showBottomSheetCustom(
                  context,
                  title: S.current.sua_lich_hop,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SuaLichHopWidget(
                      chiTietHop: cubit.getChiTietLichHopModel,
                    ),
                  ),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  if (value) {
                    cubit.needRefreshMainMeeting = value;
                    cubit.initDataChiTiet();
                    cubit.callApiCongTacChuanBi();
                  }
                });
              } else {
                showDiaLogTablet(
                  context,
                  title: S.current.sua_lich_hop,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SuaLichHopWidget(
                      chiTietHop: cubit.getChiTietLichHopModel,
                    ),
                  ),
                  funcBtnOk: () {},
                  isBottomShow: false,
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  if (value) {
                    cubit.needRefreshMainMeeting = value;
                    cubit.initDataChiTiet();
                    cubit.callApiCongTacChuanBi();
                  }
                });
              }
              return;
            }
            showDialog(
              context: context,
              builder: (context) => RadioOptionDialog(
                title: S.current.sua_lich_hop,
                textRadioBelow: S.current.tu_hien_tai_ve_sau,
                textRadioAbove: S.current.chi_lich_hien_tai,
                imageUrl: ImageAssets.img_sua_lich,
              ),
            ).then((value) {
              if (value == null) {
                return;
              }
              if (isMobile()) {
                showBottomSheetCustom(
                  context,
                  title: S.current.sua_lich_hop,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SuaLichHopWidget(
                      chiTietHop: cubit.getChiTietLichHopModel,
                      isMulti: value,
                    ),
                  ),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  if (value) {
                    cubit.needRefreshMainMeeting = value;
                    cubit.initDataChiTiet();
                    cubit.callApiCongTacChuanBi();
                  }
                });
              } else {
                showDiaLogTablet(
                  context,
                  title: S.current.sua_lich_hop,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SuaLichHopWidget(
                      chiTietHop: cubit.getChiTietLichHopModel,
                      isMulti: value,
                    ),
                  ),
                  funcBtnOk: () {},
                  isBottomShow: false,
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  if (value) {
                    cubit.needRefreshMainMeeting = value;
                    cubit.initDataChiTiet();
                    cubit.callApiCongTacChuanBi();
                  }
                });
              }
            });
          },
        );
      case PERMISSION_DETAIL.CU_CAN_BO:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.CU_CAN_BO.getIcon(),
          text: PERMISSION_DETAIL.CU_CAN_BO.getString(),
          onTap: () {
            isMobile()
                ? showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.88,
                        child: CuCanBoWidget(
                          themCanBoCubit: themCanBoCubit,
                          cubit: cubit,
                          cubitThanhPhanTG: cubitThanhPhanTG,
                          themDonViCubit: themDonViCubit,
                        ),
                      );
                    },
                  )
                : showDiaLogTablet(
                    context,
                    title: S.current.cu_can_bo,
                    child: CuCanBoWidget(
                      themCanBoCubit: themCanBoCubit,
                      cubit: cubit,
                      cubitThanhPhanTG: cubitThanhPhanTG,
                      themDonViCubit: themDonViCubit,
                    ),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
          },
        );
      case PERMISSION_DETAIL.TU_CHOI_THAM_GIA:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.TU_CHOI_THAM_GIA.getIcon(),
          text: PERMISSION_DETAIL.TU_CHOI_THAM_GIA.getString(),
          onTap: () {
            showDiaLog(
              context,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () {
                cubit
                    .confirmThamGiaHop(
                  lichHopId: cubit.getChiTietLichHopModel.id,
                  isThamGia: false,
                )
                    .then((value) {
                  if (value) {
                    MessageConfig.show(
                      title: '${S.current.tu_choi_tham_gia} '
                          '${S.current.thanh_cong.toLowerCase()}',
                    );
                    cubit.initDataChiTiet(needCheckPermission: true);
                  } else {
                    MessageConfig.show(
                      messState: MessState.error,
                      title: '${S.current.tu_choi_tham_gia}'
                          ' ${S.current.that_bai.toLowerCase()}',
                    );
                  }
                });
              },
              title: S.current.tu_choi_tham_gia,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.img_tu_choi_tham_gia),
              textContent: S.current.confirm_tu_choi_tham_gia,
            );
          },
        );
      case PERMISSION_DETAIL.DUYET_LICH:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.DUYET_LICH.getIcon(),
          text: PERMISSION_DETAIL.DUYET_LICH.getString(),
          onTap: () {
            showDiaLog(
              context,
              textContent: S.current.duyet_lich_content,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () async {
                await cubit.huyAndDuyetLichHop(isDuyet: true).then((value) {
                  if (value) {
                    MessageConfig.show(
                      title: S.current.duyet_thanh_cong,
                    );
                    cubit.initDataChiTiet(needCheckPermission: true);
                  } else {
                    MessageConfig.show(
                      title: S.current.duyet_khong_thanh_cong,
                    );
                  }
                });
              },
              title: S.current.khong,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.img_tham_gia),
            );
          },
        );
      case PERMISSION_DETAIL.PHAN_CONG_THU_KY:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.PHAN_CONG_THU_KY.getIcon(),
          text: PERMISSION_DETAIL.PHAN_CONG_THU_KY.getString(),
          onTap: () {
            isMobile()
                ? showBottomSheetCustom(
                    context,
                    title: S.current.phan_cong_thu_ky,
                    child: PhanCongThuKyWidget(
                      cubit: cubit,
                      id: cubit.idCuocHop,
                    ),
                  )
                : showDiaLogTablet(
                    context,
                    maxHeight: 280,
                    title: S.current.phan_cong_thu_ky,
                    child: PhanCongThuKyWidget(
                      cubit: cubit,
                      id: cubit.idCuocHop,
                    ),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
          },
        );
      case PERMISSION_DETAIL.CU_CAN_BO_DI_THAY:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.CU_CAN_BO_DI_THAY.getIcon(),
          text: PERMISSION_DETAIL.CU_CAN_BO_DI_THAY.getString(),
          onTap: () {
            isMobile()
                ? showBottomSheetCustom<List<DonViModel>>(
                    context,
                    title: S.current.cu_can_bo_di_thay,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      child: CuCanBoDiThayWidget(
                        themCanBoCubit: themCanBoCubit,
                        cubit: cubit,
                        cubitThanhPhanTG: cubitThanhPhanTG,
                        themDonViCubit: themDonViCubit,
                      ),
                    ),
                  )
                : showDiaLogTablet<List<DonViModel>>(
                    context,
                    title: S.current.cu_can_bo_di_thay,
                    child: CuCanBoDiThayWidget(
                      themCanBoCubit: themCanBoCubit,
                      cubit: cubit,
                      cubitThanhPhanTG: cubitThanhPhanTG,
                      themDonViCubit: themDonViCubit,
                    ),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
          },
        );
      case PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP.getIcon(),
          text: PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP.getString(),
          onTap: () {
            isMobile()
                ? showBottomSheetCustom(
                    context,
                    title: S.current.tao_boc_bang_cuoc_hop,
                    child: const TaoBocBangWidget(),
                  )
                : showDiaLogTablet(
                    context,
                    maxHeight: 280,
                    title: S.current.tao_boc_bang_cuoc_hop,
                    child: const TaoBocBangWidget(),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
          },
        );
      case PERMISSION_DETAIL.HUY_LICH:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.HUY_LICH.getIcon(),
          text: PERMISSION_DETAIL.HUY_LICH.getString(),
          onTap: () {
            if (cubit.getChiTietLichHopModel.typeRepeat == 1) {
              showDiaLog(
                context,
                textContent: S.current.ban_chan_chan_huy_lich_nay,
                btnLeftTxt: S.current.khong,
                funcBtnRight: () {
                  cubit.huyChiTietLichHop();
                  Navigator.pop(context, true);
                },
                title: S.current.huy_lich,
                btnRightTxt: S.current.dong_y,
                icon: SvgPicture.asset(ImageAssets.icHuyLich),
                showTablet: true,
              );
              return;
            }
            showDialog(
              context: context,
              builder: (context) => RadioOptionDialog(
                title: S.current.huy_lich_hop,
                textRadioBelow: S.current.chi_lich_hien_tai,
                textRadioAbove: S.current.tu_hien_tai_ve_sau,
                imageUrl: ImageAssets.img_sua_lich,
                onChange: (value) {
                  cubit.huyChiTietLichHop(isMulti: value).then(
                        (value) => value ? Navigator.pop(context, true) : '',
                      );
                },
              ),
            );
          },
        );
      case PERMISSION_DETAIL.XAC_NHAN_THAM_GIA:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.XAC_NHAN_THAM_GIA.getIcon(),
          text: PERMISSION_DETAIL.XAC_NHAN_THAM_GIA.getString(),
          onTap: () {
            showDiaLog(
              context,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () {
                cubit
                    .confirmThamGiaHop(
                  lichHopId: cubit.getChiTietLichHopModel.id,
                  isThamGia: true,
                )
                    .then((value) {
                  if (value) {
                    MessageConfig.show(
                      title: '${S.current.xac_nhan_tham_gia}'
                          ' ${S.current.thanh_cong.toLowerCase()}',
                    );
                    cubit.initDataChiTiet(needCheckPermission: true);
                  } else {
                    MessageConfig.show(
                      messState: MessState.error,
                      title: '${S.current.xac_nhan_tham_gia}'
                          ' ${S.current.that_bai.toLowerCase()}',
                    );
                  }
                });
              },
              title: S.current.xac_nhan_tham_gia,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.img_tham_gia),
              textContent: S.current.confirm_tham_gia,
            );
          },
        );
      case PERMISSION_DETAIL.HUY_XAC_NHAN:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.HUY_XAC_NHAN.getIcon(),
          text: PERMISSION_DETAIL.HUY_XAC_NHAN.getString(),
          onTap: () {
            showDiaLog(
              context,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () {
                cubit
                    .confirmThamGiaHop(
                  lichHopId: cubit.getChiTietLichHopModel.id,
                  isThamGia: false,
                )
                    .then((value) {
                  if (value) {
                    MessageConfig.show(
                      title: '${S.current.huy}'
                          ' ${S.current.xac_nhan.toLowerCase()}'
                          ' ${S.current.thanh_cong.toLowerCase()}',
                    );
                    cubit.initDataChiTiet(needCheckPermission: true);
                  } else {
                    MessageConfig.show(
                      messState: MessState.error,
                      title: '${S.current.huy}'
                          ' ${S.current.xac_nhan.toLowerCase()}'
                          ' ${S.current.that_bai.toLowerCase()}',
                    );
                  }
                });
              },
              title: '${S.current.huy}'
                  ' ${S.current.xac_nhan.toLowerCase()}',
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.img_tham_gia),
              textContent: S.current.confirm_huy_tham_gia,
            );
          },
        );
      case PERMISSION_DETAIL.XAC_NHAN_LAI:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.XAC_NHAN_LAI.getIcon(),
          text: PERMISSION_DETAIL.XAC_NHAN_LAI.getString(),
          onTap: () {
            showDiaLog(
              context,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () {
                cubit
                    .confirmThamGiaHop(
                  lichHopId: cubit.getChiTietLichHopModel.id,
                  isThamGia: true,
                )
                    .then((value) {
                  if (value) {
                    MessageConfig.show(
                      title: '${S.current.xac_nhan_lai}'
                          ' ${S.current.thanh_cong.toLowerCase()}',
                    );
                    cubit.initDataChiTiet(needCheckPermission: true);
                  } else {
                    MessageConfig.show(
                      messState: MessState.error,
                      title: ' ${S.current.xac_nhan_lai}'
                          ' ${S.current.that_bai.toLowerCase()}',
                    );
                  }
                });
              },
              title: S.current.xac_nhan_lai,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.img_tham_gia),
              textContent: S.current.confirm_tham_gia,
            );
          },
        );
      case PERMISSION_DETAIL.TU_CHOI:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.TU_CHOI.getIcon(),
          text: PERMISSION_DETAIL.TU_CHOI.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.HUY_DUYET:
        return CellPopPupMenu(
          urlImage: PERMISSION_DETAIL.HUY_DUYET.getIcon(),
          text: PERMISSION_DETAIL.HUY_DUYET.getString(),
          onTap: () {
            showDiaLog(
              context,
              textContent: S.current.huy_duyet_lich,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () async {
                await cubit.huyAndDuyetLichHop(isDuyet: false).then((value) {
                  if (value) {
                    MessageConfig.show(
                      title: S.current.huy_duyet_thanh_cong,
                    );
                    cubit.initDataChiTiet(needCheckPermission: true);
                  } else {
                    MessageConfig.show(
                      title: S.current.huy_duyet_khong_thanh_cong,
                    );
                  }
                });
                // Navigator.pop(context);
              },
              title: S.current.huy_duyet,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.img_tu_choi_tham_gia),
            );
          },
        );
    }
  }

  String checkDevice({
    required String iconMobile,
    required String iconTablet,
  }) {
    return isMobile() ? iconMobile : iconTablet;
  }
}

class STATUS_SCHEDULE {
  static const int NHAP = 1;
  static const int CHO_DUYET = 2;
  static const int DA_DUYET = 3;
  static const int TU_CHOI_DUYET = 4;
  static const int THU_HOI = 5;
  static const int XOA = 6;
  static const int THANH_CONG = 7;
  static const int HUY = 8;
}

class TRANG_THAI_DUYET_KY_THUAT {
  static const int CHO_DUYET = 0;
  static const int DA_DUYET = 1;
  static const int KHONG_DUYET = 2;
}

class ACTIVE_PHAT_BIEU {
  static const int DANH_SACH_PHAT_BIEU = 0;
  static const int CHO_DUYET = 1;
  static const int DA_DUYET = 2;
  static const int HUY_DUYET = 3;
}

class STATUS_ROOM_MEETING {
  static const int CHO_DUYET = 0;
  static const int DA_DUYET = 1;
  static const int HUY_DUYET = 2;
}

class STATUS_DETAIL {
  static const int NHAP = 0;
  static const int CHO_DUYET = 1;
  static const int DA_DUYET = 2;
  static const int TU_CHOI_DUYET = 3;
  static const int THU_HOI = 4;
  static const int DANG_DIEN_DA = 5;
  static const int DA_GUI_LOI_MOI = 6;
  static const int XOA = 7;
  static const int HUY = 8;
}

class ThanhPhanThamGiaStatus {
  static const int THAM_GIA = 1;
  static const int TU_CHOI_THAM_GIA = 2;
  static const int THAM_DU = 3;
  static const int CHO_XAC_NHAN = 0;
  static const int THU_HOI = 4;
}
