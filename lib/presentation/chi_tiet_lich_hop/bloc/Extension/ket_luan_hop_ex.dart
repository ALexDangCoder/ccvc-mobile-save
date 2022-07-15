import 'dart:io';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/thanh_phan_tham_gia_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import '../chi_tiet_lich_hop_cubit.dart';

///kết luận hop
extension KetLuanHop on DetailMeetCalenderCubit {
  Future<void> getXemKetLuanHop(String id) async {
    final result = await hopRp.getXemKetLuanHop(id);
    result.when(
      success: (res) {
        ketLuanHopSubject.sink.add(
          KetLuanHopModel(
            id: res.id ?? '',
            thoiGian: res.createAt ?? '',
            trangThai: typeTrangthai(res.status ?? 0),
            tinhTrang: typeTinhTrang(res.reportStatusCode ?? ''),
            file: res.files ?? [],
            title: res.title,
          ),
        );
        xemKetLuanHopModel = res;
        noiDung.sink.add(res.content ?? '');
      },
      error: (err) {},
    );
  }

  Future<void> getDanhSachNhiemVu(String idCuocHop) async {
    final result = await hopRp.getNhiemVuCHiTietHop(
      NhiemVuChiTietHopRequest(
        idCuocHop: idCuocHop,
        index: 1,
        isNhiemVuCaNhan: false,
        size: 1000,
      ),
    );
    result.when(
      success: (res) {
        final List<DanhSachNhiemVuLichHopModel> danhSachNhiemVuLichHopModel =
            [];
        for (final e in res) {
          danhSachNhiemVuLichHopModel.add(
            DanhSachNhiemVuLichHopModel(
              soNhiemVu: e.soNhiemVu,
              noiDungTheoDoi: e.noiDungTheoDoi,
              tinhHinhThucHienNoiBo: e.tinhHinhThucHienNoiBo,
              hanXuLy: e.hanXuLy,
              loaiNhiemVu: e.loaiNhiemVu,
              trangThai: trangThaiNhiemVu(e.maTrangThai),
              id: e.id,
            ),
          );
          danhSachNhiemVuLichHopSubject.sink.add(danhSachNhiemVuLichHopModel);
        }
      },
      error: (err) {},
    );
  }

  TrangThai typeTrangthai(int value) {
    switch (value) {
      case 2:
        return TrangThai.DA_DUYET;
      case 0:
        return TrangThai.NHAP;
      case 3:
        return TrangThai.TU_CHOI;
      default:
        return TrangThai.CHO_DUYET;
    }
  }

  TinhTrang typeTinhTrang(String value) {
    switch (value) {
      case 'trung-binh':
        return TinhTrang.TRUNG_BINH;
      case 'dat':
        return TinhTrang.DAT;
      default:
        return TinhTrang.KHONG_DAT;
    }
  }

  Future<void> suaKetLuan({
    required String reportStatusId,
    required String reportTemplateId,
    List<File>? files,
  }) async {
    showLoading();
    final result = await hopRp.suaKetLuan(
      idCuocHop,
      noiDung.value,
      reportStatusId,
      reportTemplateId,
      [],
    );

    result.when(
      success: (value) {
        showContent();
        getXemKetLuanHop(idCuocHop);
      },
      error: (error) {
        showContent();
        MessageConfig.show(title: S.current.that_bai);
      },
    );
    showContent();
  }

