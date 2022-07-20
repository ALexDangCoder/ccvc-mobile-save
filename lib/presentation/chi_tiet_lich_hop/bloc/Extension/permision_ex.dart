import 'dart:convert';

import 'package:ccvc_mobile/data/request/lich_hop/nguoi_theo_doi_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/can_bo_tham_gia_str.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

///permission
extension PermissionLichHop on DetailMeetCalenderCubit {
  Future<void> getNguoiChuTri(String id) async {
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
    final List<CanBoThamGiaStr> list = [];
    for (final element in data as List<dynamic>) {
      final cb = CanBoThamGiaStr.fromJson(element);
      list.add(cb);
    }
    return list;
  }

  List<CanBoThamGiaStr> canBoThamGia() {
    return scheduleCoperatives
        .where(
          (e) => e.CanBoId?.toUpperCase() == getIdCurrentUser().toUpperCase(),
        )
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
              (dataDviTrucThuoc?.id ?? '').isNotEmpty &&
              (e.donViId ?? '').toUpperCase() ==
                  (dataDviTrucThuoc?.id ?? '').toUpperCase() &&
              (e.id ?? '').isNotEmpty,
        )
        .toList();
  }

  List<CanBoThamGiaStr> thamGia() {
    if (canBoThamGia().isNotEmpty) return canBoThamGia();
    if (donViThamGia().isNotEmpty) return donViThamGia();
    return [];
  }

  bool isThuKy() {
    return thamGia()
            .firstWhere(
              (element) =>
                  (element.CanBoId ?? '').toLowerCase() ==
                  (HiveLocal.getDataUser()?.userId ?? ''),
              orElse: () => CanBoThamGiaStr.empty(),
            )
            .isThuKy ??
        false;
  }

  bool isLichThuHoi() {
    if (thamGia().isEmpty) return false;

    for (final i in thamGia()) {
      if (i.trangThai != null) {
        return i.trangThai == 4;
      }
    }
    return false;
  }

  List<CanBoThamGiaStr> dataXacNhanThamGia() {
    final List<CanBoThamGiaStr> value = [];

    value.addAll(
      scheduleCoperatives
          .where(
            (e) =>
                (e.CanBoId ?? '').isNotEmpty &&
                e.CanBoId?.toUpperCase() ==
                    (dataUser?.userId ?? '').toUpperCase(),
          )
          .toList(),
    );

    value.addAll(
      scheduleCoperatives
          .where(
            (e) =>
                HiveLocal.checkPermissionApp(
                  permissionType: PermissionType.VPDT,
                  permissionTxt: PermissionAppTxt.QUYEN_CU_CAN_BO,
                ) &&
                (e.CanBoId ?? '').isEmpty &&
                e.donViId?.toUpperCase() ==
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
              (e.donViId ?? '').toUpperCase() ==
                  (dataDviTrucThuoc?.id ?? '').toUpperCase() &&
              (e.CanBoId ?? '').isEmpty,
        )
        .toList();

    return isCuCanBo.isNotEmpty;
  }

  bool isDaCuCanBo() {
    String id = '';
    for (final i in thamGia()) {
      if ((i.id ?? '').isNotEmpty) {
        id = i.id ?? '';
        break;
      }
    }
    final bool i = scheduleCoperatives
        .where(
          (e) => (e.id ?? '').toUpperCase() == id.toUpperCase(),
        )
        .toList()
        .isNotEmpty;
    return i;
  }

  int classThamDu() {
    if (dataXacNhanThamGia().isNotEmpty) {
      return dataXacNhanThamGia()[0].trangThai ?? 0;
    }

    return 0;
  }

  String showTextThamGia() {
    if (dataXacNhanThamGia().isNotEmpty) {
      if (dataXacNhanThamGia()[0].trangThai == 0 || isDaCuCanBo()) {
        return S.current.xac_nhan_tham_gia;
      }

      if (dataXacNhanThamGia()[0].trangThai == 1 && isDaCuCanBo()) {
        return S.current.huy_xac_nhan;
      }

      if (dataXacNhanThamGia()[0].trangThai == 2) {
        return S.current.xac_nhan_lai;
      }
    }

    return '';
  }

  bool activeChuTri() =>
      getChiTietLichHopModel.chuTriModel.canBoId.toLowerCase() ==
      (HiveLocal.getDataUser()?.userId ?? '').toLowerCase();

  bool isDuyetLich() {
    return getChiTietLichHopModel.status == 2;
  }

  bool isLichHuy() {
    return getChiTietLichHopModel.status == 8;
  }

  bool isNguoiTao() {
    if (dataUser?.userId == getChiTietLichHopModel.createdBy) {
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

  bool isOwnerNew() {
    if (activeChuTri()) {
      return true;
    }
    return false;
  }

  bool trangThaiHuy() => getChiTietLichHopModel.status == STATUS_SCHEDULE.HUY;

  bool thanhPhanThamGiaDaXacNhan() {
    final nguoiDaThamGia = thamGia().where((e) {
      final isThamGia = (e.trangThai ?? 0) == ThanhPhanThamGiaStatus.THAM_GIA;
      final isThamDu = (e.trangThai ?? 0) == ThanhPhanThamGiaStatus.THAM_DU;
      return isThamGia || isThamDu;
    });
    return nguoiDaThamGia.isNotEmpty;
  }

  void initDataButton() {
    listButton.clear();
    scheduleCoperatives = dataListStr(getChiTietLichHopModel.canBoThamGiaStr);

    ///check quyen sua lich
    if (getChiTietLichHopModel.thoiGianKetThuc.isEmpty &&
        (activeChuTri() || isNguoiTao() || isThuKy()) &&
        getChiTietLichHopModel.status != 8 &&
        !isLichHuy() &&
        !isLichThuHoi()) {
      listButton.add(PERMISSION_DETAIL.SUA);
    }

    ///check quyen xoa
    if (activeChuTri() || isNguoiTao() || isThuKy()) {
      listButton.add(PERMISSION_DETAIL.XOA);
    }

    ///check quyen button thu hoi
    if (getChiTietLichHopModel.chuTriModel.canBoId.toUpperCase() ==
            (dataUser?.userId ?? '').toUpperCase() ||
        isThuKy() ||
        isNguoiTao()) {
      listButton.add(PERMISSION_DETAIL.THU_HOI);
    }

    ///check quyen tu choi va huy duyet
    if (!isLichHuy() &&
        getChiTietLichHopModel.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') &&
        (getChiTietLichHopModel.status == 1 ||
            getChiTietLichHopModel.status == 2)) {
      if (getChiTietLichHopModel.status == 1) {
        listButton.add(PERMISSION_DETAIL.TU_CHOI);
      } else {
        listButton.add(PERMISSION_DETAIL.HUY_DUYET);
      }
    }
    final coQuyenCuCanBo = HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_CU_CAN_BO,
    );
    final laLanhDaoDonVi = thamGia().where((e) {
      final isDonVi = (e.CanBoId ?? '').isEmpty;
      final chungDonVi = (e.donViId ?? '').toLowerCase() ==
          (dataUser?.userInformation?.donViTrucThuoc?.id ?? '').toLowerCase();
      final isLanhDao = HiveLocal.checkPermissionApp(
        permissionType: PermissionType.VPDT,
        permissionTxt: PermissionAppTxt.LANH_DAO_CO_QUAN,
      );
      return isDonVi && chungDonVi && isLanhDao;
    });

    ///check quyen button cu can bo
    if (!trangThaiHuy() && laLanhDaoDonVi.isNotEmpty && coQuyenCuCanBo) {
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
        getChiTietLichHopModel.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') &&
        getChiTietLichHopModel.bit_YeuCauDuyet) {
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
          permissionTxt: PermissionAppTxt.QUYEN_CU_CAN_BO_DI_THAY,
        ) &&
        !activeChuTri() &&
        canBoThamGia().isNotEmpty &&
        classThamDu() != 2) {
      listButton.add(PERMISSION_DETAIL.CU_CAN_BO_DI_THAY);
    }

    ///Tạm thời bỏ bóc băng
    // ///check quyen tao boc bang cuoc hop
    // if (getChiTietLichHopModel.isTaoTaoBocBang) {
    //   listButton.add(PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP);
    // }

    ///check quyen huy lich
    if ((isOwnerNew() || isThuKy() || isNguoiTao()) && !trangThaiHuy()) {
      listButton.add(PERMISSION_DETAIL.HUY_LICH);
    }

    ///check quyen xac nhan tham gia
    if (dataXacNhanThamGia().isNotEmpty) {
      if (dataXacNhanThamGia()[0].trangThai == 0 && isDaCuCanBo()) {
        listButton.add(PERMISSION_DETAIL.XAC_NHAN_THAM_GIA);
      }

      ///check quyen huy xac nhan
      if (dataXacNhanThamGia()[0].trangThai == 1 && isDaCuCanBo()) {
        listButton.add(PERMISSION_DETAIL.HUY_XAC_NHAN);
      }

      ///check quyen xac nhan lai
      if (dataXacNhanThamGia()[0].trangThai == 2) {
        listButton.add(PERMISSION_DETAIL.XAC_NHAN_LAI);
      }
    }

    listButtonSubject.add(listButton);
  }

  int trangThaiPhong() {
    return getThongTinPhongHopForPermision.trangThai ?? 0;
  }

  ///==================== check quyen tab cong tac chuan bi ================
  ///1. check phong hop

  ///check button duyet phong
  //0 = cho duyet
  //1 = da duyet
  //2 = huy duyet
  bool checkDuyetPhong() {
    return trangThaiPhong() == STATUS_ROOM_MEETING.CHO_DUYET ||
        trangThaiPhong() == STATUS_ROOM_MEETING.HUY_DUYET;
  }

  bool checkHuyDuyet() {
    return trangThaiPhong() == STATUS_ROOM_MEETING.CHO_DUYET ||
        trangThaiPhong() == STATUS_ROOM_MEETING.DA_DUYET;
  }

  bool checkThayDoiPhong() {
    return trangThaiPhong() == STATUS_ROOM_MEETING.CHO_DUYET ||
        trangThaiPhong() == STATUS_ROOM_MEETING.HUY_DUYET;
  }

  bool checkPermissionQuyenDuyetPhong() {
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_DUYET_PHONG,
    )) {
      return true;
    }
    return false;
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
          permissionTxt: PermissionAppTxt.QUYEN_DUYET_THIET_BI,
        ) &&
        (getChiTietLichHopModel.isDuyetThietBi ?? false);
  }

  ///3.check quyen duyet ky thuat
  bool checkPermissionDKT() {
    if (trangThaiPhong() != 1) return false;
    if (getChiTietLichHopModel.bit_PhongTrungTamDieuHanh ?? false) {
      return HiveLocal.checkPermissionApp(
        permissionType: PermissionType.VPDT,
        permissionTxt: PermissionAppTxt.DUYET_KY_THUAT_TTDH,
      );
    }
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: PermissionAppTxt.DUYET_KY_THUAT,
        ) ||
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: PermissionAppTxt.DUYET_KY_THUAT_TTDH,
        );
  }

  /// quyen duyet yeu cau chuan bi phong
  bool isButtonYeuCauChuanBiPhong() {
    return HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.YEU_CAU_CHUAN_BI,
    );
  }

  ///check quyen btn tu choi dkt va huy dkt: check ẩn hiện hai nút
  bool checkDuyetKyThuat() {
    return (getChiTietLichHopModel.isDuyetKyThuat ?? true) &&
        getChiTietLichHopModel.trangThaiDuyetKyThuat !=
            TRANG_THAI_DUYET_KY_THUAT.DA_DUYET;
  }

  bool checkTuChoiKyThuat() {
    return (getChiTietLichHopModel.isDuyetKyThuat ?? true) &&
        getChiTietLichHopModel.trangThaiDuyetKyThuat !=
            TRANG_THAI_DUYET_KY_THUAT.KHONG_DUYET;
  }

  /// check quyen chọn phong hop
  bool isChonPhongHop() {
    if (!isHasPhong() && (isChuTri() || isThuKy() || isNguoiTao())) {
      return true;
    }
    return false;
  }

  //check da co phong hay chua
  bool isHasPhong() {
    if (getThongTinPhongHopForPermision == ThongTinPhongHopModel() ||
        getThongTinPhongHopForPermision.tenPhong == null) {
      return false;
    }
    return true;
  }

  ///=============== check tab chuong trinh hop ===================

  ///btn them phien hop
  bool isBtnThemSuaXoaPhienHop() {
    return isChuTri() || isThuKy();
  }

  ///======================= check tab thanh phan tham gia =====================

  bool isTaoLich() {
    return getChiTietLichHopModel.createdBy == (dataUser?.userId ?? '');
  }

  ///btn moi nguoi tham gia
  bool isBtnMoiNguoiThamGia() {
    if (isChuTri() || isThuKy() || isTaoLich()) {
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
      getChiTietLichHopModel.lichHop_PhienHopStr ?? '',
    );
  }

  List<NguoiTaoStr> nguoiTao() {
    return converStringToNguoiTao(getChiTietLichHopModel.nguoiTao_str ?? '');
  }

  bool isNguoiTaoPhatBieu() {
    return (nguoiTao()[0].UserId ?? '').toLowerCase() ==
        (dataUser?.userId ?? '');
  }

  bool isChuTri() {
    return getChiTietLichHopModel.chuTriModel.canBoId.toLowerCase() ==
        (HiveLocal.getDataUser()?.userId ?? '');
  }

  bool isCreateKLH() =>
      xemKetLuanHopModel.createBy == (HiveLocal.getDataUser()?.userId ?? '');

  List<CanBoThamGiaStr> donViThamGiaPhatBieu() {
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_CU_CAN_BO,
    )) {
      return canBoThamGia()
          .where(
            (e) =>
                (e.id ?? '').isEmpty &&
                (e.donViId ?? '').toLowerCase() ==
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

  bool isNguoiThamGia() {
    return thamGia().where(
      (element) {
        final userLogin = (HiveLocal.getDataUser()?.userId ?? '').toLowerCase();
        final isCurrentUser =
            (element.CanBoId ?? '').toLowerCase() == userLogin;
        final isThuKy = element.isThuKy ?? false;
        final isUserCreate =
            (element.createdBy ?? '').toLowerCase() == userLogin;
        return isCurrentUser && !isThuKy && !isUserCreate;
      },
    ).isNotEmpty;
  }

  ///check btn dang ky phat bieu
  bool isDangKyPhatBieu() {
    if (isThanhPhanThamGia()) {
      return true;
    }
    return false;
  }

  ///======================= bieu quyet =======================
  bool isDangKyBieuQuyet() {
    if (isThanhPhanThamGia()) {
      return true;
    }
    return false;
  }

  ///btn them duyet bieu quyet
  bool isThemDuyetBieuQuyet() {
    if (isChuTri() || isThuKy()) {
      return true;
    }
    return false;
  }

  /// sua xoa bieu quyet
  bool isSuaXoaDuyetBieuQuyet() {
    if (isChuTri() || isThuKy()) {
      return true;
    }
    return false;
  }

  ///
  ///======================= ket luan hop =======================

  ///btn soan ket luan hop
  bool isSoanKetLuanHop() {
    return (isThuKy() || isChuTri()) &&
        getChiTietLichHopModel.status == STATUS_DETAIL.DA_DUYET;
  }

  //check cuoc hop da ket thuc hay chua
  bool isCuocHopDaKetThuc() {
    final int timeNow = DateTime.now().millisecondsSinceEpoch;
    final int dayEnd = DateTime.parse(
      DateTime.parse(getChiTietLichHopModel.ngayKetThuc).formatDdMMYYYY,
    ).millisecondsSinceEpoch;

    final int hourEnd =
        DateTime.parse(getChiTietLichHopModel.timeTo).millisecondsSinceEpoch;
    final int count = timeNow - (dayEnd + hourEnd);
    if (count < 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isDuyetOrHuyKetLuanHop() {
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: PermissionAppTxt.QUYEN_DUYET_KET_LUAN_HOP,
    )) {
      return true;
    }
    return false;
  }

//nhap 0
//cho duyet 1
//da duyet2
//huy duyet 3

  // button duyet kl
  bool isDuyetKL() =>
      isChuTri() && getKetLuanHopModel.trangThai == TrangThai.CHO_DUYET;

  // huy duyet kl hop
  bool isTuCHoiKL() =>
      isChuTri() && getKetLuanHopModel.trangThai == TrangThai.CHO_DUYET;

  // tọa nhiệm vụ: thu ky, chu tri;(nếu tt là nháp, chỉ hiển thị kết luận với thư ký)
  bool isTaoMoiNhiemVu() => isChuTri() || isThuKy();

  // gui duyet: thuky, trang thai kl hop = nhap va huy duyet(thu ký gửi chu tri duyet gửi duyet)
  bool isGuiDuyet() =>
      isThuKy() &&
      (getKetLuanHopModel.trangThai == TrangThai.NHAP ||
          getKetLuanHopModel.trangThai == TrangThai.TU_CHOI);

  // sua ket laun: chu tri(khi trạng thái là cho duyet) thu ky(khi trạng thái là nháp hoặc cho duyet)
  //=> chủ trì sua khi tt là cho duyet hoăc da duyet
  bool isSuaKetLuan() {
    if (isChuTri() && isCreateKLH()) {
      return getKetLuanHopModel.trangThai == TrangThai.DA_DUYET;
    }
    if (isThuKy() && isCreateKLH()) {
      return getKetLuanHopModel.trangThai == TrangThai.TU_CHOI ||
          getKetLuanHopModel.trangThai == TrangThai.NHAP;
    }
    return false;
  }

  // gửi mail: thu ky, chu trì với tt da duyet(2)
  bool isGuiMailKetLuan() {
    if ((isChuTri() || isThuKy()) &&
        getKetLuanHopModel.trangThai == TrangThai.DA_DUYET) {
      return true;
    }
    return false;
  }

  // thu hoi: thuky, tt = cho duyet(1)
  bool isThuHoi() {
    if (isThuKy() && getKetLuanHopModel.trangThai == TrangThai.CHO_DUYET) {
      return true;
    }
    return false;
  }

  // xóa: thu ký, tt = nháp(0)
  // => người tạo là chủ tri thi dc xoa
  bool isXoaKetLuanHop() =>
      (isChuTri() &&
          getKetLuanHopModel.trangThai == TrangThai.DA_DUYET &&
          isCreateKLH()) ||
      (isThuKy() &&
          getKetLuanHopModel.trangThai == TrangThai.NHAP &&
          isCreateKLH());

  //xem ket ket luan hop
  bool xemKetLuanHop() {
    if (isChuTri()) {
      if (getKetLuanHopModel.trangThai != TrangThai.NHAP) {
        return true;
      }
    }
    if (isThuKy()) {
      return true;
    }
    if (getKetLuanHopModel.trangThai == TrangThai.DA_DUYET) {
      return true;
    }
    return false;
  }
}
