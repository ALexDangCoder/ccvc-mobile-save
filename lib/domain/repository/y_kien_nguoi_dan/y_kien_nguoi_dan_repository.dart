import 'dart:io';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/result_xin_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/tien_trinh_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_board_phan_loai_mode.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/location_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_xy_ly_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';

mixin YKienNguoiDanRepository {
  Future<Result<DashboardTinhHinhXuLuModel>> dasdBoardTinhHinhXuLy(
    String donViId,
    String fromDate,
    String toDate,
  );

  Future<Result<DocumentDashboardModel>> getDashboardTinhHinhXuLyPAKN(
    bool isDonVi,
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
    String trangThai,
    int pageSize,
    int pageNumber,
    String userId,
    String donViId,
  );

  Future<Result<ChiTietYKNDDataModel>> chiTietYKienNguoiDan(
    String KienNghiId,
    String TaskId,
  );

  Future<Result<ThongTinXuLyPAKNModel>> thongTinXuLyPAKN(
    String KienNghiId,
    String TaskId,
  );

  Future<Result<List<YKienNguoiDanModel>>> searchYKienNguoiDan(
    String tuNgay,
    String denNgay,
    String trangThai,
    int pageSize,
    int pageNumber,
    String tuKhoa,
    String userId,
    String donViId,
  );

  Future<Result<DanhSachKetQuaYKXLModel>> getDanhSachYKienPAKN({
    String? kienNghiId,
    int? type,
  });

  Future<Result<ThongKeYKNDModel>> baoCaoYKienNguoiDan(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  });

  Future<Result<DashBoardBaoCaoYKNDModel>> dashBoardBaoCaoYKND(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  });

  Future<Result<ChartLinhVucKhacModel>> chartLinhVucKhac(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  });

  Future<Result<ChartDonViModel>> chartDonVi(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  });

  Future<Result<ChartYKNDByMonthModel>> chartSoLuongByMonth(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  });

  Future<Result<List<TienTrinhXuLyModel>>> tienTrinhXuLy(
    String paknId,
  );

  Future<Result<List<KetQuaXuLyModel>>> ketQuaXuLy(
    String kienNghiId,
    String taskId,
  );

  Future<Result<List<LocationModel>>> getLocationAddress({String? id});


  Future<Result<List<DanhSachKetQuaPAKNModel>>> getDanhSachPaknFilter({
    int? pageIndex,
    int? pageSize,
    String? trangThai,
    String? loaiMenu,
    String? dateFrom,
    String? dateTo,
    int? hanXuLy,
    String? userId,
    String? donViId,
    String? tuKhoa,
  });

  Future<Result<List<DanhSachKetQuaPAKNModel>>> getDanhSachPAKN({
    String? tuNgay,
    String? denNgay,
    String? pageSize,
    String? pageNumber,
    String? trangThai,
    String? userId,
    String? donViId,
    String? tuKhoa,
  });

  Future<Result<List<DanhSachKetQuaPAKNModel>>> getDanhSachChoTaoVBDi({
    int? pageIndex,
    int? pageSize,
    String? donViId,
    String? dateFrom,
    String? dateTo,
    int? trangThaiVanBanDi,
  });

  Future<Result<List<DanhSachKetQuaPAKNModel>>> getDanhSachPAKNXuLyCacYKien({
    int? pageIndex,
    int? pageSize,
    String? dateFrom,
    String? dateTo,
    bool? daChoYKien,
  });

  Future<Result<ResultXinYKienNguoiDan>> postYKienXuLy(
    String nguoiChoYKien,
    String kienNghiId,
    String noiDung,
    List<File> file,
  );

  Future<Result<ResultXinYKienNguoiDan>> postChoYKienYKienXuLy(
    // String nguoiChoYKien,
    String kienNghiId,
    String noiDung,
    List<File> file,
  );

  Future<Result<DashBoardPAKNModel>> getDashBoardPAKNTiepNhanXuLy(
    String dateFrom,
    String dateTo,
  );

  Future<Result<List<int>>> getBaoCaoPieChart(
      int filterBy,
      bool isAll,
      );
}
