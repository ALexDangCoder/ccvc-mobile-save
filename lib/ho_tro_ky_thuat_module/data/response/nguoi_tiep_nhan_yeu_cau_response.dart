import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/nguoi_tiep_nhan_yeu_cau_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nguoi_tiep_nhan_yeu_cau_response.g.dart';

@JsonSerializable()
class NguoiTiepNhanYeuCauResponse {
  @JsonKey(name: 'data')
  List<DataResponse>? data;
  @JsonKey(name: 'message')
  String? message;

  NguoiTiepNhanYeuCauResponse(
    this.data,
    this.message,
  );

  factory NguoiTiepNhanYeuCauResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NguoiTiepNhanYeuCauResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiTiepNhanYeuCauResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'hoVaTen')
  String? hoVaTen;

  DataResponse(
    this.userId,
    this.hoVaTen,
  );

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  NguoiTiepNhanYeuCauModel toModel() => NguoiTiepNhanYeuCauModel(
        userId: userId,
        hoVaTen: hoVaTen,
      );
}
