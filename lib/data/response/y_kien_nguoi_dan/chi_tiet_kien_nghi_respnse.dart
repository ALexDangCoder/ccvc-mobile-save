import 'dart:convert';

import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_kien_nghi_respnse.g.dart';

@JsonSerializable()
class ChiTietKienNghiResponse {
  @JsonKey(name: 'Data')
  ChiTietYKienNguoiDanData chiTietYKienNguoiDanData;

  ChiTietKienNghiResponse(
    this.chiTietYKienNguoiDanData,
  );

  factory ChiTietKienNghiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietKienNghiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietKienNghiResponseToJson(this);

  ChiTietYKNDDataModel toDomain() => ChiTietYKNDDataModel(
        chiTietYKNDModel: chiTietYKienNguoiDanData.toDomain(),
      );
}

@JsonSerializable()
class ChiTietYKienNguoiDanData {
  @JsonKey(name: 'FileDinhKem')
  String? fileDinhKem;
  @JsonKey(name: 'TaskFileDinhKem')
  String? taskFileDinhKem;
  @JsonKey(name: 'LuongXuLy')
  String? luongXuLy;
  @JsonKey(name: 'YKienChiDao')
  String? yKienChiDao;
  @JsonKey(name: 'Task')
  String? task;
  @JsonKey(name: 'DonViDuocPhanXuLy')
  String? donViDuocPhanXuLy;
  @JsonKey(name: 'IsDuyet')
  bool? isDuyet;
  @JsonKey(name: 'IsDraft')
  bool? isDraft;
  @JsonKey(name: 'LinhVucId')
  int? linhVucId;
  @JsonKey(name: 'TenLuat')
  String? tenLuat;
  @JsonKey(name: 'PhanLoaiPAKN')
  String? phanLoaiPAKN;
  @JsonKey(name: 'SoPAKN')
  String? soPAKN;
  @JsonKey(name: 'TieuDe')
  String? tieuDe;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NguonPAKNId')
  int? nguonPAKNId;
  @JsonKey(name: 'LuatId')
  int? luatId;
  @JsonKey(name: 'NoiDungPAKNId')
  int? noiDungPAKNId;
  @JsonKey(name: 'LinhVucPAKNId')
  int? linhVucPAKNId;
  @JsonKey(name: 'DSTaiLieuDinhKem')
  String? dSTaiLieuDinhKem;
  @JsonKey(name: 'DoiTuongId')
  int? doiTuongId;
  @JsonKey(name: 'TenNguoiPhanAnh')
  String? tenNguoiPhanAnh;
  @JsonKey(name: 'CMTND')
  String? cMTND;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'SoDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'DiaChi')
  String? diaChi;
  @JsonKey(name: 'TinhId')
  int? tinhId;
  @JsonKey(name: 'HuyenId')
  int? huyenId;
  @JsonKey(name: 'XaId')
  int? xaId;
  @JsonKey(name: 'DonViXuLyId')
  String? donViXuLyId;
  @JsonKey(name: 'TrangThai')
  int? trangThai;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'NgayNhan')
  String? ngayNhan;
  @JsonKey(name: 'NgayPhanAnh')
  String? ngayPhanAnh;
  @JsonKey(name: 'TenNguonPAKN')
  String? tenNguonPAKN;
  @JsonKey(name: 'NoiTao')
  int? noiTao;
  @JsonKey(name: 'DiaChiChiTiet')
  String? diaChiChiTiet;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'NguoiXuLyId')
  String? nguoiXuLyId;
  @JsonKey(name: 'LaPAKNChuyenLaiChoTiepNhan')
  bool? laPAKNChuyenLaiChoTiepNhan;
  @JsonKey(name: 'LaPAKNChuyenLaiChoChuyenXuLy')
  bool? laPAKNChuyenLaiChoChuyenXuLy;
  @JsonKey(name: 'LaPAKNChuyenLaiChoTiepNhanXuLy')
  bool? laPAKNChuyenLaiChoTiepNhanXuLy;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'ThoiGianTaoMoi')
  String? thoiGianTaoMoi;
  @JsonKey(name: 'ThoiGianCapNhat')
  String? thoiGianCapNhat;

  ChiTietYKienNguoiDanData(
    this.fileDinhKem,
    this.taskFileDinhKem,
    this.luongXuLy,
    this.yKienChiDao,
    this.task,
    this.donViDuocPhanXuLy,
    this.isDuyet,
    this.isDraft,
    this.linhVucId,
    this.tenLuat,
    this.phanLoaiPAKN,
    this.soPAKN,
    this.tieuDe,
    this.noiDung,
    this.nguonPAKNId,
    this.luatId,
    this.noiDungPAKNId,
    this.linhVucPAKNId,
    this.dSTaiLieuDinhKem,
    this.doiTuongId,
    this.tenNguoiPhanAnh,
    this.cMTND,
    this.email,
    this.soDienThoai,
    this.diaChi,
    this.tinhId,
    this.huyenId,
    this.xaId,
    this.donViXuLyId,
    this.trangThai,
    this.nguoiTaoId,
    this.ngayNhan,
    this.ngayPhanAnh,
    this.noiTao,
    this.diaChiChiTiet,
    this.hanXuLy,
    this.nguoiXuLyId,
    this.laPAKNChuyenLaiChoTiepNhan,
    this.laPAKNChuyenLaiChoChuyenXuLy,
    this.laPAKNChuyenLaiChoTiepNhanXuLy,
    this.id,
    this.thoiGianTaoMoi,
    this.thoiGianCapNhat,
    this.tenNguonPAKN,
  );

  factory ChiTietYKienNguoiDanData.fromJson(Map<String, dynamic> json) =>
      _$ChiTietYKienNguoiDanDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietYKienNguoiDanDataToJson(this);

  ChiTietYKNDModel toDomain() {
    final List<FileData> listFile = [];
    if (fileDinhKem != null) {
      final listData = jsonDecode(fileDinhKem ?? '') as List<dynamic>;
      for (final element in listData) {
        listFile.add(FileDataResopne.fromJson(element).toDomain());
      }
    }
    return ChiTietYKNDModel(
      listFile,
      taskFileDinhKem ?? '',
      luongXuLy ?? '',
      yKienChiDao ?? '',
      task ?? '',
      donViDuocPhanXuLy ?? '',
      isDuyet ?? false,
      isDraft ?? false,
      linhVucId ?? 0,
      tenLuat ?? '',
      phanLoaiPAKN ?? '',
      soPAKN ?? '',
      tieuDe ?? '',
      noiDung ?? '',
      nguonPAKNId ?? 0,
      luatId ?? 0,
      noiDungPAKNId ?? 0,
      linhVucPAKNId ?? 0,
      dSTaiLieuDinhKem ?? '',
      doiTuongId ?? 0,
      tenNguoiPhanAnh ?? '',
      cMTND ?? '',
      email ?? '',
      soDienThoai ?? '',
      diaChi ?? '',
      tinhId ?? 0,
      huyenId ?? 0,
      xaId ?? 0,
      donViXuLyId ?? '',
      trangThai ?? 0,
      nguoiTaoId ?? '',
      ngayNhan ?? '',
      DateTime.parse(ngayPhanAnh ?? '').toStringWithListFormat,
      noiTao ?? 0,
      diaChiChiTiet ?? '',
      DateTime.parse(hanXuLy ?? '').toStringWithListFormat,
      nguoiXuLyId ?? '',
      laPAKNChuyenLaiChoTiepNhan ?? false,
      laPAKNChuyenLaiChoChuyenXuLy ?? false,
      laPAKNChuyenLaiChoTiepNhanXuLy ?? false,
      id ?? '',
      thoiGianTaoMoi ?? '',
      thoiGianCapNhat ?? '',
      tenNguonPAKN ?? '',
    );
  }
}

@JsonSerializable()
class FileDataResopne {
  @JsonKey(name: 'DungLuong')
  int? dungLuong;
  @JsonKey(name: 'DuoiMoRong')
  String? duoiMoRong;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'KieuDinhKem')
  String? kieuDinhKem;
  @JsonKey(name: 'Ten')
  String? tenFile;

  FileDataResopne(
    this.dungLuong,
    this.duoiMoRong,
    this.duongDan,
    this.kieuDinhKem,
    this.tenFile,
  );

  factory FileDataResopne.fromJson(Map<String, dynamic> json) =>
      _$FileDataResopneFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataResopneToJson(this);

  FileData toDomain() => FileData(
        dungLuong: dungLuong ?? 0,
        duoiMoRong: duoiMoRong ?? '',
        duongDan: duongDan ?? '',
        kieuDinhKem: kieuDinhKem ?? '',
        tenFile: tenFile ?? '',
      );
}
