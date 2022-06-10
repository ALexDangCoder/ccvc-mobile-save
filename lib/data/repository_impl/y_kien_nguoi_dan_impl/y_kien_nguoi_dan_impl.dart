import 'dart:convert';
import 'dart:io';

import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/bao_cao_thong_ke_yknd_request/bao_cao_yknd_request.dart';
import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/chi_tiet_kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/danh_sach_y_kien_pakn_request.dart';
import 'package:ccvc_mobile/data/response/dashboard_pakn/dashboard_tinh_hinh_pakn_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_don_vi_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_linh_vuc_khac_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_so_luong_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/dash_board_bao_cao_yknd.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/chi_tiet_kien_nghi_respnse.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_ket_qua_y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_pakn_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/dash_board_phan_loai_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/dash_board_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/ket_qua_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/location_address_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/search_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/thong_tin_y_kien_nguoi_dan_resopnse.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/tien_trinh_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/y_kien_nguoi_dan/y_kien_nguoi_dan_service.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/char_pakn/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/result_xin_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/tien_trinh_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_board_phan_loai_mode.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/location_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';

class YKienNguoiDanImpl implements YKienNguoiDanRepository {
  final YKienNguoiDanService _yKienNguoiDanService;

  YKienNguoiDanImpl(this._yKienNguoiDanService);

  @override
  Future<Result<DashboardTinhHinhXuLuModel>> dasdBoardTinhHinhXuLy(
    String donViId,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<DashBoashTinhHinhXuLyResponse,
        DashboardTinhHinhXuLuModel>(
      () => _yKienNguoiDanService.getDashBoardTinhHinhXuLy(
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
      () => _yKienNguoiDanService.getDashBoardPhanLoai(
        donViId,
        fromDate,
        toDate,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ThongTinYKienModel>> thongTingNguoiDan(
    String donViId,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<ThongTinYKienNguoiDanResponse, ThongTinYKienModel>(
      () => _yKienNguoiDanService.getThongTinYKienNguoiDan(
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
    String trangThai,
    int pageSize,
    int pageNumber,
    String userId,
    String donViId,
  ) {
    return runCatchingAsync<DanhSachYKienNguoiDanResponse,
        DanhSachYKienNguoiDan>(
      () => _yKienNguoiDanService.getDanhSachYKienNguoiDan(
        tuNgay,
        denNgay,
        trangThai,
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
    String kienNghiId,
    String taskId,
  ) {
    return runCatchingAsync<ChiTietKienNghiResponse, ChiTietYKNDDataModel>(
      () => _yKienNguoiDanService.chiTietYKienNguoiDan(
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
    String trangThai,
    int pageSize,
    int pageNumber,
    String tuKhoa,
    String userId,
    String donViId,
  ) {
    return runCatchingAsync<SearchYKienNguoiDanResponse,
        List<YKienNguoiDanModel>>(
      () => _yKienNguoiDanService.searchDanhSachYKienNguoiDan(
        tuNgay,
        denNgay,
        trangThai,
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
    String kienNghiId,
    int type,
  ) {
    return runCatchingAsync<DanhSachKetQuaYKXLModelResponse,
        DanhSachKetQuaYKXLModel>(
      () => _yKienNguoiDanService.getDanhSachYKienPAKN(
        DanhSachYKienPAKNRequest(
          kienNghiId: kienNghiId,
          type: type,
        ),
      ),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<ThongKeYKNDModel>> baoCaoYKienNguoiDan(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) {
    return runCatchingAsync<BaoCaoYKNDResponse, ThongKeYKNDModel>(
      () => _yKienNguoiDanService.getBaoCaoYKND(
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
      () => _yKienNguoiDanService.getDashBoardBaoCaoYKND(
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
      () => _yKienNguoiDanService.getDashBoardLinhVucKhac(
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
      () => _yKienNguoiDanService.getDashBoardDonViXuLy(
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
      () => _yKienNguoiDanService.getDashBoardSoLuongYKND(
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
      () => _yKienNguoiDanService.getTienTrinhXuLyYKND(
        paknId,
      ),
      (res) => res.tienTrinhXuLyData.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<List<KetQuaXuLyModel>>> ketQuaXuLy(
    String kienNghiId,
    String taskId,
  ) {
    return runCatchingAsync<KetQuaXuLyResponse, List<KetQuaXuLyModel>>(
      () => _yKienNguoiDanService.getKetQuaXuLyYKND(
        kienNghiId,
        taskId,
      ),
      (res) => res.listKetQuaXuLy.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<List<LocationModel>>> getLocationAddress({String? id}) {
    return runCatchingAsync<String, List<LocationModel>>(
        () => _yKienNguoiDanService.getLocationAddress(id: id), (res) {
      final List<dynamic> list = jsonDecode(res);
      return list
          .map((e) => LocationAddressResponse.fromJson(e).toModel())
          .toList();
    });
  }

  @override
  Future<Result<List<DanhSachKetQuaPAKNModel>>> getDanhSachPAKN({
    String? tuNgay,
    String? denNgay,
    String? pageSize,
    String? pageNumber,
    String? userId,
    String? donViId,
    String? tuKhoa,
  }) {
    return runCatchingAsync<DanhSachPAKNTotalResponse,
        List<DanhSachKetQuaPAKNModel>>(
      () => _yKienNguoiDanService.getDanhSachPAKN(
        tuNgay: tuNgay,
        denNgay: denNgay,
        pageNumber: pageNumber,
        pageSize: pageSize,
        donViId: donViId,
        userId: userId,
        tuKhoa: tuKhoa,
      ),
      (res) =>
          res.listDanhSachKetQuaPAKN?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ResultXinYKienNguoiDan>> postYKienXuLy(
    String nguoiChoYKien,
    String kienNghiId,
    String noiDung,
    List<File> file,
  ) {
    return runCatchingAsync<YKienXuLyResponse, ResultXinYKienNguoiDan>(
      () => _yKienNguoiDanService.postYKienXuLy(
        nguoiChoYKien,
        kienNghiId,
        noiDung,
        file,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ResultXinYKienNguoiDan>> postChoYKienYKienXuLy(
      //   String nguoiChoYKien,
      String kienNghiId,
      String noiDung,
      List<File> file) {
    return runCatchingAsync<YKienXuLyResponse, ResultXinYKienNguoiDan>(
      () => _yKienNguoiDanService.postChoYKienXuLy(
        // nguoiChoYKien,
        kienNghiId,
        noiDung,
        file,
      ),
      (res) => res.toDomain(),
    );
  }


  @override
  Future<Result<DocumentDashboardModel>> getDashboardTinhHinhXuLyPAKN(
      bool isDonVi) {
    return runCatchingAsync<DashboardTinhHinhPAKNResponse,
        DocumentDashboardModel>(
            () => _yKienNguoiDanService.getDashboardTinhHinhPAKN(isDonVi),
            (res) => res.data?.toDomain() ?? DocumentDashboardModel());
  }
}
