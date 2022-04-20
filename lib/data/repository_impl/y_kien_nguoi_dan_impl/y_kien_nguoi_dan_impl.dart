import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/bao_cao_thong_ke_yknd_request/bao_cao_yknd_request.dart';
import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/chi_tiet_kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/danh_sach_y_kien_pakn_request.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_don_vi_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_linh_vuc_khac_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_so_luong_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/dash_board_bao_cao_yknd.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/chi_tiet_kien_nghi_respnse.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_ket_qua_y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/dash_board_phan_loai_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/dash_board_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/ket_qua_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/search_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/thong_tin_y_kien_nguoi_dan_resopnse.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/tien_trinh_xu_ly_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/y_kien_nguoi_dan/y_kien_nguoi_dan_service.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket%20_qua_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/tien_trinh_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_board_phan_loai_mode.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';

class YKienNguoiDanImpl implements YKienNguoiDanRepository {
  final YKienNguoiDanService _yKienNguoIDanService;

  YKienNguoiDanImpl(this._yKienNguoIDanService);

  @override
  Future<Result<DashboardTinhHinhXuLuModel>> dasdBoardTinhHinhXuLy(
    String donViId,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<DashBoashTinhHinhXuLyResponse,
        DashboardTinhHinhXuLuModel>(
      () => _yKienNguoIDanService.getDashBoardTinhHinhXuLy(
        donViId,
        fromDate,
        toDate,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<PhanLoaiModel>> dasdBoardPhanLoai(
    String donViId,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<DashBoashPhanLoaiResponse, PhanLoaiModel>(
      () => _yKienNguoIDanService.getDashBoardPhanLoai(
        donViId,
        fromDate,
        toDate,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ThongTinYKienModel>> thongTingNguoiDan(
      String donViId, String fromDate, String toDate,) {
    return runCatchingAsync<ThongTinYKienNguoiDanResponse, ThongTinYKienModel>(
      () => _yKienNguoIDanService.getThongTinYKienNguoiDan(
        donViId,
        fromDate,
        toDate,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DanhSachYKienNguoiDan>> danhSachYKienNguoiDan(
      String tuNgay,
      String denNgay,
      int pageSize,
      int pageNumber,
      String userId,
      String donViId,) {
    return runCatchingAsync<DanhSachYKienNguoiDanResponse,
        DanhSachYKienNguoiDan>(
      () => _yKienNguoIDanService.getDanhSachYKienNguoiDan(
        tuNgay,
        denNgay,
        pageSize,
        pageNumber,
        userId,
        donViId,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ChiTietYKNDDataModel>> chiTietYKienNguoiDan(
      String kienNghiId, String taskId,) {
    return runCatchingAsync<ChiTietKienNghiResponse, ChiTietYKNDDataModel>(
      () => _yKienNguoIDanService.chiTietYKienNguoiDan(
        ChiTietKienNghiRequest(
          kienNghiId: kienNghiId,
          taskId: taskId,
        ),
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<YKienNguoiDanModel>>> searchYKienNguoiDan(
      String tuNgay,
      String denNgay,
      int pageSize,
      int pageNumber,
      String tuKhoa,
      String userId,
      String donViId,) {
    return runCatchingAsync<SearchYKienNguoiDanResponse,
        List<YKienNguoiDanModel>>(
      () => _yKienNguoIDanService.searchDanhSachYKienNguoiDan(
        tuNgay,
        denNgay,
        pageSize,
        pageNumber,
        tuKhoa,
        userId,
        donViId,
      ),
      (res) => res.listDanhSachYKien?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<DanhSachKetQuaYKXLModel>> getDanhSachYKienPAKN(
      String kienNghiId, int type,) {
    return runCatchingAsync<DanhSachKetQuaYKXLModelResponse,
            DanhSachKetQuaYKXLModel>(
        () => _yKienNguoIDanService.getDanhSachYKienPAKN(
              DanhSachYKienPAKNRequest(
                kienNghiId: kienNghiId,
                type: type,
              ),
            ),
        (res) => res.toModel(),);
  }

  @override
  Future<Result<ThongKeYKNDModel>> baoCaoYKienNguoiDan(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) {
    return runCatchingAsync<BaoCaoYKNDResponse, ThongKeYKNDModel>(
      () => _yKienNguoIDanService.getBaoCaoYKND(
        BaoCaoYKNDRequest(
          tuNgay: startDate,
          denNgay: endDate,
          donViXuLy: listDonVi,
        ),
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DashBoardBaoCaoYKNDModel>> dashBoardBaoCaoYKND(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) {
    return runCatchingAsync<DashBoardBaoCaoYKNDResponse,
        DashBoardBaoCaoYKNDModel>(
      () => _yKienNguoIDanService.getDashBoardBaoCaoYKND(
        BaoCaoYKNDRequest(
          tuNgay: startDate,
          denNgay: endDate,
          donViXuLy: listDonVi,
        ),
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ChartLinhVucKhacModel>> chartLinhVucKhac(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) {
    return runCatchingAsync<LinhVucKhacResponse, ChartLinhVucKhacModel>(
      () => _yKienNguoIDanService.getDashBoardLinhVucKhac(
        BaoCaoYKNDRequest(
          tuNgay: startDate,
          denNgay: endDate,
          donViXuLy: listDonVi,
        ),
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ChartDonViModel>> chartDonVi(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) {
    return runCatchingAsync<DonViXuLyResponse, ChartDonViModel>(
      () => _yKienNguoIDanService.getDashBoardDonViXuLy(
        BaoCaoYKNDRequest(
          tuNgay: startDate,
          denNgay: endDate,
          donViXuLy: listDonVi,
        ),
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ChartYKNDByMonthModel>> chartSoLuongByMonth(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) {
    return runCatchingAsync<SoLuongYKNDBtMonthResponse, ChartYKNDByMonthModel>(
      () => _yKienNguoIDanService.getDashBoardSoLuongYKND(
        BaoCaoYKNDRequest(
          tuNgay: startDate,
          denNgay: endDate,
          donViXuLy: listDonVi,
        ),
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<TienTrinhXuLyModel>>> tienTrinhXuLy(String paknId) {
    return runCatchingAsync<TienTrinhXuLyResponse, List<TienTrinhXuLyModel>>(
      () => _yKienNguoIDanService.getTienTrinhXuLyYKND(
        paknId,
      ),
      (res) => res.tienTrinhXuLyData.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<List<KetQuaXuLyModel>>> ketQuaXuLy(
      String kienNghiId, String taskId,) {
    return runCatchingAsync<KetQuaXuLyResponse, List<KetQuaXuLyModel>>(
      () => _yKienNguoIDanService.getKetQuaXuLyYKND(
        kienNghiId,
        taskId,
      ),
      (res) => res.listKetQuaXuLy.map((e) => e.toDomain()).toList(),
    );
  }
}
