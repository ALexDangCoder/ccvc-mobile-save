class ReportItem {
  String? id;
  String? name;
  String? description;
  int? order;
  String? parentId;
  int? numberReport;
  int? childrenTotal;
  int? type;
  String? typeTitle;
  int? level;
  bool? isOwner;
  bool? isPin;
  String? dateTime;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  int? status;
  bool? isShareToMe;

  //updatedBy: null,
  //parentId: null,
  // String? name;
  bool? isDeleted;
  bool? isRoot;

  //level: 0,
  String? tree;

  ReportItem.forderModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.name,
    this.description,
    this.order,
    this.isDeleted,
    this.isRoot,
    this.tree,
  });

  ReportItem({
    this.id,
    this.name,
    this.description,
    this.order,
    this.parentId,
    this.numberReport,
    this.childrenTotal,
    this.type,
    this.typeTitle,
    this.level,
    this.isOwner,
    this.dateTime,
    this.isPin,
    this.status,
    this.isShareToMe,
  });
}
