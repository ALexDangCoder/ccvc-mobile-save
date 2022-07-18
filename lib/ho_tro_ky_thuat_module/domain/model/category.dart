class CategoryModel {
  String? id;
  String? name;
  String? code;
  String? icon;
  String? description;
  String? parentId;
  String? categoryId;
  List<ChildCategories>? childCategories;

  CategoryModel({
    this.id,
    this.name,
    this.code,
    this.icon,
    this.description,
    this.parentId,
    this.categoryId,
    this.childCategories,
  });
}

class ChildCategories {
  String? parentId;
  String? id;
  String? name;
  String? code;
  String? icon;
  String? description;
  String? createBy;
  String? createOn;
  String? updateBy;
  String? updateOn;

  ChildCategories({
    this.parentId,
    this.id,
    this.name,
    this.code,
    this.icon,
    this.description,
    this.createBy,
    this.createOn,
    this.updateBy,
    this.updateOn,
  });
}
