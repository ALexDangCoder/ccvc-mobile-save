import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_theo_doi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nguoi_theo_doi_response.g.dart';

@JsonSerializable()
class NguoiTheoDoiLHResponse {
  @JsonKey(name: 'data')
  NguoiTheoDoiData? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  NguoiTheoDoiLHResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory NguoiTheoDoiLHResponse.fromJson(Map<String, dynamic> json,) =>
      _$NguoiTheoDoiLHResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiTheoDoiLHResponseToJson(this);
}

@JsonSerializable()
class NguoiTheoDoiData {
  @JsonKey(name: 'items')
  List<Items>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  NguoiTheoDoiData({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  NguoiTheoDoiModel toModel() =>
      NguoiTheoDoiModel(data: items?.map((e) => e.toModel()).toList() ?? [],
          pageIndex: pageIndex,
          pageSize: pageSize,
          totalCount: totalCount,
          totalPage: totalPage,);

  factory NguoiTheoDoiData.fromJson(Map<String, dynamic> json,) =>
      _$NguoiTheoDoiDataFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiTheoDoiDataToJson(this);
}

@JsonSerializable()
class Items {
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
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'userTaoHoId')
  String? userTaoHoId;

  Items({
    this.id,
    this.hoTen,
    this.donViId,
    this.userId,
    this.canBoId,
    this.tenDonVi,
    this.chucVuId,
    this.chucVu,
    this.userName,
    this.userTaoHoId,
  });

  NguoiTheoDoiItem toModel() =>
      NguoiTheoDoiItem(
        canBoId: canBoId,
        chucVu: chucVu,
        chucVuId: chucVuId,
        donViId: donViId,
        hoTen: hoTen,
        id: id,
        tenDonVi: tenDonVi,
        userId: userId,
        userName: userName,
        userTaoHoId: userTaoHoId,);

  factory Items.fromJson(Map<String, dynamic> json,) =>
      _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
