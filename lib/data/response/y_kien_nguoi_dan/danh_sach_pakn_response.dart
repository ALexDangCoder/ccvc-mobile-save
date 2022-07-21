import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_pakn_response.g.dart';

@JsonSerializable()
class DanhSachPAKNTotalResponse {
  @JsonKey(name: 'DanhSachKetQua')
  List<DanhSachKetQuaPAKNResponse>? listDanhSachKetQuaPAKN;
  @JsonKey(name: 'NoiDungThongDiep')
  String? noiDungThongDiep;
  @JsonKey(name: 'MaTraLoi')
  int? maTraLoi;
  @JsonKey(name: 'MaMenu')
  dynamic maMenu;

  DanhSachPAKNTotalResponse(this.listDanhSachKetQuaPAKN, this.noiDungThongDiep,
      this.maTraLoi, this.maMenu);

  factory DanhSachPAKNTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPAKNTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachPAKNTotalResponseToJson(this);
}

@JsonSerializable()
class DanhSachKetQuaPAKNResponse {
  @JsonKey(name: 'Id')
  String? id;
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
  @JsonKey(name: 'DoiTuongId')
  int? doiTuongId;
  @JsonKey(name: 'TaskId')
  String? taskId;
  @JsonKey(name: 'TenNguoiPhanAnh')
  String? tenNguoiPhanAnh;
  @JsonKey(name: 'CMTND')
  String? cmtnd;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'SoDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'DiaChi')
  String? diaChi;
  @JsonKey(name: 'GhiChu')
  dynamic ghiChu;
  @JsonKey(name: 'TrangThai')
  int? trangThai;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'NgayNhan')
  String? ngayNhan;
  @JsonKey(name: 'NgayPhanAnh')
  String? ngayPhanAnh;
  @JsonKey(name: 'NgayHuyBo')
  String? ngayHuyBo;
  @JsonKey(name: 'NgayTuChoi')
  String? ngayTuChoi;
  @JsonKey(name: 'DiaChiChiTiet')
  String? diaChiChiTiet;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'NgayHoanThanh')
  String? ngayHoanThanh;
  @JsonKey(name: 'LinhVucPAKN_Ten')
  String? linhVucPAKNTen;
  @JsonKey(name: 'LoaiPAKN')
  dynamic loaiPAKN;
  @JsonKey(name: 'NguonPAKN')
  String? nguonPAKN;
  @JsonKey(name: 'TenLuat')
  dynamic tenLuat;
  @JsonKey(name: 'NoiDungPAKN')
  String? noiDungPAKN;
  @JsonKey(name: 'DonViChuTri')
  dynamic donViChuTri;
  @JsonKey(name: 'DonViXuLy')
  String? donViXuLy;
  @JsonKey(name: 'DoiTuong')
  String? doiTuong;
  @JsonKey(name: 'TrangThai_Text')
  String? trangThaiText;
  @JsonKey(name: 'TrangThaiPheDuyet_Text')
  String? trangThaiPheDuyetText;
  @JsonKey(name: 'SoNgayToiHan')
  int? soNgayToiHan;
  @JsonKey(name: 'DonViGuiYeuCau')
  String? donViGuiYeuCau;
  @JsonKey(name: 'DonViPhoiHop')
  String? donViPhoiHop;
  @JsonKey(name: 'ChuyenVienChuTri')
  String? chuyenVienChuTri;
  @JsonKey(name: 'TotalPages')
  int? totalPages;
  @JsonKey(name: 'TotalItems')
  int? totalItems;

  DanhSachKetQuaPAKNResponse(
    this.id,
    this.soPAKN,
    this.tieuDe,
    this.noiDung,
    this.nguonPAKNId,
    this.luatId,
    this.noiDungPAKNId,
    this.linhVucPAKNId,
    this.doiTuongId,
    this.taskId,
    this.tenNguoiPhanAnh,
    this.cmtnd,
    this.email,
    this.soDienThoai,
    this.diaChi,
    this.ghiChu,
    this.trangThai,
    this.nguoiTaoId,
    this.ngayNhan,
    this.ngayPhanAnh,
    this.ngayHuyBo,
    this.ngayTuChoi,
    this.diaChiChiTiet,
    this.hanXuLy,
    this.ngayHoanThanh,
    this.linhVucPAKNTen,
    this.loaiPAKN,
    this.nguonPAKN,
    this.tenLuat,
    this.noiDungPAKN,
    this.donViChuTri,
    this.donViXuLy,
    this.doiTuong,
    this.trangThaiText,
    this.soNgayToiHan,
    this.donViGuiYeuCau,
    this.donViPhoiHop,
    this.chuyenVienChuTri,
    this.totalPages,
    this.totalItems,
  );

  DanhSachKetQuaPAKNModel toModel() => DanhSachKetQuaPAKNModel(
        id: id,
        soPAKN: soPAKN,
        noiDungPAKN: noiDungPAKN,
        tieuDe: tieuDe,
        noiDung: noiDung,
        nguonPAKNId: nguonPAKNId,
        luatId: luatId,
        soNgayToiHan: soNgayToiHan,
        donViGuiYeuCau: donViGuiYeuCau,
        noiDungPAKNId: noiDungPAKNId,
        linhVucPAKNId: linhVucPAKNId,
        doiTuongId: doiTuongId,
        taskId: taskId,
        tenNguoiPhanAnh: tenNguoiPhanAnh,
        cmtnd: cmtnd,
        email: email,
        trangThaiText: trangThaiPheDuyetText ?? trangThaiText,
        soDienThoai: soDienThoai,
        diaChi: diaChi,
        trangThai: trangThai,
        nguoiTaoId: nguoiTaoId,
        hanXuLy: (hanXuLy != null)
            ? DateTime.parse(hanXuLy!).toStringWithListFormat
            : '',
      );

  factory DanhSachKetQuaPAKNResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachKetQuaPAKNResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachKetQuaPAKNResponseToJson(this);
}
