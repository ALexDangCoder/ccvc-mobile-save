import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_pakn_request.g.dart';

@JsonSerializable()
class DanhSachPAKNRequest {
  @JsonKey(name: 'PageIndex')
  final int pageIndex;
  @JsonKey(name: 'PageSize')
  final int pageSize;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'LoaiMenu')
  String? loaiMenu;
  @JsonKey(name: 'DateFrom')
  final String dateFrom;
  @JsonKey(name: 'DateTo')
  final String dateTo;
  @JsonKey(name: 'HanXuLy')
  int? hanXuLy;
  @JsonKey(name: 'donViId')
  String? donViId;

  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'TuKhoa')
  String? tuKhoa;

  DanhSachPAKNRequest(
    this.pageIndex,
    this.pageSize,
    this.dateFrom,
    this.dateTo, {
    this.trangThai,
    this.loaiMenu,
    this.hanXuLy,
    this.userId,
    this.donViId,
    this.tuKhoa,
  });

  factory DanhSachPAKNRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPAKNRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachPAKNRequestToJson(this);
}

@JsonSerializable()
class DanhSachPAKNVanBanDiRequest {
  @JsonKey(name: 'DonViId')
  final String donViId;
  @JsonKey(name: 'TrangThaiVanBanDi')
  final int trangThaiVanBanDi;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'pageSize')
  final int pageSize;
  @JsonKey(name: 'tuNgay')
  final String dateFrom;
  @JsonKey(name: 'denNgay')
  final String dateTo;

  DanhSachPAKNVanBanDiRequest(this.donViId, this.trangThaiVanBanDi, this.page,
      this.pageSize, this.dateFrom, this.dateTo);

  factory DanhSachPAKNVanBanDiRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPAKNVanBanDiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachPAKNVanBanDiRequestToJson(this);
}

@JsonSerializable()
class DanhSachPAKNXuLyCacYKienRequest {
  @JsonKey(name: 'DaChoYKien')
  final bool daChoYKien;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'pageSize')
  final int pageSize;
  @JsonKey(name: 'tuNgay')
  final String dateFrom;
  @JsonKey(name: 'denNgay')
  final String dateTo;

  DanhSachPAKNXuLyCacYKienRequest(
    this.daChoYKien,
    this.page,
    this.pageSize,
    this.dateFrom,
    this.dateTo,
  );

  factory DanhSachPAKNXuLyCacYKienRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPAKNXuLyCacYKienRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachPAKNXuLyCacYKienRequestToJson(this);
}
