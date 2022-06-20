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
  });
}
