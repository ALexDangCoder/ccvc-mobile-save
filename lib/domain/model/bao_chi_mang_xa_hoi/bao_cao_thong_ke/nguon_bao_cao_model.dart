import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';

class NguonBaoCaoModel {
  String baoChi;
  String blog;
  String forum;
  String mangXaHoi;
  String nguonKhac;
  String total;

  NguonBaoCaoModel({
    required this.baoChi,
    required this.blog,
    required this.forum,
    required this.mangXaHoi,
    required this.nguonKhac,
    required this.total,
  });
}

class SacThaiModel {
  int trungLap;
  int tieuCuc;
  int tichCuc;

  SacThaiModel({
    required this.trungLap,
    required this.tieuCuc,
    required this.tichCuc,
  });
}

class NguonBaoCaoLineChartModel {
  List<LineChartData> baoChi;
  List<LineChartData> blog;
  List<LineChartData> forum;
  List<LineChartData> mangXaHoi;
  List<LineChartData> nguonKhac;

  NguonBaoCaoLineChartModel({
    required this.baoChi,
    required this.blog,
    required this.forum,
    required this.mangXaHoi,
    required this.nguonKhac,
  });
}

class SacThaiLineChartModel {
  List<LineChartData> trungLap;
  List<LineChartData> tieuCuc;
  List<LineChartData> tichCuc;

  SacThaiLineChartModel({
    required this.trungLap,
    required this.tieuCuc,
    required this.tichCuc,
  });
}
