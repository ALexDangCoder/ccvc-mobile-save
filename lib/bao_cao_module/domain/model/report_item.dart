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
  bool? isDeleted;
  bool? isRoot;
  String? tree;
  bool? shareByMe;
  bool? shareToMe;

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
    this.shareToMe,
    this.shareByMe,
  });
}
