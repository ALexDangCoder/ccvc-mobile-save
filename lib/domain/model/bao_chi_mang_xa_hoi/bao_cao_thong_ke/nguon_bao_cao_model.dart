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
