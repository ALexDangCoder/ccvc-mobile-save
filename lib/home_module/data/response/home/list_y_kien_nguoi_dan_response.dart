import 'package:ccvc_mobile/home_module/domain/model/home/y_kien_nguoi_dan_model.dart';

class ListYKienNguoiDanResponse {
  List<DanhSachKetQua>? danhSachKetQua;
  String? noiDungThongDiep;
  int? maTraLoi;

  ListYKienNguoiDanResponse(
      {this.danhSachKetQua, this.noiDungThongDiep, this.maTraLoi});

  ListYKienNguoiDanResponse.fromJson(Map<String, dynamic> json) {
    if (json['DanhSachKetQua'] != null) {
      danhSachKetQua = <DanhSachKetQua>[];
      json['DanhSachKetQua'].forEach((v) {
        danhSachKetQua!.add(DanhSachKetQua.fromJson(v));
      });
    }
    noiDungThongDiep = json['NoiDungThongDiep'];
    maTraLoi = json['MaTraLoi'];
  }
}

class DanhSachKetQua {
  String? id;
  String? soPAKN;
  String? tieuDe;
  String? noiDung;
  int? nguonPAKNId;
  int? luatId;
  int? noiDungPAKNId;
  int? linhVucPAKNId;
  int? doiTuongId;
  String? taskId;
  String? tenNguoiPhanAnh;

  String? email;
  String? soDienThoai;
  String? diaChi;

  int? trangThai;
  String? nguoiTaoId;
  String? ngayNhan;
  String? ngayPhanAnh;

  String? hanXuLy;

  String? nguonPAKN;
  String? tenLuat;
  String? noiDungPAKN;

  String? doiTuong;

  int? soNgayToiHan;
  String? donViGuiYeuCau;

  int? totalPages;
  int? totalItems;

  DanhSachKetQua(
      {this.id,
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
      this.email,
      this.soDienThoai,
      this.diaChi,
      this.trangThai,
      this.nguoiTaoId,
      this.ngayNhan,
      this.ngayPhanAnh,
      this.hanXuLy,
      this.nguonPAKN,
      this.tenLuat,
      this.noiDungPAKN,
      this.doiTuong,
      this.soNgayToiHan,
      this.donViGuiYeuCau,
      this.totalPages,
      this.totalItems});

  DanhSachKetQua.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    soPAKN = json['SoPAKN'];
    tieuDe = json['TieuDe'];
    noiDung = json['NoiDung'];
    nguonPAKNId = json['NguonPAKNId'];
    luatId = json['LuatId'];
    noiDungPAKNId = json['NoiDungPAKNId'];
    linhVucPAKNId = json['LinhVucPAKNId'];
    doiTuongId = json['DoiTuongId'];
    taskId = json['TaskId'];
    tenNguoiPhanAnh = json['TenNguoiPhanAnh'];

    email = json['Email'];
    soDienThoai = json['SoDienThoai'];
    diaChi = json['DiaChi'];

    trangThai = json['TrangThai'];
    nguoiTaoId = json['NguoiTaoId'];
    ngayNhan = json['NgayNhan'];
    ngayPhanAnh = json['NgayPhanAnh'];

    hanXuLy = json['HanXuLy'];

    nguonPAKN = json['NguonPAKN'];
    tenLuat = json['TenLuat'];
    noiDungPAKN = json['NoiDungPAKN'];

    doiTuong = json['DoiTuong'];

    soNgayToiHan = json['SoNgayToiHan'];
    donViGuiYeuCau = json['DonViGuiYeuCau'];

    totalPages = json['TotalPages'];
    totalItems = json['TotalItems'];
  }

  YKienNguoiDanModel toDomain() => YKienNguoiDanModel(
      kyHieu: soPAKN ?? '',
      status: '',
      title: tieuDe?.trim() ?? '',
      hanXuLy: hanXuLy ?? '',
      code: '',
      noiGui: tenNguoiPhanAnh ?? '',
      taskId: taskId ?? '',
      id: id ?? '',
      soNgayDenHan: soNgayToiHan ?? 0);
}
