import 'dart:io';

import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///Chương Trình họp
extension ChuongTrinhHop on DetailMeetCalenderCubit {
  Future<void> getListPhienHop(String id) async {
    final result = await hopRp.getDanhSachPhienHop(id);
    result.when(
      success: (res) {
        danhSachChuongTrinhHop.sink.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getDanhSachNguoiChuTriPhienHop(String id) async {
    final result = await hopRp.getDanhSachNguoiChuTriPhienHop(id);
    result.when(
      success: (res) {
        listNguoiCHuTriModel.sink.add(res);
        dataThuKyOrThuHoiDeFault = res;
      },
      error: (error) {},
    );
  }

  Future<void> ThemPhienHop(String id) async {
    final result = await hopRp.getThemPhienHop(
      id,
      taoPhienHopRepuest.canBoId ?? '',
      taoPhienHopRepuest.donViId ?? '',
      taoPhienHopRepuest.vaiTroThamGia ?? 0,
      '${taoPhienHopRepuest.thoiGian_BatDau ?? DateTime.parse(DateTime.now().toString()).formatApi} $startTime',
      '${taoPhienHopRepuest.thoiGian_KetThuc ?? DateTime.parse(DateTime.now().toString()).formatApi} $endTime',
      taoPhienHopRepuest.noiDung ?? '',
      taoPhienHopRepuest.tieuDe ?? '',
      taoPhienHopRepuest.hoTen ?? '',
      taoPhienHopRepuest.IsMultipe,
      [],
    );
    result.when(
      success: (res) {
        getListPhienHop(id);
      },
      error: (error) {},
    );
  }

  Future<void> suaChuongTrinhHop({
    required String id,
    required String lichHopId,
    required String tieuDe,
    required String thoiGianBatDau,
    required String thoiGianKetThuc,
    required String canBoId,
    required String donViId,
    required String noiDung,
    required String? hoTen,
    required bool isMultipe,
    required List<File>? file,
  }) async {
    showLoading();

    final result = await hopRp.suaChuongTrinhHop(
      id,
      lichHopId,
      tieuDe,
      thoiGianBatDau,
      thoiGianKetThuc,
      canBoId,
      donViId,
      noiDung,
      hoTen ?? '',
      isMultipe,
      file ?? [],
    );

    result.when(
      success: (value) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> xoaChuongTrinhHop({
    required String id,
  }) async {
    showLoading();

    final result = await hopRp.xoaChuongTrinhHop(id);

    result.when(
      success: (value) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }
}