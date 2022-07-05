import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'data')
  List<DataResponse>? data;
  @JsonKey(name: 'message')
  String? message;

  CategoryResponse(
    this.data,
    this.message,
  );

  factory CategoryResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'categoryId')
  String? categoryId;
  @JsonKey(name: 'childCategories')
  List<ChildCategoriesResponse>? childCategories;

  DataResponse(
    this.id,
    this.name,
    this.code,
    this.icon,
    this.description,
    this.parentId,
    this.categoryId,
    this.childCategories,
  );

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  CategoryModel toModel() => CategoryModel(
        id: id,
        name: name,
        icon: icon,
        code: code,
        description: description,
        parentId: parentId,
        categoryId: categoryId,
        childCategories:
            childCategories?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class ChildCategoriesResponse {
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'createBy')
  String? createBy;
  @JsonKey(name: 'createOn')
  String? createOn;
  @JsonKey(name: 'updateBy')
  String? updateBy;
  @JsonKey(name: 'updateOn')
  String? updateOn;

  ChildCategoriesResponse(
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
  );

  factory ChildCategoriesResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChildCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChildCategoriesResponseToJson(this);

  ChildCategories toModel() => ChildCategories(
        id: id,
        parentId: id,
        name: name,
        code: code,
        icon: icon,
        description: description,
        createBy: createBy,
        createOn: createOn,
        updateBy: updateBy,
        updateOn: updateOn,
      );
}
