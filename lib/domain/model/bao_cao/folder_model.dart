class FolderModel {
  String? id;
  String? createdAt;
  String? createdBy;
  String? updatedAt;

  //updatedBy: null,
  //parentId: null,
  String? name;
  String? description;
  int? order;
  bool? isDeleted;
  bool? isRoot;

  //level: 0,
  String? tree;

  FolderModel({
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
}
