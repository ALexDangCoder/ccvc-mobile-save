class VanBanDonViModel {
  String donViId;
  String label;
  DataXuLy dataXuLy;
  DataTrangThai dataTrangThai;

  VanBanDonViModel({
    required this.donViId,
    required this.label,
    required this.dataXuLy,
    required this.dataTrangThai,
  });
}

class DataXuLy {
  int denHan;
  int quaHan;
  int trongHan;

  DataXuLy({
    required this.denHan,
    required this.quaHan,
    required this.trongHan,
  });

  DataXuLy.empty({
    this.denHan = 0,
    this.quaHan = 0,
    this.trongHan = 0,
  });
}

class DataTrangThai {
  int choXuLy;
  int dangXuLy;
  int daXuLy;

  DataTrangThai({
    required this.choXuLy,
    required this.dangXuLy,
    required this.daXuLy,
  });

  DataTrangThai.empty({
    this.choXuLy = 0,
    this.dangXuLy = 0,
    this.daXuLy = 0,
  });
}
