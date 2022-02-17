import 'package:ccvc_mobile/data/response/home/config_widget_dash_board_response.dart';
import 'package:ccvc_mobile/data/response/home/dash_board_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/home/lunar_date_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/home/tinh_huong_khan_cap_response.dart';
import 'package:ccvc_mobile/data/response/home/van_ban_si_so_luong_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/home_service/home_service.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
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
      String ngayDauTien, String ngayCuoiCung) {
    return runCatchingAsync<VanBanDiSoLuongResponse, DocumentDashboardModel>(
      () => _homeService.getDashBoardVBDi(ngayDauTien, ngayCuoiCung),
      (res) => res.data?.toDomain() ?? DocumentDashboardModel(),
    );
  }
}
