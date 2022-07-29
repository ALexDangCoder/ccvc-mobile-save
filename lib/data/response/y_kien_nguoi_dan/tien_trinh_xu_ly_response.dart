import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/tien_trinh_xu_ly_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tien_trinh_xu_ly_response.g.dart';

@JsonSerializable()
class TienTrinhXuLyResponse {
  @JsonKey(name: 'DanhSachKetQua')
  List<TienTrinhXuLyData> tienTrinhXuLyData;

  TienTrinhXuLyResponse(
    this.tienTrinhXuLyData,
  );

  factory TienTrinhXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$TienTrinhXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TienTrinhXuLyResponseToJson(this);
}

@JsonSerializable()
class TienTrinhXuLyData {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'PaknId')
  String? paknId;
  @JsonKey(name: 'NoiDungXuLy')
  String? noiDungXuLy;
  @JsonKey(name: 'TrangThaiXuLy')
  String? trangThaiXuLy;
  @JsonKey(name: 'TrangThaiBatDauId')
  int? trangThaiBatDauId;
  @JsonKey(name: 'TrangThaiChuyenDenId')
  int? trangThaiChuyenDenId;
  @JsonKey(name: 'NgayBatDau')
  String? ngayBatDau;
  @JsonKey(name: 'NgayKetThuc')
  String? ngayKetThuc;
  @JsonKey(name: 'TaiKhoanThaoTac')
  String? taiKhoanThaoTac;
  @JsonKey(name: 'DonViThaoTac')
  String? donViThaoTac;
  @JsonKey(name: 'NguoiThaoTac')
  String? nguoiThaoTac;
  @JsonKey(name: 'TaiLieus')
  List<TaiLieuData>? taiLieus;

  TienTrinhXuLyData(
    this.id,
    this.paknId,
    this.noiDungXuLy,
    this.trangThaiXuLy,
    this.trangThaiBatDauId,
    this.trangThaiChuyenDenId,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.taiKhoanThaoTac,
    this.donViThaoTac,
    this.nguoiThaoTac,
    this.taiLieus,
  );

  factory TienTrinhXuLyData.fromJson(Map<String, dynamic> json) =>
      _$TienTrinhXuLyDataFromJson(json);

  Map<String, dynamic> toJson() => _$TienTrinhXuLyDataToJson(this);

  TienTrinhXuLyModel toDomain() => TienTrinhXuLyModel(
        id: id ?? '',
        paknId: paknId ?? '',
        noiDungXuLy: noiDungXuLy ?? '',
        trangThaiXuLy: trangThaiXuLy ?? '',
        trangThaiBatDauId: trangThaiBatDauId ?? 0,
        trangThaiChuyenDenId: trangThaiChuyenDenId ?? 0,
        ngayBatDau: ngayBatDau ?? '',
        ngayKetThuc: ngayKetThuc ?? '',
        taiKhoanThaoTac: taiKhoanThaoTac ?? '',
        donViThaoTac: donViThaoTac ?? '',
        taiLieus: taiLieus?.map((e) => e.toDomain()).toList() ?? [],
        nguoiThaoTac: nguoiThaoTac ?? '',
      );
}

@JsonSerializable()
class TaiLieuData {
  @JsonKey(name: 'KienNghiId')
  String? kienNghiId;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'Kieu')
  int? kieu;
  @JsonKey(name: 'Thutu')
  int? thutu;
  @JsonKey(name: 'KichThuoc')
  int? kichThuoc;
  @JsonKey(name: 'NoiDungKichThuoc')
  String? noiDungKichThuoc;
  @JsonKey(name: 'Ext')
  String? ext;
  @JsonKey(name: 'KieuDinhKem')
  String? kieuDinhKem;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'ThoiGianTaoMoi')
  String? thoiGianTaoMoi;
  @JsonKey(name: 'ThoiGianCapNhat')
  String? thoiGianCapNhat;

  TaiLieuData(
    this.kienNghiId,
    this.ten,
    this.duongDan,
    this.kieu,
    this.thutu,
    this.kichThuoc,
    this.noiDungKichThuoc,
    this.ext,
    this.kieuDinhKem,
    this.id,
    this.thoiGianTaoMoi,
    this.thoiGianCapNhat,
  );

  factory TaiLieuData.fromJson(Map<String, dynamic> json) =>
      _$TaiLieuDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaiLieuDataToJson(this);

  TaiLieuTienTrinhXuLyModel toDomain() => TaiLieuTienTrinhXuLyModel(
        kienNghiId: kienNghiId ?? '',
        ten: ten ?? '',
        duongDan: duongDan ?? '',
        kieu: kieu ?? 0,
        thutu: thutu ?? 0,
        kichThuoc: kichThuoc ?? 0,
        noiDungKichThuoc: noiDungKichThuoc ?? '',
        ext: ext ?? '',
        kieuDinhKem: kieuDinhKem ?? '',
        id: id ?? '',
        thoiGianCapNhat: thoiGianCapNhat ?? '',
        thoiGianTaoMoi: thoiGianTaoMoi ?? '',
      );
}
