import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CuCanBoDiThayRequest {
  String? id;
  String? lichHopId;
  List<CanBoDiThay>? canBoDiThay;

  CuCanBoDiThayRequest({
    required this.id,
    required this.lichHopId,
    required this.canBoDiThay,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lichHopId'] = lichHopId;
    data['canBoDiThay'] = canBoDiThay;
    return data;
  }
}

class CanBoDiThay {
  String? id;
  String? donViId;
  String? canBoId;
  String? taskContent;
  bool? isXoa;

  CanBoDiThay({
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
    data['canBoId'] = canBoId;
    if(taskContent != null) {
      data['taskContent'] = taskContent;
    }
    if(isXoa != null) {
      data['isXoa'] = isXoa;
    }
    return data;
  }
}
