import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';

class TodoGetAllResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  TodoGetAllResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  TodoGetAllResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  int? pageIndex;
  int? totalPages;
  int? totalItems;
  List<PageData>? pageData;
  bool? hasPreviousPage;
  bool? hasNextPage;

  Data({
    this.pageIndex,
    this.totalPages,
    this.totalItems,
    this.pageData,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    if (json['pageData'] != null) {
      pageData = <PageData>[];
      json['pageData'].forEach((v) {
        pageData!.add(PageData.fromJson(v));
      });
    }
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }

  List<TodoDSCVModel> toModel() =>
      pageData?.map((e) => e.toDomain()).toList() ?? [];
}

class NguoiGiaoResponse {
  String? tenCanBo;
  String? chucVu;
  String? idCanBo;

  NguoiGiaoResponse({
    this.tenCanBo,
    this.chucVu,
    this.idCanBo,
  });

  NguoiGiaoResponse.fromJson(Map<String, dynamic> json) {
    tenCanBo = json['tenCanBo'];
    chucVu = json['chucVu'];
    idCanBo = json['idCanBo'];
  }

  NguoiGiaoModel toModel() => NguoiGiaoModel(
        chucVu: chucVu,
        idCanBo: idCanBo,
        tenCanBo: tenCanBo,
      );
}

class PageData {
  String? id;
  String? label;
  String? filePath;
  bool? isTicked;
  bool? important;
  bool? inUsed;
  bool? isDeleted;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;
  String? groupId;
  String? finishDay;
  String? note;
  int? status;
  String? performer;
  NguoiGiaoResponse? nguoiGiao;

  PageData({
    this.id,
    this.label,
    this.filePath,
    this.isTicked,
    this.important,
    this.inUsed,
    this.isDeleted,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
    this.groupId,
    this.finishDay,
    this.note,
    this.status,
    this.performer,
    this.nguoiGiao,
  });

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    filePath = json['filePath'];
    isTicked = json['isTicked'];
    important = json['important'];
    inUsed = json['inUsed'];
    isDeleted = json['isDeleted'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updatedBy = json['updatedBy'];
    groupId = json['groupId'];
    finishDay = json['finishDay'];
    note = json['note'];
    status = json['status'];
    performer = json['performer'];
    nguoiGiao = json['nguoiGiao'] == null
        ? null
        : NguoiGiaoResponse.fromJson(json['nguoiGiao']);
  }

  TodoDSCVModel toDomain() => TodoDSCVModel(
        id: id,
        label: label,
        important: important ?? false,
        inUsed: inUsed,
        isDeleted: isDeleted,
        isTicked: isTicked,
        createdBy: createdBy,
        createdOn: createdOn,
        performer: performer,
        groupId: groupId,
        note: note,
        filePath: filePath,
        finishDay: finishDay,
        nguoiGiao: nguoiGiao?.toModel(),
      );
}
