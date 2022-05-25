import 'dart:convert';

import 'package:ccvc_mobile/data/request/lich_hop/nguoi_theo_doi_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/can_bo_tham_gia_str.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///permission
extension PermissionLichHop on DetailMeetCalenderCubit {
  Future<void> getNguoiChuTri(String id) async {
    final dataUser = HiveLocal.getDataUser();

    final result = await hopRp.getNguoiTheoDoi(
      NguoiTheoDoiRequest(
        isTheoDoi: true,
        pageIndex: 1,
        pageSize: 1000,
        userId: id,
      ),
    );
    result.when(success: (res) {}, error: (err) {});
  }

  List<CanBoThamGiaStr> dataListStr(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    final data = jsonDecode(jsonString);

    return data.map((e) => CanBoThamGiaStr.fromJson(e)).toList();
  }

  List<CanBoThamGiaStr> canBoThamGia() {
    return scheduleCoperatives
        .where((e) => e.CanBoId?.toUpperCase() == getIdCurrentUser())
        .toList();
  }

  String getIdCurrentUser() {
    return (dataUser?.userId ?? '').replaceAll('"', '');
  }

  List<CanBoThamGiaStr> donViThamGia() {
    final UserInformation? dataUserIf = dataUser?.userInformation;
    final DonViTrucThuoc? dataDviTrucThuoc = dataUserIf?.donViTrucThuoc;
    return scheduleCoperatives
        .where(
          (e) =>
              (dataDviTrucThuoc?.id ?? '').isEmpty &&
              e.DonViId == (dataDviTrucThuoc?.id ?? '').toUpperCase() &&
              (e.CanBoId ?? '').isNotEmpty,
        )
        .toList();
  }

  List<CanBoThamGiaStr> thamGia() {
    if (canBoThamGia().isNotEmpty) return canBoThamGia();
    if (donViThamGia().isNotEmpty) return donViThamGia();
    return [];
  }

  bool isThuKy() {
    if (thamGia().isEmpty) return false;

    for (final i in thamGia()) {
      if (i.IsThuKy != null) {
        return i.IsThuKy ?? false;
      }
    }
    return false;
  }

  bool isLichThuHoi() {
    if (thamGia().isEmpty) return false;

    for (final i in thamGia()) {
      if (i.TrangThai != null) {
        return i.TrangThai == 4;
      }
    }
    return false;
  }

  List<CanBoThamGiaStr> dataXacNhanThamGia() {
    final List<CanBoThamGiaStr> value = [];

    value.addAll(
      scheduleCoperatives
          .where((e) =>
              (e.CanBoId ?? '').isNotEmpty &&
              e.CanBoId?.toUpperCase() ==
                  (dataUser?.userId ?? '').toUpperCase())
          .toList(),
    );

    value.addAll(
      scheduleCoperatives
          .where(
            (e) =>
                HiveLocal.checkPermissionApp(
                  permissionType: PermissionType.VPDT,
                  permissionTxt: 'quyen-cu-can-bo',
                ) &&
                (e.CanBoId ?? '').isEmpty &&
                e.DonViId?.toUpperCase() ==
                    ((dataUser?.userInformation?.donViTrucThuoc?.id ?? '')
                        .replaceAll(
                          '"',
                          '',
                        )
                        .toUpperCase()),
          )
          .toList(),
    );

    return value;
  }

  bool isCuCanBo() {
    if (scheduleCoperatives.isEmpty) return false;

    final UserInformation? dataUserIf = dataUser?.userInformation;
    final DonViTrucThuoc? dataDviTrucThuoc = dataUserIf?.donViTrucThuoc;

    final isCuCanBo = scheduleCoperatives
        .map(
          (e) =>
              e.DonViId == (dataDviTrucThuoc?.id ?? '').toUpperCase() &&
              (e.CanBoId ?? '').isEmpty,
        )
        .toList();

    return isCuCanBo.isNotEmpty;
  }

