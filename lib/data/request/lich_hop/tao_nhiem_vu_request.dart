import 'package:json_annotation/json_annotation.dart';

part 'tao_nhiem_vu_request.g.dart';

@JsonSerializable()
class ThemNhiemVuRequest {
  String? hanXuLy;
  String? hanXuLyVPCP;
  String? idCuocHop;
  List<MeTaDaTaRequest>? meTaDaTa;
  String? processContent;
  String? processTypeId;
  List<DanhSachVanBanRequest>? danhSachVanBan;

  ThemNhiemVuRequest({
    this.hanXuLy,
    this.hanXuLyVPCP,
    this.idCuocHop,
    this.meTaDaTa,
    this.processContent,
    this.processTypeId,
    this.danhSachVanBan,
  });

  factory ThemNhiemVuRequest.fromJson(Map<String, dynamic> json) =>
      _$ThemNhiemVuRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThemNhiemVuRequestToJson(this);
}

@JsonSerializable()
class MeTaDaTaRequest {
  String? key;
  String? value;

  MeTaDaTaRequest({
    this.key,
    this.value,
  });

  factory MeTaDaTaRequest.fromJson(Map<String, dynamic> json) =>
      _$MeTaDaTaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MeTaDaTaRequestToJson(this);
}

@JsonSerializable()
class DanhSachVanBanRequest {
  String? hinhThucVanBan;
  String? ngayVanBan;
  String? soVanBan;
  String? trichYeu;
  List<FileRequest>? file;

  DanhSachVanBanRequest({
    this.hinhThucVanBan,
    this.ngayVanBan,
    this.soVanBan,
    this.trichYeu,
    this.file,
  });

  factory DanhSachVanBanRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVanBanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachVanBanRequestToJson(this);
}

@JsonSerializable()
class FileRequest {
  String? dungLuong;
  String? duoiMoRong;
  String? duongDan;
  String? id;
  String? idFileGoc;
  int? index;
  bool? isSign;
  String? kieuDinhKem;
  String? nguoiTao;
  String? nguoiTaoId;
  String? pathIOC;
  String? processId;
  bool? qrCreated;
  String? ten;

  FileRequest({
    required this.dungLuong,
    required this.duoiMoRong,
    required this.duongDan,
    required this.id,
    required this.idFileGoc,
    required this.index,
    required this.isSign,
    required this.kieuDinhKem,
    required this.nguoiTao,
    required this.nguoiTaoId,
    required this.pathIOC,
    required this.processId,
    required this.qrCreated,
    required this.ten,
  });

  factory FileRequest.fromJson(Map<String, dynamic> json) =>
      _$FileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FileRequestToJson(this);
}
