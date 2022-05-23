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
}