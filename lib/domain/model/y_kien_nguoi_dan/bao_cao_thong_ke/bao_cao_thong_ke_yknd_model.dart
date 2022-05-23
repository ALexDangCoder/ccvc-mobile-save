class ThongKeYKNDData {
  int choTiepNhan;
  int daXuLy;
  int dangTaiCongKhai;
  int dangXuLy;
  int soLuongYKien;

  ThongKeYKNDData({
    required this.choTiepNhan,
    required this.daXuLy,
    required this.dangTaiCongKhai,
    required this.dangXuLy,
    required this.soLuongYKien,
  });
}

class ThongKeYKNDModel {
  ThongKeYKNDData thongKeYKNDData;

  ThongKeYKNDModel({required this.thongKeYKNDData});
}

class DashBoardBaoCaoYKNDData {
  String code;
  String name;
  int soLuong;

  DashBoardBaoCaoYKNDData({
    required this.code,
    required this.name,
    required this.soLuong,
  });
}

class DashBoardBaoCaoYKNDModel {
  List<DashBoardBaoCaoYKNDData> listDataDashBoard;

  DashBoardBaoCaoYKNDModel({required this.listDataDashBoard});
}

class DashBroadItemYKNDModel {
  int? chuyenXuLy = 0;
  int? yeuCauPhoiHop = 0;
  int? choBoSungThongTin = 0;
  int? choDuyet = 0;
  int? choXuLy = 0;
  int? quaHan = 0;
  int? trongHan = 0;
  int? denHan=0;

  DashBroadItemYKNDModel({
    this.chuyenXuLy,
    this.yeuCauPhoiHop,
    this.choBoSungThongTin,
    this.choDuyet,
    this.choXuLy,
    this.quaHan,
    this.trongHan,
    this.denHan,
  });
}

class ChartLinhVucKhacModel {
  List<LinhVucKhacModel> listChartData;

  ChartLinhVucKhacModel({required this.listChartData});
}

class LinhVucKhacModel {
  int linhVucId;
  String tenLinhVuc;
  int soPhanAnhKienNghi;

  LinhVucKhacModel({
    required this.linhVucId,
    required this.tenLinhVuc,
    required this.soPhanAnhKienNghi,
  });
}

class ChartDonViModel {
  List<DonViYKNDModel> listChartData;

  ChartDonViModel({required this.listChartData});
}


class DonViYKNDModel {
  String donViID;
  String tenLinhVuc;
  bool isParent;
  int soPhanAnhKienNghi;

  DonViYKNDModel({
    required this.donViID,
    required this.isParent,
    required this.tenLinhVuc,
    required this.soPhanAnhKienNghi,
  });
}


class ChartYKNDByMonthModel {
  List<YKNDByMonth> listChartData;

  ChartYKNDByMonthModel({required this.listChartData});
}
class YKNDByMonth {
  int month;
  int  quantities;


  YKNDByMonth({
    required this.month,
    required this.quantities,
  });
}

class CodeStatusYKND {
  static const CHUYEN_XU_LY = 'ChuyenXuLy';
  static const YEU_CAU_PHOI_HOP = 'YeuCauPhoiHop';
  static const CHO_BO_SUNG_THONG_TIN = 'ChoBoSungThongTin';
  static const CHO_DUYET = 'ChoDuyet';
  static const CHO_XU_LY_YKND = 'ChoXuLy';
  static const QUA_HAN_YKND = 'QuaHan';
  static const TRONG_HAN_YKND = 'TrongHan';
  static const DEN_HAN_YKND = 'DenHan';
}
