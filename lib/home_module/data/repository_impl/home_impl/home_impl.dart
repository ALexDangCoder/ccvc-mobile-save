import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/home_module/data/request/account/gui_loi_chuc_request.dart';
import 'package:ccvc_mobile/home_module/data/request/home/tong_hop_nhiem_vu_request.dart';
import 'package:ccvc_mobile/home_module/data/response/home/danh_sach_thiep_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/dashboard_tinh_hinh_pakn_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/get_weather_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/gui_loi_chuc_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/nguoi_gan_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/van_ban_don_vi_response.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/message_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/nguoi_gan_cong_viec_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/thiep_sinh_nhat_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/van_ban_don_vi_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/weather_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/y_kien_nguoi_dan_model.dart';

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
import '/home_module/domain/repository/home_repository/home_repository.dart';

class HomeImpl extends HomeRepository {
  final HomeServiceGateWay _homeServiceGateWay;
  final HomeServiceCCVC _homeServiceCCVC;
  final HomeServiceCommon _homeServiceCommon;

  HomeImpl(
    this._homeServiceGateWay,
    this._homeServiceCCVC,
    this._homeServiceCommon,
  );

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
  Future<Result<List<TinBuonModel>>> getTinBuon() {
    return runCatchingAsync<TinhHuongKhanCapResponse, List<TinBuonModel>>(
      () => _homeServiceCCVC.getTinBuon(),
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
  Future<Result<DocumentDashboardModel>> getTongHopNhiemVu(
    // String userId,
    String canBoId,
    // String donViId,
  ) {
    return runCatchingAsync<TongHopNhiemVuResponse, DocumentDashboardModel>(
      () => _homeServiceGateWay.getTongHopNhiemVu(
        TongHopNhiemVuRequest(canBoID: canBoId),
      ),
      (res) => res.data?.toDomain() ?? DocumentDashboardModel(),
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getNhiemVu(
    NhiemVuRequest nhiemVuRequest,
  ) {
    return runCatchingAsync<NhiemVuResponse, List<CalendarMeetingModel>>(
      () => _homeServiceGateWay.getNhiemVu(nhiemVuRequest),
      (res) => res.data?.pageData?.map((e) => e.toDomain()).toList() ?? [],
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
  Future<Result<List<YKienNguoiDanModel>>> getYKienNguoidan(
    int pageSize,
    int page,
    String trangThai,
    String tuNgay,
    String denNgay,
    String donViId,
    String userId, [
    String? loaiMenu,
  ]) {
    return runCatchingAsync<ListYKienNguoiDanResponse,
        List<YKienNguoiDanModel>>(
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

  @override
  Future<Result<MessageModel>> guiLoiChuc(GuiLoiChucRequest guiLoiChucRequest) {
    return runCatchingAsync<GuiLoiChucResponse, MessageModel>(
        () => _homeServiceCCVC.guiLoiChuc(guiLoiChucRequest),
        (res) => res.toDomain());
  }

  @override
  Future<Result<List<ThiepSinhNhatModel>>> listThiepMoi() {
    return runCatchingAsync<DanhSachThiepResponse, List<ThiepSinhNhatModel>>(
      () => _homeServiceCCVC.getDanhSachThiep(1, 100),
      (res) => res.data?.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getDashboardTinhHinhXuLyPAKN(
      bool isDonVi) {
    return runCatchingAsync<DashboardTinhHinhPAKNResponse,
            DocumentDashboardModel>(
        () => _homeServiceGateWay.getDashboardTinhHinhPAKN(isDonVi),
        (res) => res.data?.toDomain() ?? DocumentDashboardModel());
  }

  @override
  Future<Result<VanBanDonViModel>> getTinhHinhXuLyVanBan(
      String canBoId, String donViId, String startDate, String endDate) {
    return runCatchingAsync<VanBanDonViResponse, VanBanDonViModel>(
      () => _homeServiceGateWay.getTinhHinhXuLyVanBan(
        canBoId,
        donViId,
        startDate,
        endDate,
      ),
      (res) =>
          res.data?.toDomain() ??
          VanBanDonViModel(
              vbDen: DocumentDashboardModel(), vbDi: DocumentDashboardModel()),
    );
  }

  @override
  Future<Result<NguoiGanCongViecModel>> listNguoiGanCongViec(
    bool isGetAll,
    int pageSize,
    int pageIndex,
    String kerSearch,
  ) {
    return runCatchingAsync<NguoiGanResponse, NguoiGanCongViecModel>(
      () => _homeServiceCommon.getListNguoiGan(
        pageIndex,
        pageSize,
        isGetAll,
        kerSearch,
      ),
      (res) => res.data?.toDomain() ?? NguoiGanCongViecModel(items: []),
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getDashboardTinhHinhXuLyPAKNCaNhan() {
    return runCatchingAsync<TinhHinhXuLyPAKNCaNhan, DocumentDashboardModel>(
        () => _homeServiceGateWay.getDashboardTinhHinhPAKNCaNhan(),
        (res) => res.toDomain());
  }

  @override
  Future<Result<WeatherModel>> getWeather(String code) {
    return runCatchingAsync<WeatherResponse, WeatherModel>(
      () => _homeServiceGateWay.getWeather(code),
      (res) => res.toModel,
    );
  }
}
