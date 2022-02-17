import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';

abstract class HomeRepository {
  Future<Result<PhamViModel>> getPhamVi();
  Future<Result<DateModel>> getLunarDate(String inputDate);
  Future<Result<List<TinhHuongKhanCapModel>>> getTinhHuongKhanCap();
  Future<Result<List<WidgetModel>>> getDashBoardConfig();
  Future<Result<DocumentDashboardModel>> getVBden(
      String ngayDauTien, String ngayCuoiCung);
  Future<Result<DocumentDashboardModel>> getVBdi(
      String ngayDauTien, String ngayCuoiCung);
}
