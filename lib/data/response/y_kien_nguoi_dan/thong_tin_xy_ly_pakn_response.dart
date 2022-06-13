import 'dart:convert';
import 'dart:core';

import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_xy_ly_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_tin_xy_ly_pakn_response.g.dart';

@JsonSerializable()
class ThongTinXuLyTotalResponse {
  @JsonKey(name: 'Data')
  ThongTinXuLyResponse? thongTinXuLyResponse;

  ThongTinXuLyTotalResponse(this.thongTinXuLyResponse);

  factory ThongTinXuLyTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinXuLyTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinXuLyTotalResponseToJson(this);
}

@JsonSerializable()
class ThongTinXuLyResponse {
  @JsonKey(name: 'IsDuyet')
  bool? isDuyet;
  @JsonKey(name: 'LinhVucId')
  int? linhVucId;
  @JsonKey(name: 'PhanLoaiPAKN')
  String? phanLoaiPAKN;
  @JsonKey(name: 'SoPAKN')
  String? soPAKN;
  @JsonKey(name: 'TieuDe')
  String? tieuDe;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NguonPAKNId')
  int? nguonPAKNID;
  @JsonKey(name: 'LuatId')
  int? luatId;
  @JsonKey(name: 'NoiDungPAKNId')
  int? noiDungPAKNId;
  @JsonKey(name: 'LinhVucPAKNId')
  int? linhVucPAKNId;
  @JsonKey(name: 'DoiTuongId')
  int? doiTuongId;
  @JsonKey(name: 'TenNguoiPhanAnh')
  String? tenNguoiPhanAnh;
  // @JsonKey(name: 'LuongXuLy')
  // String? luongXuLy;
  @JsonKey(name: 'DonViDuocPhanXuLy')
  String? donViDuocPhanXuLy;

  ThongTinXuLyResponse(
    this.isDuyet,
    this.linhVucId,
    this.phanLoaiPAKN,
    this.soPAKN,
    this.tieuDe,
    this.noiDung,
    this.nguonPAKNID,
    this.luatId,
    this.noiDungPAKNId,
    this.linhVucPAKNId,
    this.doiTuongId,
    this.tenNguoiPhanAnh,
    // this.luongXuLy,
    this.donViDuocPhanXuLy,
  );

  factory ThongTinXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinXuLyResponseToJson(this);

  List<DonViDuocPhanXuLyModel> convertStringIntoModel(String value) {
    final List<dynamic> json = jsonDecode(value);
    List<DonViDuocPhanXuLyModel> listDonViDuocPhanXuLy = [];
    listDonViDuocPhanXuLy = json != null
        ? json.map((e) => DonviPhanXuLyResponse.fromJson(e).toModel()).toList()
        : [];
    return listDonViDuocPhanXuLy;
  }

  ThongTinXuLyPAKNModel toModel() => ThongTinXuLyPAKNModel(
        isDuyet: isDuyet ?? false,
        linhVucId: -1,
        phanLoaiPAKN: phanLoaiPAKN ?? '',
        soPAKN: soPAKN ?? '',
        tieuDe: tieuDe ?? '',
        noiDung: noiDung ?? '',
        nguonPAKNID: nguonPAKNID ?? -1,
        luatId: luatId ?? -1,
        noiDungPAKNId: noiDungPAKNId ?? -1,
        linhVucPAKNId: linhVucPAKNId ?? -1,
        doiTuongId: doiTuongId ?? -1,
        tenNguoiPhanAnh: tenNguoiPhanAnh ?? '',
        donViDuocPhanXuLy: convertStringIntoModel(donViDuocPhanXuLy ?? ''),

        // listLuongPAKN:
        //     List<LuongXuLyPAKNModel>.from((jsonDecode(luongXuLy ?? '') as Iterable<LuongXuLyResponse>).map((e) => e.toModel()))
      );
}

