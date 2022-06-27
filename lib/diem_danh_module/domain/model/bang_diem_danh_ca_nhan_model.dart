class ListItemBangDiemDanhCaNhanModel {
  List<BangDiemDanhCaNhanModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  ListItemBangDiemDanhCaNhanModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class BangDiemDanhCaNhanModel {
  String? date;// ngày
  String? timeIn;//giờ vào
  String? timeOut;//giờ ra
  String? type;//??
  double? dayWage;//số ngày lương
  double? leave;//??
  int? isLeaveRequest;//??
  String? leaveRequestReasonCode;//??
  String? leaveRequestReasonTakeLeaveCode;//??
  String? leaveRequestReasonName;//??
  bool? isLate; //hiển thị muộn
  bool? isComeBackEarly;//??
  String? leaveType;//??

  BangDiemDanhCaNhanModel({
    this.date,
    this.timeIn,
    this.timeOut,
    this.type,
    this.dayWage,
    this.leave,
    this.isLeaveRequest,
    this.leaveRequestReasonCode,
    this.leaveRequestReasonTakeLeaveCode,
    this.leaveRequestReasonName,
    this.isLate,
    this.isComeBackEarly,
    this.leaveType,
  });
}
