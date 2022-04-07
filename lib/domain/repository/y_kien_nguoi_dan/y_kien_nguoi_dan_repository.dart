import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/bao_cao_thong_ke_yknd_request/bao_cao_yknd_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_board_phan_loai_mode.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';

mixin YKienNguoiDanRepository {
  Future<Result<DashboardTinhHinhXuLuModel>> dasdBoardTinhHinhXuLy(
    String donViId,
    String fromDate,
    String toDate,
  );

  Future<Result<PhanLoaiModel>> dasdBoardPhanLoai(
    String donViId,
    String fromDate,
    String toDate,
  );

  Future<Result<ThongTinYKienModel>> thongTingNguoiDan(
    String donViId,
    String fromDate,
    String toDate,
  );

  Future<Result<DanhSachYKienNguoiDan>> danhSachYKienNguoiDan(
    String tuNgay,
    String denNgay,
    int pageSize,
    int pageNumber,
    String userId,
    String donViId,
  );

  Future<Result<ChiTietYKNDDataModel>> chiTietYKienNguoiDan(
    String KienNghiId,
    String TaskId,
  );

  Future<Result<DanhSachYKienNguoiDan>> searchYKienNguoiDan(
    String tuNgay,
    String denNgay,
    int pageSize,
    int pageNumber,
    String tuKhoa,
    String userId,
    String donViId,
  );

  Future<Result<DanhSachKetQuaYKXLModel>> getDanhSachYKienPAKN(
    String KienNghiId,
    int type,
  );

  Future<Result<ThongKeYKNDModel>> baoCaoYKienNguoiDan(
    String startDate,
    String endDate,
  );
  Future<Result<DashBoardBaoCaoYKNDModel>> dashBoardBaoCaoYKND(
      String startDate,
      String endDate,
      );

  Future<Result<ChartLinhVucKhacModel>> chartLinhVucKhac(
      String startDate,
      String endDate,
      );

  Future<Result<ChartDonViModel>> chartDonVi(
      String startDate,
      String endDate,
      );

  Future<Result<ChartYKNDByMonthModel>> chartSoLuongByMonth(
      String startDate,
      String endDate,
      );
}
