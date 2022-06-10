import 'package:ccvc_mobile/utils/extensions/map_extension.dart';

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
  });

  ReportItem formJson(Map<String, dynamic> json) => ReportItem(
        id: json.getStringValue('id'),
        name: json.getStringValue('name'),
        description: json.getStringValue('description'),
        order: json.intValue('order'),
        parentId: json.getStringValue('parentId'),
        numberReport: json.intValue('numberReport'),
        childrenTotal: json.intValue('childrenTotal'),
        type: json.intValue('type'),
        typeTitle: json.getStringValue('typeTitle'),
        level: json.intValue('level'),
        isOwner: json.boolValue('isOwner'),
        dateTime: json.getStringValue('createdAt'),
      );
}
