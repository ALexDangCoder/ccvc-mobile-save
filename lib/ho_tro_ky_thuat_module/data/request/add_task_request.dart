

import 'dart:io';

class AddTaskHTKTRequest {
  String? id;
  String? userRequestId;
  String? phone;
  String? description;
  String? districtId;
  String? districtName;
  String? buildingId;
  String? buildingName;
  String? room;
  String? name;
  List<String>? danhSachSuCo;
  List<String>? lstFileId;
  String? userInUnit;
  List<File>? fileUpload;

  AddTaskHTKTRequest({
    this.id,
    this.userRequestId,
    this.phone,
    this.description,
    this.districtId,
    this.districtName,
    this.buildingId,
    this.buildingName,
    this.room,
    this.name,
    this.danhSachSuCo,
    this.lstFileId,
    this.userInUnit,
    this.fileUpload,
  });

  AddTaskHTKTRequest.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userRequestId = json['UserRequestId'];
    phone = json['Phone'];
    lstFileId = json['lstFileId'];
    description = json['Description'];
    districtId = json['DistrictId'];
    districtName = json['DistrictName'];
    buildingId = json['BuildingId'];
    buildingName = json['BuildingName'];
    room = json['Room'];
    name = json['Name'];
    danhSachSuCo = json['DanhSachSuCo'].cast<String>();
    userInUnit = json['UserInUnit'];
    fileUpload = json['fileUpload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserRequestId'] = userRequestId;
    data['Phone'] = phone;
    data['Description'] = description;
    data['DistrictId'] = districtId;
    data['DistrictName'] = districtName;
    data['BuildingId'] = buildingId;
    data['lstFileId'] = lstFileId;
    data['BuildingName'] = buildingName;
    data['Room'] = room;
    data['Name'] = name;
    data['DanhSachSuCo'] = danhSachSuCo;
    data['UserInUnit'] = userInUnit;
    data['fileUpload'] = fileUpload;
    return data;
  }

  @override
  String toString() {
    return 'AddTaskHTKTRequest{id: $id, userRequestId: $userRequestId, phone: $phone, description: $description, districtId: $districtId, districtName: $districtName, buildingId: $buildingId, buildingName: $buildingName, room: $room, name: $name, danhSachSuCo: $danhSachSuCo, lstFileId: $lstFileId, userInUnit: $userInUnit, fileUpload: $fileUpload}';
  }
}
