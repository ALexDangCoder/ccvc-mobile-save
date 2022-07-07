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
  String? khuVuc;
  String? taskId;
  List<DanhSachKhuVuc>? danhSachKhuVuc;

  ChartSuCoChild({
    this.khuVuc,
    this.danhSachKhuVuc,
    this.taskId,
  });
}

class DanhSachKhuVuc {
  String? loaiSuCoId;
  int? soLuong;
  String? suCo;

  DanhSachKhuVuc({
    this.suCo,
    this.soLuong,
    this.loaiSuCoId,
  });
}
