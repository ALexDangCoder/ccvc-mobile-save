

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
    this.userInUnit,
    this.fileUpload,
  });

  AddTaskHTKTRequest.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userRequestId = json['UserRequestId'];
    phone = json['Phone'];
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
    return 'AddTaskHTKTRequest{Id: $id, UserRequestId: $userRequestId, Phone: $phone, Description: $description, DistrictId: $districtId, DistrictName: $districtName, BuildingId: $buildingId, BuildingName: $buildingName, Room: $room, Name: $name, DanhSachSuCo: $danhSachSuCo, UserInUnit: $userInUnit,fileUpload: $fileUpload}';
  }
}
