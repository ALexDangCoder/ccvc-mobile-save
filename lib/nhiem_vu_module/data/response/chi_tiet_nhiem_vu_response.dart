import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataChiTietNhiemVuResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'Data')
  ChiTietNhiemVuResponse? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataChiTietNhiemVuResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  factory DataChiTietNhiemVuResponse.fromJson(Map<String, dynamic> json) =>
      _$DataChiTietNhiemVuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataChiTietNhiemVuResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ChiTietNhiemVuResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'ProcessTypeId')
  String? processTypeId;
  @JsonKey(name: 'StatusCode')
  String? statusCode;
  @JsonKey(name: 'StatusName')
  String? statusName;
  @JsonKey(name: 'StatusId')
  String? statusId;
  @JsonKey(name: 'TaskId')
  String? taskId;
  @JsonKey(name: 'ProcessTypeName')
  String? processTypeName;
  @JsonKey(name: 'ProcessTypeCode')
  String? processTypeCode;
  @JsonKey(name: 'ProcessCode')
  String? processCode;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'NguoiGiao')
  String? nguoiGiao;
  @JsonKey(name: 'HanXuLyVPCP')
  String? hanXuLyVPCP;
  @JsonKey(name: 'ProcessContent')
  String? processContent;
  @JsonKey(name: 'Metadata')
  MetadataResponse? metadata;
  @JsonKey(name: 'CoTheSua')
  bool? coTheSua;
  @JsonKey(name: 'CoTheXoa')
  bool? coTheXoa;
  @JsonKey(name: 'CoTheDonDoc')
  bool? coTheDonDoc;
  @JsonKey(name: 'CoTheThuHoi')
  bool? coTheThuHoi;
  @JsonKey(name: 'CoTheTraLai')
  bool? coTheTraLai;
  @JsonKey(name: 'CoTheCapNhatTinhHinhThucHien')
  bool? coTheCapNhatTinhHinhThucHien;
  @JsonKey(name: 'CoThePhanXuLy')
  bool? coThePhanXuLy;

  ChiTietNhiemVuResponse({
    this.id,
    this.processTypeId,
    this.statusCode,
    this.statusName,
    this.statusId,
    this.taskId,
    this.processTypeName,
    this.processTypeCode,
    this.processCode,
    this.nguoiTaoId,
    this.hanXuLy,
    this.nguoiGiao,
    this.hanXuLyVPCP,
    this.processContent,
    this.metadata,
    this.coTheSua,
    this.coTheXoa,
    this.coTheDonDoc,
    this.coTheThuHoi,
    this.coTheTraLai,
    this.coTheCapNhatTinhHinhThucHien,
    this.coThePhanXuLy,
  });

  factory ChiTietNhiemVuResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietNhiemVuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietNhiemVuResponseToJson(this);

  ChiTietNhiemVuModel toModel() => ChiTietNhiemVuModel(
        id: id,
        processTypeId: processTypeId,
        statusCode: statusCode,
        statusName: statusName,
        statusId: statusId,
        taskId: taskId,
        processTypeName: processTypeName,
        processTypeCode: processTypeCode,
        processCode: processCode,
        nguoiTaoId: nguoiTaoId,
        hanXuLy: hanXuLy,
        nguoiGiao: nguoiGiao,
        hanXuLyVPCP: hanXuLyVPCP,
        processContent: processContent,
        metadata: metadata?.toModel(),
        coTheSua: coTheSua,
        coTheXoa: coTheXoa,
        coTheDonDoc: coTheDonDoc,
        coTheThuHoi: coTheThuHoi,
        coTheTraLai: coTheTraLai,
        coTheCapNhatTinhHinhThucHien: coTheCapNhatTinhHinhThucHien,
        coThePhanXuLy: coThePhanXuLy,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class MetadataResponse extends Equatable {
  @JsonKey(name: 'DonViTaoId')
  String? donViTaoId;
  @JsonKey(name: 'DaGuiVPCP')
  String? daGuiVPCP;
  @JsonKey(name: 'DonViTheoDoi')
  String? donViTheoDoi;
  @JsonKey(name: 'NguoiGiao')
  String? nguoiGiao;
  @JsonKey(name: 'NguoiGiaoId')
  String? nguoiGiaoId;
  @JsonKey(name: 'NguoiTheoDoi')
  String? nguoiTheoDoi;

  MetadataResponse({
    this.donViTaoId,
    this.daGuiVPCP,
    this.donViTheoDoi,
    this.nguoiGiao,
    this.nguoiGiaoId,
    this.nguoiTheoDoi,
  });

  factory MetadataResponse.fromJson(Map<String, dynamic> json) =>
      _$MetadataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataResponseToJson(this);

  Metadata toModel() => Metadata(
        donViTaoId: donViTaoId,
        daGuiVPCP: daGuiVPCP,
        donViTheoDoi: donViTheoDoi,
        nguoiGiao: nguoiGiao,
        nguoiGiaoId: nguoiGiaoId,
        nguoiTheoDoi: nguoiTheoDoi,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
