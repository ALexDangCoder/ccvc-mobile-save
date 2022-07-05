class ChartSuCoModel {
  List<ChartSuCoChild>? chartSuCoChild;
  int? id;

  //Null exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;

  //Null asyncState;
  bool? isFaulted;

  ChartSuCoModel({
    this.chartSuCoChild,
    this.id,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.isCompletedSuccessfully,
    this.creationOptions,
    this.isFaulted,
  });
}

class ChartSuCoChild {
  String? tenSuCo;
  List<DanhSachKhuVuc>? danhSachKhuVuc;

  ChartSuCoChild({
    this.tenSuCo,
    this.danhSachKhuVuc,
  });
}

class DanhSachKhuVuc {
  String? khuVuc;
  int? soLuong;

  DanhSachKhuVuc({
    this.khuVuc,
    this.soLuong,
  });
}
