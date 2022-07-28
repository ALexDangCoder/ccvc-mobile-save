import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'officer_join_response.g.dart';

@JsonSerializable()
class OfficerJoinResponse {
  @JsonKey(name: 'data')
  List<DataResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  OfficerJoinResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory OfficerJoinResponse.fromJson(Map<String, dynamic> json) =>
      _$OfficerJoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfficerJoinResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'key')
  String ? key;
  @JsonKey(name: 'data')
  ItemOfficerResponse? data;
  @JsonKey(name: 'children')
  List<DataResponse>? children;

  DataResponse({
    this.data,
    this.key,
    this.children,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);


  Node<Officer> toNode() {
    final node = Node(
        data?.toModel() ?? Officer(),
    );
    children?.forEach((element) {
      node.addChild(element.toNode());
    });
    node.value.isThamGia=node.children.isEmpty;
    return node;
  }
}

@JsonSerializable()
class ItemOfficerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'isConfirm')
  bool? isConfirm;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'confirmDate')
  String? confirmDate;
  @JsonKey(name: 'taskContent')
  String? taskContent;
  @JsonKey(name: 'scheduleId')
  String? scheduleId;
  @JsonKey(name: 'status')
  int? status;

  factory ItemOfficerResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemOfficerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOfficerResponseToJson(this);

  ItemOfficerResponse({
    this.id,
    this.hoTen,
    this.donViId,
    this.userId,
    this.canBoId,
    this.tenDonVi,
    this.userName,
    this.isConfirm,
    this.parentId,
    this.confirmDate,
    this.taskContent,
    this.status,
    this.scheduleId,
  });

  Officer toModel() =>
      Officer(
        id: id,
        hoTen: hoTen,
        donViId: donViId,
        userId: userId,
        canBoId: canBoId,
        tenDonVi: tenDonVi,
        taskContent: taskContent,
        confirmDate: confirmDate,
        isConfirm: isConfirm,
        parentId: parentId,
        status: status,
        scheduleId: scheduleId,
      );

  Node<Officer> toNode() => Node(toModel());
}
