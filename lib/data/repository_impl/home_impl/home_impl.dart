import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/home/lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/home/lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/home/nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/home/to_do_list_request.dart';
import 'package:ccvc_mobile/data/response/home/bao_chi_mang_xa_hoi_response.dart';
import 'package:ccvc_mobile/data/response/home/config_widget_dash_board_response.dart';
import 'package:ccvc_mobile/data/response/home/danh_sach_van_ban_response.dart';
import 'package:ccvc_mobile/data/response/home/dash_board_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/home/lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/home/lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/home/list_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/home/lunar_date_response.dart';
import 'package:ccvc_mobile/data/response/home/nhiem_vu_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/home/tinh_huong_khan_cap_response.dart';
import 'package:ccvc_mobile/data/response/home/todo_current_user_response.dart';
import 'package:ccvc_mobile/data/response/home/tong_hop_nhiem_vu_response.dart';
import 'package:ccvc_mobile/data/response/home/van_ban_si_so_luong_response.dart';
import 'package:ccvc_mobile/data/response/home/y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/home_service/home_service.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';

import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_model.dart';
import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_hinh_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
import 'package:ccvc_mobile/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/domain/model/home/tong_hop_nhiem_vu_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/home_repository/home_repository.dart';

class HomeImpl extends HomeRepository {
  final HomeService _homeService;
  HomeImpl(this._homeService);

  @override
  Future<Result<PhamViModel>> getPhamVi() {
    return runCatchingAsync<PhamViResponse, PhamViModel>(
      () => _homeService.getPhamVi(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DateModel>> getLunarDate(String inputDate) {
    return runCatchingAsync<LunarDateResponse, DateModel>(
      () => _homeService.getLunarDate(inputDate),
      (res) => res.resultObj?.toDomain() ?? DateModel(),
    );
  }

  @override
  Future<Result<List<TinhHuongKhanCapModel>>> getTinhHuongKhanCap() {
    return runCatchingAsync<TinhHuongKhanCapResponse,
        List<TinhHuongKhanCapModel>>(
      () => _homeService.getTinhHuongKhanCap(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<WidgetModel>>> getDashBoardConfig() {
    return runCatchingAsync<DashBoardResponse, List<WidgetModel>>(
      () => _homeService.getDashBoard(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getVBden(
    String ngayDauTien,
    String ngayCuoiCung,
  ) {
    return runCatchingAsync<DashBoardVBDenResponse, DocumentDashboardModel>(
      () => _homeService.getDashBoardVBDen(ngayDauTien, ngayCuoiCung),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getVBdi(
    String ngayDauTien,
    String ngayCuoiCung,
  ) {
    return runCatchingAsync<VanBanDiSoLuongResponse, DocumentDashboardModel>(
      () => _homeService.getDashBoardVBDi(ngayDauTien, ngayCuoiCung),
      (res) => res.data?.toDomain() ?? DocumentDashboardModel(),
    );
  }

  @override
  Future<Result<List<DocumentModel>>> getDanhSachVanBan(
    DanhSachVBRequest danhSachVBRequest,
  ) {
    return runCatchingAsync<DanhSachVanBanResponse, List<DocumentModel>>(
      () => _homeService.getDanhSachVanBan(danhSachVBRequest),
      (res) => res.data?.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<DocumentModel>>> searchDanhSachVanBan(
    SearchVBRequest searchVBRequest,
  ) {
    return runCatchingAsync<SearchDanhSachVanBanResponse, List<DocumentModel>>(
      () => _homeService.searchDanhSachVanBan(searchVBRequest),
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
      () => _homeService.getTongHopNhiemVu(isCaNhan, ngayDauTien, ngayCuoiCung),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getNhiemVu(
    NhiemVuRequest nhiemVuRequest,
  ) {
    return runCatchingAsync<NhiemVuResponse, List<CalendarMeetingModel>>(
      () => _homeService.getNhiemVu(nhiemVuRequest),
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
      () => _homeService.getYKienNguoiDan(donViId, tuNgay, denNgay),
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
      String userId,
      [String? loaiMenu]) {
    return runCatchingAsync<ListYKienNguoiDanResponse, List<DocumentModel>>(
        () => _homeService.getListYKienNguoiDan(pageSize, page, trangThai,
            tuNgay, denNgay, donViId, userId, loaiMenu),
        (res) => res.danhSachKetQua?.map((e) => e.toDomain()).toList() ?? []);
  }

  @override
  Future<Result<TodoListModel>> getListTodo() {
    return runCatchingAsync<ToDoListResponse, TodoListModel>(
      () => _homeService.getTodoList(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<TodoModel>> upDateTodo(ToDoListRequest toDoListRequest) {
    return runCatchingAsync<ToDoListUpdateResponse, TodoModel>(
      () => _homeService.updateTodoList(toDoListRequest),
      (res) => res.data?.toDomain() ?? TodoModel(),
    );
  }

  @override
  Future<Result<TodoModel>> createTodo(CreateToDoRequest createToDoRequest) {
    return runCatchingAsync<ToDoListUpdateResponse, TodoModel>(
      () => _homeService.createTodoList(createToDoRequest),
      (res) => res.data?.toDomain() ?? TodoModel(),
    );
  }

  @override
  Future<Result<List<PressNetWorkModel>>> getBaoChiMangXaHoi(int pageIndex,
      int pageSize, String fromDate, String toDate, String keyWord) {
    return runCatchingAsync<BaoChiMangXaHoiResponse, List<PressNetWorkModel>>(
      () => _homeService.getBaoChiMangXaHoi(
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
      LichLamViecRequest lamViecRequest) {
    return runCatchingAsync<LichLamViecResponse, List<CalendarMeetingModel>>(
      () => _homeService.getLichLamViec(lamViecRequest),
      (res) => res.data?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getLichHop(
      LichHopRequest lichHopRequest) {
    return runCatchingAsync<LichHopResponse, List<CalendarMeetingModel>>(
      () => _homeService.getLichHop(lichHopRequest),
      (res) => res.data?.toDomain() ?? [],
    );
  }
}
