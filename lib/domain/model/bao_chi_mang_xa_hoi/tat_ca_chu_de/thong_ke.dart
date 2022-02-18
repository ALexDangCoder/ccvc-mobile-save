class ThongKe {
  int BaoChi = 0;
  int Blog = 0;
  int Forum = 0;
  int MangXaHoi = 0;
  int NguonKhac = 0;
  int TongTin = 0;

  ThongKe.Empty();

  ThongKe({
    required this.BaoChi,
    required this.Blog,
    required this.Forum,
    required this.MangXaHoi,
    required this.NguonKhac,
    required this.TongTin,
  });

  factory ThongKe.fromJson(Map<String, dynamic> json) {
    return ThongKe(
        BaoChi: json['BaoChi'],
        Blog: json['Blog'],
        Forum: json['Forum'],
        MangXaHoi: json['MangXaHoi'],
        NguonKhac: json['NguonKhac'],
        TongTin: json['TongTin']);
  }
}
