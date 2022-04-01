
import 'package:ccvc_mobile/data/result/result.dart';

import '/home_module/data/request/home/danh_sach_cong_viec_resquest.dart';
import '/home_module/data/request/home/danh_sach_van_ban_den_request.dart';
import '/home_module/data/request/home/lich_hop_request.dart';
import '/home_module/data/request/home/lich_lam_viec_request.dart';
import '/home_module/data/request/home/nhiem_vu_request.dart';
import '/home_module/data/request/home/to_do_list_request.dart';
import '/home_module/data/response/home/bao_chi_mang_xa_hoi_response.dart';
import '/home_module/data/response/home/config_widget_dash_board_response.dart';
import '/home_module/data/response/home/danh_sach_cong_viec_response.dart';
import '/home_module/data/response/home/danh_sach_van_ban_response.dart';
import '/home_module/data/response/home/dash_board_van_ban_den_response.dart';
import '/home_module/data/response/home/lich_hop_response.dart';
import '/home_module/data/response/home/lich_lam_viec_response.dart';
import '/home_module/data/response/home/list_y_kien_nguoi_dan_response.dart';
import '/home_module/data/response/home/lunar_date_response.dart';
import '/home_module/data/response/home/nhiem_vu_response.dart';
import '/home_module/data/response/home/pham_vi_response.dart';
import '/home_module/data/response/home/sinh_nhat_user_response.dart';
import '/home_module/data/response/home/su_kien_response.dart';
import '/home_module/data/response/home/tinh_huong_khan_cap_response.dart';
import '/home_module/data/response/home/todo_current_user_response.dart';
import '/home_module/data/response/home/tong_hop_nhiem_vu_response.dart';
import '/home_module/data/response/home/van_ban_si_so_luong_response.dart';
import '/home_module/data/response/home/y_kien_nguoi_dan_response.dart';
import '/home_module/data/service/home_service/home_service.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/calendar_metting_model.dart';
import '/home_module/domain/model/home/date_model.dart';
import '/home_module/domain/model/home/document_dashboard_model.dart';
import '/home_module/domain/model/home/document_model.dart';
import '/home_module/domain/model/home/pham_vi_model.dart';
import '/home_module/domain/model/home/press_network_model.dart';
import '/home_module/domain/model/home/sinh_nhat_model.dart';
import '/home_module/domain/model/home/su_kien_model.dart';
import '/home_module/domain/model/home/tinh_hinh_y_kien_model.dart';
import '/home_module/domain/model/home/tinh_huong_khan_cap_model.dart';
import '/home_module/domain/model/home/todo_model.dart';
import '/home_module/domain/model/home/tong_hop_nhiem_vu_model.dart';
import '/home_module/domain/repository/home_repository/home_repository.dart';

class HomeImpl extends HomeRepository {
  final HomeServiceGateWay _homeServiceGateWay;
  final HomeServiceCCVC _homeServiceCCVC;
  HomeImpl(this._homeServiceGateWay, this._homeServiceCCVC);

