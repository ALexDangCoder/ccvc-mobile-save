import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DataCuCanBoLichLamViecRequest {
  String? scheduleId;
  List<CuCanBoLichLamViec>? canBoDiThay;

  DataCuCanBoLichLamViecRequest({
    required this.scheduleId,
    required this.canBoDiThay,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['canBoDiThay'] = canBoDiThay;
    return data;
  }
}

@JsonSerializable()
class CuCanBoLichLamViec {
  //truong khoi tao model
  String? canBoId;
  String? confirmDate;
  String? donViId;
  String? hoTen;
  String? id;
  bool? isConfirm;
  String? parentId;
  String? scheduleId;
  int? status;
  String? taskContent;
  String? tenDonVi;
  String? userId;
  String? userName;
  bool? isXoa;
  bool? isCheckThemCanCuCanBo;

  CuCanBoLichLamViec({
    this.canBoId,
    this.confirmDate,
    this.donViId,
    this.hoTen,
    this.id,
    this.isConfirm,
    this.parentId,
    this.scheduleId,
    this.status,
    this.taskContent,
    this.tenDonVi,
    this.userId,
    this.userName,
    this.isXoa,
    this.isCheckThemCanCuCanBo,
  }); //truong day len user tham gia,canBoId,donViId,hoTen,isXoa,taskContent,tenDonVi

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['canBoId'] = canBoId;
    if (isCheckThemCanCuCanBo ?? false) {
      data['confirmDate'] = confirmDate;
      data['id'] = id;
      data['isConfirm'] = isConfirm;
      data['parentId'] = parentId;
      data['scheduleId'] = scheduleId;
      data['status'] = status;
      data['userId'] = userId;
      data['userName'] = userName;
    }
    data['donViId'] = donViId;
    data['hoTen'] = hoTen;
    data['taskContent'] = taskContent;
    data['tenDonVi'] = tenDonVi;
    data['isXoa'] = isXoa;
    return data;
  }
}
