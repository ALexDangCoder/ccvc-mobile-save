class VanBanDonViModel {
  VBDenDonVi vbDen;
  VBDiDonVi vbDi;

  VanBanDonViModel({required this.vbDen, required this.vbDi});
}

class VBDenDonVi {
  int choVaoSo;
  int choXuLy;
  int dangXuLy;
  int daXuLy;
  int quaHan;
  int trongHan;
  int denHan;

  VBDenDonVi({
    this.choVaoSo=0,
    this.choXuLy=0,
    this.dangXuLy=0,
    this.daXuLy=0,
    this.quaHan=0,
    this.trongHan=0,
    this.denHan=0,
  });
}

class VBDiDonVi {
  int choTrinhKy;
  int choXuLy;
  int daXuLy;
  int choCapSo;
  int choBanHanh;

  VBDiDonVi({
    this.choTrinhKy=0,
    this.choXuLy=0,
    this.daXuLy=0,
    this.choCapSo=0,
    this.choBanHanh=0,
  });
}
