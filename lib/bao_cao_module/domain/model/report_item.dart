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
  bool? isDeleted;
  bool? isRoot;
  String? tree;
  bool? shareByMe;
  bool? shareToMe;
  bool hasSharedAccess;
  bool? isSourceShare;

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
    this.hasSharedAccess = false,
  });

  ReportItem({
    this.id,
    this.name,
    this.description,
    this.order,
    this.parentId,
    this.numberReport,
    this.childrenTotal,
    this.createdBy,
    this.type,
    this.typeTitle,
    this.level,
    this.isOwner,
    this.dateTime,
    this.isPin,
    this.status,
    this.shareToMe,
    this.shareByMe,
    this.hasSharedAccess = false,
    this.isSourceShare,
  });
}
