import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket_qua_xu_ly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ket_qua_xu_ly_response.g.dart';

@JsonSerializable()
class KetQuaXuLyResponse {
  @JsonKey(name: 'PageData')
  List<KetQuaXuLyData> listKetQuaXuLy;

  KetQuaXuLyResponse(
    this.listKetQuaXuLy,
  );

  factory KetQuaXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$KetQuaXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KetQuaXuLyResponseToJson(this);
}

@JsonSerializable()
class KetQuaXuLyData {
  @JsonKey(name: 'ID')
  String? id;
  @JsonKey(name: 'depth')
  int? depth;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'CanBoId')
  String? canBoId;
  @JsonKey(name: 'SoVanBanDi')
  String? soVanBanDi;
  @JsonKey(name: 'NgayKyVanBanDi')
  String? ngayKyVanBanDi;
  @JsonKey(name: 'CoQuanBanHanh')
  String? coQuanBanHanh;
  @JsonKey(name: 'NguoiKyDuyet')
  String? nguoiKyDuyet;
  @JsonKey(name: 'TrichYeu')
  String? trichYeu;
  @JsonKey(name: 'TenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'TenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'TaskContent')
  String? taskContent;
  @JsonKey(name: 'TrangThai')
  int? trangThai;
  @JsonKey(name: 'IsChuTri')
  bool? isChuTri;
  @JsonKey(name: 'DSFile')
  List<FileDinhKemKQXL>? dSFile;

  KetQuaXuLyData(
    this.id,
    this.depth,
    this.location,
    this.donViId,
    this.canBoId,
    this.soVanBanDi,
    this.ngayKyVanBanDi,
    this.coQuanBanHanh,
    this.nguoiKyDuyet,
    this.trichYeu,
    this.tenDonVi,
    this.tenCanBo,
    this.taskContent,
    this.trangThai,
    this.isChuTri,
    this.dSFile,
  );

  factory KetQuaXuLyData.fromJson(Map<String, dynamic> json) =>
      _$KetQuaXuLyDataFromJson(json);

  Map<String, dynamic> toJson() => _$KetQuaXuLyDataToJson(this);

  KetQuaXuLyModel toDomain() => KetQuaXuLyModel(
        iD: id ?? '',
        depth: depth ?? 0,
        location: location ?? '',
        donViId: donViId ?? '',
        canBoId: canBoId ?? '',
        soVanBanDi: soVanBanDi ?? '',
        ngayKyVanBanDi: ngayKyVanBanDi ?? '',
        coQuanBanHanh: coQuanBanHanh ?? '',
        nguoiKyDuyet: nguoiKyDuyet ?? '',
        trichYeu: trichYeu ?? '',
        tenDonVi: tenDonVi ?? '',
        tenCanBo: tenCanBo ?? '',
        dSFile: dSFile?.map((e) => e.toDomain()).toList() ?? [],
        taskContent: taskContent ?? '',
        trangThai: trangThai ?? 0,
        isChuTri: isChuTri ?? false,
      );
}

@JsonSerializable()
class FileDinhKemKQXL {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'DungLuong')
  int? dungLuong;
  @JsonKey(name: 'DaKySo')
  bool? daKySo;
  @JsonKey(name: 'DaGanQR')
  bool? daGanQR;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'SuDung')
  bool? suDung;
  @JsonKey(name: 'LoaiFileDinhKem')
  int? loaiFileDinhKem;

  FileDinhKemKQXL(
    this.id,
    this.ten,
    this.duongDan,
    this.dungLuong,
    this.daKySo,
    this.daGanQR,
    this.ngayTao,
    this.nguoiTaoId,
    this.suDung,
    this.loaiFileDinhKem,
  );

  factory FileDinhKemKQXL.fromJson(Map<String, dynamic> json) =>
      _$FileDinhKemKQXLFromJson(json);

  Map<String, dynamic> toJson() => _$FileDinhKemKQXLToJson(this);

  TaiLieuDinhKemModel toDomain() => TaiLieuDinhKemModel(
        id: id ?? '',
        ten: ten ?? '',
        duongDan: duongDan ?? '',
        dungLuong: dungLuong ?? 0,
        daKySo: daKySo ?? false,
        daGanQR: daGanQR ?? false,
        ngayTao: ngayTao ?? '',
        nguoiTaoId: nguoiTaoId ?? '',
        suDung: suDung ?? false,
        loaiFileDinhKem: loaiFileDinhKem ?? 0,
      );
}