const int Luu = 0;
const int ChoTiepNhan = 1;
const int ChoChuyenXuLy = 2;
const int ChoTiepNhanXuLy = 3;
const int ChoPhanCongXuLy = 4;
const int ChoDonViDuyet = 5;
const int ChoDuyet = 6;
const int ChoChuyenDonVi = 7;
const int DaHoanThanh = 8;
const int ChoBoSungThongTin = 9;
const int TuChoiTiepNhan = 10;
const int HuyBo = 11;
const int CanXuLy = 12;
const int ChoDuyetChuyenDonViXuLy = 13;
const int ChoXacNhanChuyenDonViXuLy = 14;
const int HuyTrinh = 15;
const int HuyDuyet = 16;
const int ThuHoi = 17;
const int ChoDuyetYCPH = 18;
const int ChuyenXuLy = 19;
const int DaPhanCong = 20;
const int PhanXuLy = 21;
const int ChoNguoiDanBoSungThongTin = 22;

@JsonSerializable()
class DonviPhanXuLyResponse {
  @JsonKey(name: 'TenDonVi')
  String? tenDonVi;

  @JsonKey(name: 'VaiTro')
  String? vaiTro;

  @JsonKey(name: 'TrangThai')
  int? trangThai;

  @JsonKey(name: 'TaskContent')
  String? noiDungXuLy;

  DonviPhanXuLyResponse(
      this.tenDonVi, this.vaiTro, this.trangThai, this.noiDungXuLy);

  factory DonviPhanXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DonviPhanXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonviPhanXuLyResponseToJson(this);

  String convertHoatDong(int trangThai) {
    switch (trangThai) {
      case Luu:
        return 'Lưu';
      case ChoTiepNhan:
        return 'Chờ tiếp nhận';
      case ChoChuyenXuLy:
        return 'Chờ chuyển xử lý';
      case ChoTiepNhanXuLy:
        return 'Chờ tiếp nhận xử lý';
      case ChoPhanCongXuLy:
        return 'Chờ phân công xử lý';
      case ChoDonViDuyet:
        return 'Chờ đơn vị duyệt';
      case ChoDuyet:
        return 'Chờ duyệt';
      case ChoChuyenDonVi:
        return 'Chờ chuyển đơn vị';
      case DaHoanThanh:
        return 'Đã hoàn thành';
      case ChoBoSungThongTin:
        return 'Chờ bổ sung thông tin';
      case TuChoiTiepNhan:
        return 'Từ chối tiếp nhận';
      case HuyBo:
        return 'Huỷ bỏ';
      case CanXuLy:
        return 'Cần xử lý';
      case ChoDuyetChuyenDonViXuLy:
        return 'Chờ duyệt chuyển đơn vị xử lý';
      case ChoXacNhanChuyenDonViXuLy:
        return 'Chờ xác nhận chuyển đơn vị xử lý';
      case HuyTrinh:
        return 'Huỷ trình';
      case HuyDuyet:
        return 'Huỷ duyệt';
      case ThuHoi:
        return 'Thu hồi';
      case ChoDuyetYCPH:
        return 'Chờ duyệt YCPH';
      case ChuyenXuLy:
        return 'Chuyển xử lý';
      case DaPhanCong:
        return 'Đã phân công';
      case PhanXuLy:
        return 'Phân xử lý';
      default:
        return 'Chờ người dân bổ sung thông tin';
    }
  }

  DonViDuocPhanXuLyModel toModel() => DonViDuocPhanXuLyModel(
        noiDungXuLy: (noiDungXuLy ?? '').parseHtml(),
        tenDonVi: tenDonVi ?? '',
        vaiTro: vaiTro ?? '',
        hoatDong: convertHoatDong(trangThai ?? 0),
      );
}

@JsonSerializable()
class LuongXuLyResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'KienNghiId')
  String? kienNghiId;
  @JsonKey(name: 'DonViTaoId')
  String? donViTaoId;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'TenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'Ten')
  String? ten;

  LuongXuLyResponse(this.id, this.kienNghiId, this.donViTaoId, this.nguoiTaoId,
      this.ngayTao, this.tenDonVi, this.donViId, this.ten);

  factory LuongXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$LuongXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LuongXuLyResponseToJson(this);

  LuongXuLyPAKNModel toModel() => LuongXuLyPAKNModel(
        id: id ?? '',
        kienNghiId: kienNghiId ?? '',
        donViTaoId: donViTaoId ?? '',
        nguoiTaoId: nguoiTaoId ?? '',
        ngayTao: ngayTao ?? '',
        tenDonVi: tenDonVi ?? '',
        donViId: donViId ?? '',
        ten: ten ?? '',
      );
}