  bool isDaCuCanBo() {
    String id = '';

    for (final i in thamGia()) {
      if ((i.Id ?? '').isNotEmpty) {
        id = i.Id ?? '';
        break;
      }
    }
    return scheduleCoperatives
        .where(
          (e) => (e.ParentId ?? '').toUpperCase() == id.toUpperCase(),
        )
        .toList()
        .isNotEmpty;
  }

  int classThamDu() {
    if (dataXacNhanThamGia().isNotEmpty) {
      return dataXacNhanThamGia()[0].TrangThai ?? 0;
    }

    return 0;
  }

  String showTextThamGia() {
    if (dataXacNhanThamGia().isNotEmpty) {
      if (dataXacNhanThamGia()[0].TrangThai == 0 || isDaCuCanBo()) {
        return S.current.xac_nhan_tham_gia;
      }

      String idValue = '';

      for (final i in thamGia()) {
        if ((i.Id ?? '').isNotEmpty) {
          idValue = i.Id ?? '';
          break;
        }
      }

      if (dataXacNhanThamGia()[0].TrangThai == 1 && isDaCuCanBo()) {
        return S.current.huy_xac_nhan;
      }

      if (dataXacNhanThamGia()[0].TrangThai == 2) {
        return S.current.xac_nhan_lai;
      }
    }

    return '';
  }

