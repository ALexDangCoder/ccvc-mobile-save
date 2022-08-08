import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DataCuCanBoDiThayLichLamViecRequest {
  String? scheduleId;
  String? scheduleOperativeId;
  List<CuCanBoDiThayLichLamViec>? canBoDiThay;

  DataCuCanBoDiThayLichLamViecRequest({
    required this.scheduleId,
    required this.scheduleOperativeId,
    required this.canBoDiThay,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['scheduleOperativeId'] = scheduleOperativeId;
    data['canBoDiThay'] = canBoDiThay;
    return data;
  }
}

@JsonSerializable()
class CuCanBoDiThayLichLamViec {
  String? id;
  String? donViId;
  String? canBoId;
  String? taskContent;
  bool? isXoa;

  CuCanBoDiThayLichLamViec({
    required this.id,
    required this.donViId,
    required this.canBoId,
    required this.taskContent,
    this.isXoa,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['donViId'] = donViId;
    if (canBoId != null) {
      data['canBoId'] = canBoId;
    }
    if (taskContent != null) {
      data['taskContent'] = taskContent;
    }
    if (isXoa != null) {
      data['isXoa'] = isXoa;
    }
    return data;
  }
}
