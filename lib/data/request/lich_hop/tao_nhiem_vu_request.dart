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
    required this.key,
    required this.value,
  });

  factory MeTaDaTaRequest.fromJson(Map<String, dynamic> json) =>
      _$MeTaDaTaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MeTaDaTaRequestToJson(this);
}

@JsonSerializable()
class DanhSachVanBanRequest {
  String? HinhThucVanBan;
  String? NgayVanBan;
  String? SoVanBan;
  String? TrichYeu;
  List<FileRequest>? file;

  DanhSachVanBanRequest({
    required this.HinhThucVanBan,
    required this.NgayVanBan,
    required this.SoVanBan,
    required this.TrichYeu,
    required this.file,
  });

  factory DanhSachVanBanRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVanBanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachVanBanRequestToJson(this);
}

@JsonSerializable()
class FileRequest {
  String? DungLuong;
  String? DuoiMoRong;
  String? DuongDan;
  String? Id;
  String? IdFileGoc;
  int? Index;
  bool? IsSign;
  String? KieuDinhKem;
  String? NguoiTao;
  String? NguoiTaoId;
  String? PathIOC;
  String? ProcessId;
  bool? QrCreated;
  String? Ten;

  FileRequest({
    required this.DungLuong,
    required this.DuoiMoRong,
    required this.DuongDan,
    required this.Id,
    required this.IdFileGoc,
    required this.Index,
    required this.IsSign,
    required this.KieuDinhKem,
    required this.NguoiTao,
    required this.NguoiTaoId,
    required this.PathIOC,
    required this.ProcessId,
    required this.QrCreated,
    required this.Ten,
  });

  factory FileRequest.fromJson(Map<String, dynamic> json) =>
      _$FileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FileRequestToJson(this);
}
