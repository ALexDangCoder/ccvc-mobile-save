import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///Y kien cuoc hop
extension YKienCuocHop on DetailMeetCalenderCubit {
  Future<void> getDanhSachYKien(String id, String phienHopId) async {
    final result = await hopRp.getDanhSachYKien(id, phienHopId);
    result.when(
      success: (res) {
        listYKienCuocHop.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> themYKien({
    required String yKien,
    required String idLichHop,
    required String scheduleOpinionId,
    required String phienHopId,
  }) async {
    showLoading();
    final ThemYKienRequest themYKienRequest = ThemYKienRequest(
      content: yKien.isNotEmpty ? yKien : '',
      scheduleId: idLichHop,
      scheduleOpinionId:
          scheduleOpinionId.isNotEmpty ? scheduleOpinionId : null,
      phienHopId: phienHopId.isNotEmpty ? phienHopId : null,
    );
    final result = await hopRp.themYKienHop(themYKienRequest);
  }

  // danh sách phiên họp - ý kiến cuộc họp
  Future<void> getDanhSachPhienHop(String id) async {
    final result = await hopRp.getTongPhienHop(id);
    result.when(
      success: (res) {
        phienHop.sink.add(res.danhSachPhienHop ?? []);
      },
      error: (err) {
        return;
      },
    );
  }

  TrangThaiNhiemVu trangThaiNhiemVu(String tt) {
    switch (tt) {
      case 'CHO_PHAN_XU_LY':
        return TrangThaiNhiemVu.ChoPhanXuLy;
      case 'DANG_THUC_HIEN':
        return TrangThaiNhiemVu.DangThucHien;
      case 'DA_THUC_HIEN':
        return TrangThaiNhiemVu.DaThucHien;
    }
    return TrangThaiNhiemVu.ChoPhanXuLy;
  }
}
