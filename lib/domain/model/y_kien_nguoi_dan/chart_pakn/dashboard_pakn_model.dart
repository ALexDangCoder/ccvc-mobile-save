class DashBoardPAKNModel {
  DashBoardTiepNhanPAKNModel dashBoardTiepNhanPAKNModel;
  DashBoardXuLyPAKNModel dashBoardXuLyPAKNModelModel;
  DashBoardHanXuLyPAKNModel dashBoardHanXuLyPAKNModel;

  DashBoardPAKNModel(
      {required this.dashBoardHanXuLyPAKNModel,
      required this.dashBoardTiepNhanPAKNModel,
      required this.dashBoardXuLyPAKNModelModel,});
}

class DashBoardTiepNhanPAKNModel {
  int choTiepNhan = 0;
  int phanXuLy = 0;
  int dangXuLy = 0;
  int choDuyet = 0;
  int choBoSungThongTin = 0;
  int daHoanThanh = 0;

  DashBoardTiepNhanPAKNModel({
    this.choTiepNhan = 0,
    this.phanXuLy = 0,
    this.dangXuLy = 0,
    this.choDuyet = 0,
    this.choBoSungThongTin = 0,
    this.daHoanThanh = 0,
  });
}

class DashBoardHanXuLyPAKNModel {
  int quaHan = 0;
  int denHan = 0;
  int trongHan = 0;

  DashBoardHanXuLyPAKNModel({
    this.quaHan = 0,
    this.denHan = 0,
    this.trongHan = 0,
  });
}

class DashBoardXuLyPAKNModel {
  int choTiepNhanXuLy = 0;
  int choXuLy = 0;
  int choPhanXuLy = 0;
  int choDuyet = 0;
  int daPhanCong = 0;
  int daHoanThanh = 0;

  DashBoardXuLyPAKNModel({
    this.choTiepNhanXuLy = 0,
    this.choXuLy = 0,
    this.choPhanXuLy = 0,
    this.choDuyet = 0,
    this.daPhanCong = 0,
    this.daHoanThanh = 0,
  });
}