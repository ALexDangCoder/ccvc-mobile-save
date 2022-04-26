import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/sua_lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thu_hoi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/cupertino.dart';
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
  XAC_NHAN_LAI
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
        return S.current.duyet;
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
    }
  }

  String getIcon() {
    switch (this) {
      case PERMISSION_DETAIL.THU_HOI:
        return checkDevice(
          iconMobile: ImageAssets.icHuy,
          iconTablet: ImageAssets.icHuy,
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
          iconMobile: ImageAssets.icTaoBocBang,
          iconTablet: ImageAssets.icTaoBocBang,
        );
      case PERMISSION_DETAIL.CU_CAN_BO_DI_THAY:
        return checkDevice(
          iconMobile: ImageAssets.icCuCanBoDiThay,
          iconTablet: ImageAssets.icCuCanBoDiThay,
        );
      case PERMISSION_DETAIL.HUY_LICH:
        return checkDevice(
          iconMobile: ImageAssets.icHuyLich,
          iconTablet: ImageAssets.icHuyLich,
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
          iconMobile: ImageAssets.icHuy,
          iconTablet: ImageAssets.icHuy,
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
    }
  }

  QData getMenuLichHop(
    BuildContext context,
    DetailMeetCalenderCubit cubit,
    String id,
  ) {
    switch (this) {
      case PERMISSION_DETAIL.THU_HOI:
        return QData(
          urlImage: PERMISSION_DETAIL.THU_HOI.getIcon(),
          text: PERMISSION_DETAIL.THU_HOI.getString(),
          onTap: () {
            showBottomSheetCustom(
              context,
              title: S.current.thu_hoi_lich,
              child: const ThuHoiLichWidget(),
            );
          },
        );
      case PERMISSION_DETAIL.XOA:
        return QData(
          urlImage: PERMISSION_DETAIL.XOA.getIcon(),
          text: PERMISSION_DETAIL.XOA.getString(),
          onTap: () {
            showDiaLog(
              context,
              textContent: S.current.xoa_chi_tiet_lich_hop,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () {
                cubit.deleteChiTietLichHop(id);
                Navigator.pop(context);
              },
              title: S.current.khong,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.icHuyLich),
            );
          },
        );
      case PERMISSION_DETAIL.SUA:
        return QData(
          urlImage: PERMISSION_DETAIL.SUA.getIcon(),
          text: PERMISSION_DETAIL.SUA.getString(),
          onTap: () {
            showBottomSheetCustom(
              context,
              title: S.current.sua_lich_hop,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SuaLichHopWidget(
                  cubit: cubit,
                ),
              ),
            );
          },
        );
      case PERMISSION_DETAIL.CU_CAN_BO:
        return QData(
          urlImage: PERMISSION_DETAIL.CU_CAN_BO.getIcon(),
          text: PERMISSION_DETAIL.CU_CAN_BO.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.TU_CHOI_THAM_GIA:
        return QData(
          urlImage: PERMISSION_DETAIL.TU_CHOI_THAM_GIA.getIcon(),
          text: PERMISSION_DETAIL.TU_CHOI_THAM_GIA.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.DUYET_LICH:
        return QData(
          urlImage: PERMISSION_DETAIL.DUYET_LICH.getIcon(),
          text: PERMISSION_DETAIL.DUYET_LICH.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.PHAN_CONG_THU_KY:
        return QData(
          urlImage: PERMISSION_DETAIL.PHAN_CONG_THU_KY.getIcon(),
          text: PERMISSION_DETAIL.PHAN_CONG_THU_KY.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.CU_CAN_BO_DI_THAY:
        return QData(
          urlImage: PERMISSION_DETAIL.CU_CAN_BO_DI_THAY.getIcon(),
          text: PERMISSION_DETAIL.CU_CAN_BO_DI_THAY.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP:
        return QData(
          urlImage: PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP.getIcon(),
          text: PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP.getString(),
          onTap: () {
            showBottomSheetCustom(
              context,
              title: S.current.tao_boc_bang_cuoc_hop,
              child: const TaoBocBangWidget(),
            );
          },
        );
      case PERMISSION_DETAIL.HUY_LICH:
        return QData(
          urlImage: PERMISSION_DETAIL.HUY_LICH.getIcon(),
          text: PERMISSION_DETAIL.HUY_LICH.getString(),
          onTap: () {
            showDiaLog(
              context,
              textContent: S.current.ban_chan_chan_huy_lich_nay,
              btnLeftTxt: S.current.khong,
              funcBtnRight: () {
                cubit.huyChiTietLichHop(id);
                Navigator.pop(context);
              },
              title: S.current.huy_lich,
              btnRightTxt: S.current.dong_y,
              icon: SvgPicture.asset(ImageAssets.icHuyLich),
            );
          },
        );
      case PERMISSION_DETAIL.XAC_NHAN_THAM_GIA:
        return QData(
          urlImage: PERMISSION_DETAIL.XAC_NHAN_THAM_GIA.getIcon(),
          text: PERMISSION_DETAIL.XAC_NHAN_THAM_GIA.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.HUY_XAC_NHAN:
        return QData(
          urlImage: PERMISSION_DETAIL.HUY_XAC_NHAN.getIcon(),
          text: PERMISSION_DETAIL.HUY_XAC_NHAN.getString(),
          onTap: () {},
        );
      case PERMISSION_DETAIL.XAC_NHAN_LAI:
        return QData(
          urlImage: PERMISSION_DETAIL.XAC_NHAN_LAI.getIcon(),
          text: PERMISSION_DETAIL.XAC_NHAN_LAI.getString(),
          onTap: () {},
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
