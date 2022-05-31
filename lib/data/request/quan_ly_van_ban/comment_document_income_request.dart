
import 'package:json_annotation/json_annotation.dart';


part 'comment_document_income_request.g.dart';

@JsonSerializable()
class UpdateCommentRequest {
  @JsonKey(name: 'TaskId')
  final String taskId;
  @JsonKey(name: 'VanBanDenId')
  final String vanBanDenId;
  @JsonKey(name: 'DanhSachYKien')
  final List<DanhSachYKienRequest> danhSachYKien;

  UpdateCommentRequest({
    required this.danhSachYKien,
    required this.vanBanDenId,
    required this.taskId,
  });

  factory UpdateCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCommentRequestToJson(this);
}


@JsonSerializable()
class DanhSachYKienRequest {
  @JsonKey(name: 'HashValue')
  final String hashValue;
  @JsonKey(name: 'NoiDung')
  final String noiDung;
  @JsonKey(name: 'YKienXuLyFileDinhKem')
  final List<YKienXuLyFileDinhKemRequest> files;


  DanhSachYKienRequest({
    required this.hashValue,
    required this.noiDung,
    required this.files,
  });

  factory DanhSachYKienRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachYKienRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachYKienRequestToJson(this);
}

@JsonSerializable()
class YKienXuLyFileDinhKemRequest {
  @JsonKey(name: 'FileDinhKemId')
  final String idFile;
  @JsonKey(name: 'dataKySo')
  final String dataKySo;
  @JsonKey(name: 'keyKySo')
  final String keyKySo;

  YKienXuLyFileDinhKemRequest({
    required this.idFile,
    required this.dataKySo,
    required this.keyKySo,
  });

  factory YKienXuLyFileDinhKemRequest.fromJson(Map<String, dynamic> json) =>
      _$YKienXuLyFileDinhKemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$YKienXuLyFileDinhKemRequestToJson(this);
}


@JsonSerializable()
class RelayCommentRequest {
  @JsonKey(name: 'HashValue')
  final String hashValue;
  @JsonKey(name: 'IdYKienTraLoi')
  final String? idYKienTraLoi;
  @JsonKey(name: 'NoiDung')
  final String noiDung;
  @JsonKey(name: 'TaskId')
  final String taskId;
  @JsonKey(name: 'TaskXinYKienId')
  final String documentId;
  @JsonKey(name: 'YKienXuLyFileDinhKem')
  final List<YKienXuLyFileDinhKemRequest> files;


  RelayCommentRequest({
    required this.hashValue,
    required this.noiDung,
    required this.files,
    required this.taskId,
    required this.documentId,
    this.idYKienTraLoi,
  });

  factory RelayCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$RelayCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RelayCommentRequestToJson(this);
}

