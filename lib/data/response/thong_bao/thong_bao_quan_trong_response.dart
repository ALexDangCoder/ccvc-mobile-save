import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_bao_quan_trong_response.g.dart';

@JsonSerializable()
class ThongBaoQuanTrongResponse {
  @JsonKey(name: 'data')
  ThongBaoQuanTrongData data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ThongBaoQuanTrongResponse(
      this.data, this.statusCode, this.succeeded, this.code, this.message);

  factory ThongBaoQuanTrongResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongBaoQuanTrongResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongBaoQuanTrongResponseToJson(this);
}

@JsonSerializable()
class ThongBaoQuanTrongData {
  @JsonKey(name: 'items')
  List<ItemsData> items;
  @JsonKey(name: 'paging')
  PagingData paging;

  ThongBaoQuanTrongData(this.items, this.paging);

  ThongBaoQuanTrongModel toModel() => ThongBaoQuanTrongModel(
        items: items.map((e) => e.toModel()).toList(),
        paging: paging.toModel(),
      );

  factory ThongBaoQuanTrongData.fromJson(Map<String, dynamic> json) =>
      _$ThongBaoQuanTrongDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThongBaoQuanTrongDataToJson(this);
}

@JsonSerializable()
class ItemsData {
  @JsonKey(name: 'active')
  bool? active;
  @JsonKey(name: 'confirmAction')
  String? confirmAction;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'needConfirmation')
  bool? needConfirmation;
  @JsonKey(name: 'pin')
  bool? pin;
  @JsonKey(name: 'receiceId')
  String? receiceId;
  @JsonKey(name: 'redirectUrl')
  String? redirectUrl;
  @JsonKey(name: 'rejectReason')
  String? rejectReason;
  @JsonKey(name: 'seen')
  bool? seen;
  @JsonKey(name: 'seenDate')
  String? seenDate;
  @JsonKey(name: 'sentId')
  String? sentId;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'subSystem')
  String? subSystem;
  @JsonKey(name: 'timeSent')
  String? timeSent;
  @JsonKey(name: 'title')
  String? title;

  ItemsData(
    this.active,
    this.confirmAction,
    this.createAt,
    this.icon,
    this.id,
    this.message,
    this.needConfirmation,
    this.pin,
    this.receiceId,
    this.redirectUrl,
    this.rejectReason,
    this.seen,
    this.seenDate,
    this.sentId,
    this.status,
    this.subSystem,
    this.timeSent,
    this.title,
  );

  Item toModel() => Item(
      active: active,
      confirmAction: confirmAction,
      createAt: createAt,
      icon: icon,
      id: id,
      message: message,
      needConfirmation: needConfirmation,
      pin: pin,
      receiceId: receiceId,
      redirectUrl: redirectUrl,
      rejectReason: rejectReason,
      seen: seen,
      seenDate: seenDate,
      sentId: sentId,
      status: status,
      subSystem: subSystem,
      timeSent: timeSent,
      title: title);

  factory ItemsData.fromJson(Map<String, dynamic> json) =>
      _$ItemsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsDataToJson(this);
}

@JsonSerializable()
class PagingData {
  @JsonKey(name: 'currentPage')
  int? currentPage;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'pagesCount')
  int? pagesCount;
  @JsonKey(name: 'rowsCount')
  int? rowsCount;
  @JsonKey(name: 'startRowIndex')
  int? startRowIndex;

  PagingData(this.currentPage, this.pageSize, this.pagesCount, this.rowsCount,
      this.startRowIndex);

  Paging toModel() => Paging(
        currentPage: currentPage,
        pageSize: pageSize,
        pagesCount: pagesCount,
        rowsCount: rowsCount,
        startRowIndex: startRowIndex,
      );

  factory PagingData.fromJson(Map<String, dynamic> json) =>
      _$PagingDataFromJson(json);

  Map<String, dynamic> toJson() => _$PagingDataToJson(this);
}
