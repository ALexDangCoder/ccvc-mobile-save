class DataDanhSachTitleHDSD {
  int? pageIndex;
  int? totalPages;
  int? totalItems;
  List<DanhSachTitleHDSD>? pageData;
  bool? hasPreviousPage;
  bool? hasNextPage;

  DataDanhSachTitleHDSD({
    this.pageIndex,
    this.totalPages,
    this.totalItems,
    this.pageData,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  DataDanhSachTitleHDSD.empty();
}

class DanhSachTitleHDSD {
  String? id;
  String? title;
  String? topic;
  String? topicStr;
  String? type;
  String? createdOn;
  String? createdBy;
  bool? inUsed;
  bool? isDeleted;
  String? updatedOn;
  String? updatedBy;
  int? order;

  DanhSachTitleHDSD({
    this.id,
    this.title,
    this.topic,
    this.topicStr,
    this.type,
    this.createdOn,
    this.createdBy,
    this.inUsed,
    this.isDeleted,
    this.updatedOn,
    this.updatedBy,
    this.order,
  });

  DanhSachTitleHDSD.empty();
}
