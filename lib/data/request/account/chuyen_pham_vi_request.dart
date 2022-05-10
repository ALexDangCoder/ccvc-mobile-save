class ChuyenPhamViRequest {
  String? userCanBoDepartmentId;
  String? appCode;

  ChuyenPhamViRequest({this.userCanBoDepartmentId, this.appCode});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userCanBoDepartmentId'] = userCanBoDepartmentId;
    data['appCode'] = appCode;
    return data;
  }
}