  @override
  Future<Result<PhamViModel>> getPhamVi() {
    return runCatchingAsync<PhamViResponse, PhamViModel>(
      () => _homeServiceGateWay.getPhamVi(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DateModel>> getLunarDate(String inputDate) {
    return runCatchingAsync<LunarDateResponse, DateModel>(
      () => _homeServiceCCVC.getLunarDate(inputDate),
      (res) => res.resultObj?.toDomain() ?? DateModel(),
    );
  }

  @override
  Future<Result<List<TinhHuongKhanCapModel>>> getTinhHuongKhanCap() {
    return runCatchingAsync<TinhHuongKhanCapResponse,
        List<TinhHuongKhanCapModel>>(
      () => _homeServiceCCVC.getTinhHuongKhanCap(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<WidgetModel>>> getDashBoardConfig() {
    return runCatchingAsync<DashBoardResponse, List<WidgetModel>>(
      () => _homeServiceCCVC.getDashBoard(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getVBden(
    String ngayDauTien,
    String ngayCuoiCung,
  ) {
    return runCatchingAsync<DashBoardVBDenResponse, DocumentDashboardModel>(
      () => _homeServiceGateWay.getDashBoardVBDen(ngayDauTien, ngayCuoiCung),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getVBdi(
    String ngayDauTien,
    String ngayCuoiCung,
  ) {
    return runCatchingAsync<VanBanDiSoLuongResponse, DocumentDashboardModel>(
      () => _homeServiceGateWay.getDashBoardVBDi(ngayDauTien, ngayCuoiCung),
      (res) => res.data?.toDomain() ?? DocumentDashboardModel(),
    );
  }

  @override
  Future<Result<List<DocumentModel>>> getDanhSachVanBan(
    DanhSachVBRequest danhSachVBRequest,
  ) {
    return runCatchingAsync<DanhSachVanBanResponse, List<DocumentModel>>(
      () => _homeServiceGateWay.getDanhSachVanBan(danhSachVBRequest),
      (res) => res.data?.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<DocumentModel>>> searchDanhSachVanBan(
    SearchVBRequest searchVBRequest,
  ) {
    return runCatchingAsync<SearchDanhSachVanBanResponse, List<DocumentModel>>(
      () => _homeServiceGateWay.searchDanhSachVanBan(searchVBRequest),
      (res) => res.data?.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TongHopNhiemVuModel>>> getTongHopNhiemVu(
    bool isCaNhan,
    String ngayDauTien,
    String ngayCuoiCung,
  ) {
    return runCatchingAsync<TongHopNhiemVuResponse, List<TongHopNhiemVuModel>>(
      () => _homeServiceGateWay.getTongHopNhiemVu(
        isCaNhan,
        ngayDauTien,
        ngayCuoiCung,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getNhiemVu(
    NhiemVuRequest nhiemVuRequest,
  ) {
    return runCatchingAsync<NhiemVuResponse, List<CalendarMeetingModel>>(
      () => _homeServiceGateWay.getNhiemVu(nhiemVuRequest),
      (res) => res.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TinhHinhYKienModel>>> getTinhHinhYKienNguoiDan(
    String donViId,
    String tuNgay,
    String denNgay,
  ) {
    return runCatchingAsync<YKienNguoiDanResponse, List<TinhHinhYKienModel>>(
      () => _homeServiceGateWay.getYKienNguoiDan(donViId, tuNgay, denNgay),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<DocumentModel>>> getYKienNguoidan(
    int pageSize,
    int page,
    String trangThai,
    String tuNgay,
    String denNgay,
    String donViId,
    String userId, [
    String? loaiMenu,
  ]) {
    return runCatchingAsync<ListYKienNguoiDanResponse, List<DocumentModel>>(
      () => _homeServiceGateWay.getListYKienNguoiDan(
        pageSize,
        page,
        trangThai,
        tuNgay,
        denNgay,
        donViId,
        userId,
        loaiMenu,
      ),
      (res) => res.danhSachKetQua?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<TodoListModel>> getListTodo() {
    return runCatchingAsync<ToDoListResponse, TodoListModel>(
      () => _homeServiceCCVC.getTodoList(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<TodoModel>> upDateTodo(ToDoListRequest toDoListRequest) {
    return runCatchingAsync<ToDoListUpdateResponse, TodoModel>(
      () => _homeServiceCCVC.updateTodoList(toDoListRequest),
      (res) => res.data?.toDomain() ?? TodoModel(),
    );
  }

  @override
  Future<Result<TodoModel>> createTodo(CreateToDoRequest createToDoRequest) {
    return runCatchingAsync<ToDoListUpdateResponse, TodoModel>(
      () => _homeServiceCCVC.createTodoList(createToDoRequest),
      (res) => res.data?.toDomain() ?? TodoModel(),
    );
  }

  @override
  Future<Result<List<PressNetWorkModel>>> getBaoChiMangXaHoi(
    int pageIndex,
    int pageSize,
    String fromDate,
    String toDate,
    String keyWord,
  ) {
    return runCatchingAsync<BaoChiMangXaHoiResponse, List<PressNetWorkModel>>(
      () => _homeServiceCCVC.getBaoChiMangXaHoi(
        pageIndex,
        pageSize,
        fromDate,
        toDate,
        keyWord,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getListLichLamViec(
    LichLamViecRequest lamViecRequest,
  ) {
    return runCatchingAsync<LichLamViecResponse, List<CalendarMeetingModel>>(
      () => _homeServiceGateWay.getLichLamViec(lamViecRequest),
      (res) => res.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getLichHop(
    LichHopRequest lichHopRequest,
  ) {
    return runCatchingAsync<LichHopResponse, List<CalendarMeetingModel>>(
      () => _homeServiceGateWay.getLichHop(lichHopRequest),
      (res) => res.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<SuKienModel>>> getSuKien(String dateFrom, String dateTo) {
    return runCatchingAsync<SuKienResponse, List<SuKienModel>>(
      () => _homeServiceCCVC.getSuKien(dateFrom, dateTo),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<SinhNhatUserModel>>> getSinhNhat(
    String dataFrom,
    String dateTo,
  ) {
    return runCatchingAsync<SinhNhatUserResponse, List<SinhNhatUserModel>>(
      () => _homeServiceCCVC.getSinhNhat(dataFrom, dateTo),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getDanhSachCongViec(
      DanhSachCongViecRequest request) {
    return runCatchingAsync<DanhSachCongViecResponse,
            List<CalendarMeetingModel>>(
        () => _homeServiceGateWay.getDanhSachCongViec(request),
        (res) => res.pageData?.map((e) => e.toDomain()).toList() ?? []);
  }
}
