class LoaiBaiVietModel {
  List<LoaiBaiVietModel>? childrens;
  String? id;
  String? title;
  String? code;
  String? alias;
  String? description;
  String? thumbnailUrl;
  String? parentId;
  String? pathItem;
  bool? isDuocMoi;
  String? type;
  int? order;
  bool? isShowExpanded;

  LoaiBaiVietModel({
     this.childrens,
     this.id,
     this.title,
     this.code,
     this.alias,
     this.description,
     this.thumbnailUrl,
     this.parentId,
     this.pathItem,
     this.isDuocMoi,
     this.type,
     this.order,
  });
}
