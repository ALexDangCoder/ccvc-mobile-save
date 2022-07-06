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
  List<String>? fileUpload;

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
    id = json['id'];
    userRequestId = json['userRequestId'];
    phone = json['phone'];
    description = json['description'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    buildingId = json['buildingId'];
    buildingName = json['buildingName'];
    room = json['room'];
    name = json['name'];
    danhSachSuCo = json['danhSachSuCo'].cast<String>();
    userInUnit = json['userInUnit'];
    fileUpload = json['fileUpload'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userRequestId'] = userRequestId;
    data['phone'] = phone;
    data['description'] = description;
    data['districtId'] = districtId;
    data['districtName'] = districtName;
    data['buildingId'] = buildingId;
    data['buildingName'] = buildingName;
    data['room'] = room;
    data['name'] = name;
    data['danhSachSuCo'] = danhSachSuCo;
    data['userInUnit'] = userInUnit;
    data['fileUpload'] = fileUpload;
    return data;
  }
}
