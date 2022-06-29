import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/thanh_phan_tham_gia_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';

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
            thoiGian: '',
            trangThai: typeTrangthai(res.status ?? 0),
            tinhTrang: typeTinhTrang(res.reportStatusCode ?? ''),
            file: res.files?.map((e) => e.Name ?? '').toList() ?? [],
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
      case 1:
        return TrangThai.ChoDuyet;
      case 2:
        return TrangThai.DaDuyet;
      case 3:
        return TrangThai.ChuaGuiDuyet;
      case 4:
        return TrangThai.HuyDuyet;
      default:
        return TrangThai.ChoDuyet;
    }
  }

  TinhTrang typeTinhTrang(String value) {
    switch (value) {
      case 'trung-binh':
        return TinhTrang.TrungBinh;
      case 'dat':
        return TinhTrang.Dat;
      case 'chua-dat':
        return TinhTrang.ChuaDat;
      default:
        return TinhTrang.TrungBinh;
    }
  }

  Future<void> suaKetLuan({
    required String scheduleId,
    required String reportStatusId,
    required String reportTemplateId,
    List<File>? files,
  }) async {
    final result = await hopRp.suaKetLuan(
      scheduleId,
      noiDung.value,
      reportStatusId,
      reportTemplateId,
      [],
    );

    result.when(
      success: (value) {},
      error: (error) {},
    );
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

  Future<void> deleteKetLuanHop(String id) async {
    final result = await hopRp.deleteKetLuanHop(id);
    result.when(success: (res) {}, error: (err) {});
  }

  Future<void> sendMailKetLuatHop(String idSendmail) async {
    showLoading();
    final result = await hopRp.sendMailKetLuanHop(idSendmail);
    result.when(
      success: (res) {
        showContent();
      },
      error: (err) {
        showError();
      },
    );
  }

  Future<void> getDanhSachLoaiNhiemVu() async {
    final result = await hopRp.getDanhSachLoaiNhiemVu();
    result.when(
      success: (res) {
        danhSachLoaiNhiemVuLichHopModel.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> themNhiemVu(ThemNhiemVuRequest themNhiemVuRequest) async {
    final result = await hopRp.postThemNhiemVu(themNhiemVuRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
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
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> createKetLuanHop({
    required String lichHopId,
    required String scheduleId,
    required String reportStatusId,
    required String reportTemplateId,
    required String startDate,
    required String endDate,
    required String content,
    required List<String> files,
    required List<String> filesDelete,
  }) async {
    showLoading();
    final result = await hopRp.createKetLuanHop(
      lichHopId,
      scheduleId,
      reportStatusId,
      reportTemplateId,
      startDate,
      endDate,
      content,
      files,
      filesDelete,
    );
    result.when(
      success: (res) {
        showContent();
      },
      error: (err) {
        showError();
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
    postChonMauHop();
  }
}
