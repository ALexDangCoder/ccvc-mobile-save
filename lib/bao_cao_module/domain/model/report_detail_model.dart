class ReportDetailModel {
  String? id;
  String? createdAt;
  String? createdBy;
  String? createdByName;
  String? updatedAt;
  String? updatedBy;
  String? updatedByName;
  String? folderId;
  String? folderName;
  String? code;
  String? name;
  String? description;
  UrlsReportModel? urls;
  int? order;
  int? status;
  bool? isPin;
  bool? shareToMe;
  UserAccessReportDetail? access;
  List<UserAccessReportDetail>? listUserAccesses;

  ReportDetailModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedBy,
    this.updatedByName,
    this.folderId,
    this.folderName,
    this.code,
    this.name,
    this.description,
    this.urls,
    this.order,
    this.status,
    this.isPin,
    this.shareToMe,
    this.access,
    this.listUserAccesses,
  });
}

class UserAccessReportDetail {
  String? userId;
  String? fullname;
  bool? applyAllChildren;
  List<Permissions>? listPermission;

  UserAccessReportDetail({
    this.userId,
    this.fullname,
    this.applyAllChildren,
    this.listPermission,
  });
}

class Permissions {
  String? code;
  String? title;

  Permissions({
    this.code,
    this.title,
  });
}

class UrlsReportModel {
  String? desktop;

  UrlsReportModel({
    desktop,
  });

  UrlsReportModel.fromJson(Map<String, dynamic> json) {
    desktop = json['Desktop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Desktop'] = desktop;
    return data;
  }
}
