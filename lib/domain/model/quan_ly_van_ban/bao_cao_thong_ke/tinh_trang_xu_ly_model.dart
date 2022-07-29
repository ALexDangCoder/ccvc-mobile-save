class TinhTrangXuLyModel {
  String label;
  int VanBanDi;
  int VanBanDen;

  TinhTrangXuLyModel(
      {required this.label, required this.VanBanDi, required this.VanBanDen});

  TinhTrangXuLyModel.empty({
    this.label = '',
    this.VanBanDi = 0,
    this.VanBanDen = 0,
  });
}
