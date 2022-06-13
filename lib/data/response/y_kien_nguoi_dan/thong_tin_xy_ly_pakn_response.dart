import 'dart:convert';

import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_xy_ly_model.dart';
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
  @JsonKey(name: 'LuongXuLy')
  String? luongXuLy;

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
    this.luongXuLy,
  );

  factory ThongTinXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinXuLyResponseToJson(this);

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
        listLuongPAKN:
            List<LuongXuLyPAKNModel>.from((jsonDecode(luongXuLy ?? '') as Iterable<LuongXuLyResponse>).map((e) => e.toModel()))

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