  Future<void> postChonMauHop() async {
    showLoading();
    final ChonBienBanHopRequest chonBienBanHopRequest =
        ChonBienBanHopRequest(1, 10);
    final result = await hopRp.postChonMauBienBanHop(chonBienBanHopRequest);

    result.when(
      success: (value) {
        showContent();
        dataMauBienBan.sink.add(value);
        data = value.items.map((e) => e.content).toList();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> listStatusKetLuanHop() async {
    final result = await hopRp.getListStatusKetLuanHop();

    result.when(
      success: (success) {
        dataTinhTrangKetLuanHop.sink.add(success);
      },
      error: (error) {},
    );
  }

  void getValueMauBienBan(int value) {
    noiDung.sink.add(data[value] ?? '');
  }

  void clearData() {
    dataLoaiNhiemVu.clear();
    checkValidateLoaiNV.sink.add(false);
  }

  String getTextAfterEdit(String value) {
    noiDung.sink.add(value);
    return value;
  }

  String getValueMauBienBanWithId(String id) {
    final dataBienBan = dataMauBienBan.value;
    for (final e in dataBienBan.items) {
      if (e.id == id) {
        return e.name;
      }
    }
    return '';
  }

  Future<bool> deleteKetLuanHop(String id) async {
    bool isCheck = true;
    showLoading();
    final result = await hopRp.deleteKetLuanHop(id);
    result.when(
      success: (res) {
        showContent();
        MessageConfig.show(
          title: S.current.thanh_cong,
        );
        getDanhSachNhiemVu(idCuocHop);
        isCheck = true;
      },
      error: (err) {
        showContent();
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
        isCheck = false;
      },
    );
    showContent();
    return isCheck;
  }

  Future<void> sendMailKetLuatHop(String idSendmail) async {
    showLoading();
    final result = await hopRp.sendMailKetLuanHop(idSendmail);
    result.when(
      success: (res) {
        showContent();
      },
      error: (err) {
        showContent();
        MessageConfig.show(title: S.current.that_bai);
      },
    );
    showContent();
  }

  Future<void> getDanhSachLoaiNhiemVu() async {
    final result = await hopRp.getDanhSachLoaiNhiemVu();
    result.when(
      success: (res) {
        danhSachLoaiNhiemVuLichHopModel = res;
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> themNhiemVu(ThemNhiemVuRequest themNhiemVuRequest) async {
    showLoading();
    for (final value in listVBGiaoNhiemVu.value) {
      themNhiemVuRequest.danhSachVanBan?.add(
        DanhSachVanBanRequest(
          hinhThucVanBan: value.hinhThucVanBan,
          ngayVanBan: value.ngayVanBan,
          soVanBan: value.soVanBan,
          trichYeu: value.trichYeu,
        ),
      );
    }
    final result = await hopRp.postThemNhiemVu(themNhiemVuRequest);
    result.when(
      success: (res) {
        showContent();
        getDanhSachNhiemVu(idCuocHop);
        MessageConfig.show(title: S.current.thanh_cong);
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
      },
    );
    showContent();
  }

  Future<void> xacNhanHoacHuyKetLuanHop({
    required bool isDuyet,
  }) async {
    showLoading();
    final result = await hopRp.xacNhanHoacHuyKetLuanHop(
      idCuocHop,
      isDuyet,
      '',
    );
    result.when(
      success: (res) {
        showContent();
        getXemKetLuanHop(idCuocHop);
      },
      error: (err) {
        showContent();
        MessageConfig.show(title: S.current.that_bai);
      },
    );
    showContent();
  }

  Future<bool> createKetLuanHop({
    required String reportStatusId,
    required String reportTemplateId,
    required List<File> files,
  }) async {
    showLoading();
    final result = await hopRp.createKetLuanHop(
      idCuocHop,
      reportStatusId,
      reportTemplateId,
      noiDung.value,
      files,
      // [],
    );
    result.when(
      success: (res) {
        showContent();
        if (res) {
          getXemKetLuanHop(idCuocHop);
        }
        return true;
      },
      error: (err) {
        showContent();
        MessageConfig.show(title: S.current.that_bai);
        return false;
      },
    );
    showContent();
    return true;
  }

  Future<void> guiDuyetKetLuanHop() async {
    showLoading();
    final result = await hopRp.guiDuyetKetLuanHop(
      idCuocHop,
    );
    result.when(
      success: (res) {
        showContent();
        getXemKetLuanHop(idCuocHop);
      },
      error: (err) {
        showContent();
        MessageConfig.show(title: S.current.that_bai);
      },
    );
    showContent();
  }

  Future<void> thuHoiKetLuanHop() async {
    showLoading();
    final result = await hopRp.thuHoiKetLuanHop(
      idCuocHop,
    );
    result.when(
      success: (res) {
        showContent();
        getXemKetLuanHop(idCuocHop);
      },
      error: (err) {
        showContent();
        MessageConfig.show(title: S.current.that_bai);
      },
    );
    showContent();
  }

  void callApiKetLuanHop() {
    getXemKetLuanHop(idCuocHop);
    getDanhSachNhiemVu(idCuocHop);
    getDanhSachLoaiNhiemVu();
    listStatusKetLuanHop();
    danhSachCanBoTPTG(id: idCuocHop);
    getDanhSachNguoiChuTriPhienHop('');
    postChonMauHop();
  }
}
