class ThongBaoQuanTrongModel {
  List<Item>? items;
  Paging? paging;

  ThongBaoQuanTrongModel({required this.items, required this.paging});

  ThongBaoQuanTrongModel.empty();
}

class Item {
  bool? active;
  String? confirmAction;
  String? createAt;
  String? icon;
  String? id;
  String? message;
  bool? needConfirmation;
  bool? pin;
  String? receiceId;
  String? redirectUrl;
  String? rejectReason;
  bool? seen;
  String? seenDate;
  String? sentId;
  int? status;
  String? subSystem;
  String? timeSent;
  String? title;

  Item({
    required this.active,
    required this.confirmAction,
    required this.createAt,
    required this.icon,
    required this.id,
    required this.message,
    required this.needConfirmation,
    required this.pin,
    required this.receiceId,
    required this.redirectUrl,
    required this.rejectReason,
    required this.seen,
    required this.seenDate,
    required this.sentId,
    required this.status,
    required this.subSystem,
    required this.timeSent,
    required this.title,
  });
}

class Paging {
  int? currentPage;
  int? pageSize;
  int? pagesCount;
  int? rowsCount;
  int? startRowIndex;

  Paging({
    required this.currentPage,
    required this.pageSize,
    required this.pagesCount,
    required this.rowsCount,
    required this.startRowIndex,
  });
}