  bool activeChuTri() {
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
        (dataUser?.userId ?? '')) {
      return true;
    }
    return false;
  }

  bool isDuyetLich() {
    return chiTietLichLamViecSubject.value.status == 2;
  }

  bool isLichHuy() {
    return chiTietLichLamViecSubject.value.status == 8;
  }

  bool isNguoiTao() {
    if (dataUser?.userId == chiTietLichLamViecSubject.value.createdBy) {
      return true;
    }
    return false;
  }

  bool isOwner() {
    if (activeChuTri() && isNguoiTao()) {
      return true;
    }
    return false;
  }

  bool trangThaiHuy() {
    if (chiTietLichLamViecSubject.value.status == STATUS_SCHEDULE.HUY) {
      return true;
    }
    return false;
  }

  void initDataButton() {
    listButton.clear();
    scheduleCoperatives =
        dataListStr(chiTietLichLamViecSubject.value.canBoThamGiaStr);

    ///check quyen sua lich
    if (chiTietLichLamViecSubject.value.thoiGianKetThuc.isEmpty &&
        (activeChuTri() || isNguoiTao() || isThuKy()) &&
        chiTietLichLamViecSubject.value.status != 8 &&
        !isLichHuy() &&
        !isLichThuHoi()) {
      listButton.add(PERMISSION_DETAIL.SUA);
    }

    ///check quyen xoa
    if (chiTietLichLamViecSubject.value.thoiGianKetThuc.isEmpty &&
        (activeChuTri() || isNguoiTao() || isThuKy()) &&
        !isLichHuy() &&
        !isLichThuHoi()) {
      listButton.add(PERMISSION_DETAIL.XOA);
    }

    ///check quyen button thu hoi
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') ||
        isThuKy()) {
      listButton.add(PERMISSION_DETAIL.THU_HOI);
    }

    ///check quyen tu choi va huy duyet
    if (!isLichHuy() &&
        chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') &&
        (chiTietLichLamViecSubject.value.status == 1 ||
            chiTietLichLamViecSubject.value.status == 2)) {
      if (chiTietLichLamViecSubject.value.status == 1) {
        listButton.add(PERMISSION_DETAIL.TU_CHOI);
      } else {
        listButton.add(PERMISSION_DETAIL.HUY_DUYET);
      }
    }

    ///check quyen button cu can bo
    if (chiTietLichLamViecSubject.value.status != 8 &&
        isLichThuHoi() &&
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'quyen-cu-can-bo',
        ) &&
        isCuCanBo() &&
        classThamDu() != 2) {
      listButton.add(PERMISSION_DETAIL.CU_CAN_BO);
    }

    ///check quyen button tu choi tham gia
    if (dataXacNhanThamGia().isNotEmpty &&
        showTextThamGia().isNotEmpty &&
        classThamDu() == 0) {
      listButton.add(PERMISSION_DETAIL.TU_CHOI_THAM_GIA);
    }

    ///check quyen button duyet lich
    if (!isDuyetLich() &&
        chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') &&
        chiTietLichLamViecSubject.value.bit_YeuCauDuyet) {
      listButton.add(PERMISSION_DETAIL.DUYET_LICH);
    }

    ///check quyen phan cong thu ky
    if (activeChuTri() && !trangThaiHuy()) {
      listButton.add(PERMISSION_DETAIL.PHAN_CONG_THU_KY);
    }

    ///check quyen cu can bo di thay
    if (!isLichHuy() &&
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'cu-can-bo-di-thay',
        ) &&
        !activeChuTri() &&
        canBoThamGia().isNotEmpty &&
        classThamDu() != 2) {
      listButton.add(PERMISSION_DETAIL.CU_CAN_BO_DI_THAY);
    }

    ///check quyen tao boc bang cuoc hop
    if (chiTietLichLamViecSubject.value.isTaoTaoBocBang) {
      listButton.add(PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP);
    }

    ///check quyen huy lich
    if ((isOwner() || isThuKy() && !trangThaiHuy()) && !trangThaiHuy()) {
      listButton.add(PERMISSION_DETAIL.HUY_LICH);
    }

    ///check quyen xac nhan tham gia
    if (dataXacNhanThamGia().isNotEmpty) {
      if (dataXacNhanThamGia()[0].TrangThai == 0 || isDaCuCanBo()) {
        listButton.add(PERMISSION_DETAIL.XAC_NHAN_THAM_GIA);
      }

      String idValue = '';

      for (final i in thamGia()) {
        if ((i.Id ?? '').isNotEmpty) {
          idValue = i.Id ?? '';
          break;
        }
      }

      ///check quyen huy xac nhan
      if (dataXacNhanThamGia()[0].TrangThai == 1 && isDaCuCanBo()) {
        listButton.add(PERMISSION_DETAIL.HUY_XAC_NHAN);
      }

      ///check quyen xac nhan lai
      if (dataXacNhanThamGia()[0].TrangThai == 2) {
        listButton.add(PERMISSION_DETAIL.XAC_NHAN_LAI);
      }
    }

    listButtonSubject.add(listButton);
  }

  int trangThaiPhong() {
    return getThongTinPhongHopSb.value?.trangThai ?? 0;
  }

  ///======================= check quyen tab cong tac chuan bi =======================
  ///1. check phong hop

  ///check button duyet phong
  bool checkDuyetPhong() {
    return trangThaiPhong() == 0 || trangThaiPhong() == 2;
  }

  bool checkPermission() {
    if (HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'quyen-duyet-phong',
        ) &&
        chiTietLichLamViecSubject.value.isDuyetPhong) {
      return true;
    }
    return false;
  }

  bool checkHuyDuyet() {
    return trangThaiPhong() == 0 || trangThaiPhong() == 1;
  }

  ///check button tu choi va huy duyet
  PERMISSION_TAB isHuyDuyet() {
    return trangThaiPhong() == 0
        ? PERMISSION_TAB.TU_CHOI
        : PERMISSION_TAB.HUY_DUYET;
  }

  ///2.check quyen yeu cau thiet bi (btn duyet va btn tu choi)
  bool isButtonYeuCauThietBi() {
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'quyen-duyet-thiet-bi',
        ) &&
        (chiTietLichLamViecSubject.value.isDuyetThietBi ?? false);
  }

  ///3.check quyen duyet ky thuat
  bool checkPermissionDKT() {
    if (trangThaiPhong() != 1) return false;
    if (chiTietLichLamViecSubject.value.bit_PhongTrungTamDieuHanh ?? false) {
      return HiveLocal.checkPermissionApp(
        permissionType: PermissionType.VPDT,
        permissionTxt: 'duyet-ky-thuat-ttdh',
      );
    }
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'duyet-ky-thuat',
        ) ||
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'duyet-ky-thuat-ttdh',
        );
  }

  ///check quyen btn tu choi dkt va huy dkt
  bool checkDuyetKyThuat() {
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'duyet-ky-thuat',
        ) ||
        HiveLocal.checkPermissionApp(
              permissionType: PermissionType.VPDT,
              permissionTxt: 'duyet-ky-thuat-ttdh',
            ) &&
            ([
              TRANG_THAI_DUYET_KY_THUAT.CHO_DUYET,
              TRANG_THAI_DUYET_KY_THUAT.KHONG_DUYET
            ].contains(
              chiTietLichLamViecSubject.value.trangThaiDuyetKyThuat,
            ));
  }

  ///======================= check tab chuong trinh hop ==============================

  ///btn them phien hop
  bool isBtnThemPhienHop() {
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') ||
        isThuKy()) {
      return true;
    }

    return false;
  }

  ///======================= check tab thanh phan tham gia =======================

  bool isTaoLich() {
    return chiTietLichLamViecSubject.value.createdBy ==
        (dataUser?.userId ?? '');
  }

  ///btn moi nguoi tham gia
  bool isBtnMoiNguoiThamGia() {
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') ||
        isThuKy() ||
        isTaoLich()) {
      return true;
    }
    return false;
  }

  ///======================= phat bieu =======================

  List<NguoiTaoStr> converStringToNguoiTao(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    final data = jsonDecode(jsonString);

    return data.map((e) => NguoiTaoStr.fromJson(e)).toList();
  }

  List<PhienHopModel> converStringToPhienHop(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    final data = jsonDecode(jsonString);

    return data.map((e) => PhienHopModel.fromJson(e)).toList();
  }

  List<PhienHopModel> phienHop() {
    return converStringToPhienHop(
        chiTietLichLamViecSubject.value.lichHop_PhienHopStr ?? '');
  }

  List<NguoiTaoStr> nguoiTao() {
    return converStringToNguoiTao(
        chiTietLichLamViecSubject.value.nguoiTao_str ?? '');
  }

  bool isNguoiTaoPhatBieu() {
    return (nguoiTao()[0].UserId ?? '').toLowerCase() ==
        (dataUser?.userId ?? '');
  }

  bool isChuTri() {
    return chiTietLichLamViecSubject.value.chuTriModel.canBoId.toLowerCase() ==
        (dataUser?.userId ?? '');
  }

  List<CanBoThamGiaStr> donViThamGiaPhatBieu() {
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'quyen-cu-can-bo',
    )) {
      return canBoThamGia()
          .where(
            (e) =>
                (e.CanBoId ?? '').isEmpty &&
                (e.DonViId ?? '').toLowerCase() ==
                    dataUser?.userInformation?.donViTrucThuoc?.id,
          )
          .toList();
    }
    return [];
  }

  bool isThanhPhanThamGia() {
    if (isChuTri() ||
        isNguoiTaoPhatBieu() ||
        canBoThamGia().isNotEmpty ||
        donViThamGiaPhatBieu().isNotEmpty) {
      return true;
    }
    return false;
  }

  ///check btn dang ky phat bieu
  bool isDangKyPhatBieu() {
    if (isThanhPhanThamGia()) {
      return true;
    }
    return false;
  }

  ///======================= bieu quyet =======================

  ///btn them duyet bieu quyet
  bool isThemDuyetBieuQuyet() {
    if (isChuTri() || isThuKy()) {
      return true;
    }
    return false;
  }

  ///======================= ket luan hop =======================

  ///btn soan ket luan hop
  bool isSoanKetLuanHop() {
    if (xemKetLuanHopModel == KetLuanHopModel.empty() &&
        chiTietLichLamViecSubject.value.status == 2) {
      return true;
    }
    return false;
  }
}