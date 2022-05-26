import 'package:ccvc_mobile/domain/model/document/luong_xu_ly_vb_di.dart';

class LuongXuLyVBDiResponse {
  List<Data>? data;
  int? statusCode;
  bool? isSuccess;

  LuongXuLyVBDiResponse({this.data, this.statusCode, this.isSuccess});

  LuongXuLyVBDiResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
  }
}

class Data {
  InfoCanBo? infoCanBo;
  int? trangThaiHienTai;
  int? loaiXuLy;
  String? idCha;
  String? idTrinhKy;
  String? id;
  bool? isDenLuot;

  Data(
      {this.infoCanBo,
      this.trangThaiHienTai,
      this.loaiXuLy,
      this.idCha,
      this.idTrinhKy,
      this.id,
      this.isDenLuot});

  Data.fromJson(Map<String, dynamic> json) {
    infoCanBo = json['InfoCanBo'] != null
        ? InfoCanBo.fromJson(json['InfoCanBo'])
        : null;
    trangThaiHienTai = json['TrangThaiHienTai'];
    loaiXuLy = json['LoaiXuLy'];
    idCha = json['IdCha'];
    idTrinhKy = json['IdTrinhKy'];
    id = json['Id'];
    isDenLuot = json['IsDenLuot'];
  }

  LuongXuLyVBDiModel toDomain() => LuongXuLyVBDiModel(
      id: id,
      infoCanBo: infoCanBo?.toDomain(),
      loaiXuLy: loaiXuLy,
      idCha: idCha,
      idTrinhKy: idTrinhKy,
      trangThaiHienTai: trangThaiHienTai,
      isDenLuot: isDenLuot);
}

class InfoCanBo {
  String? id;
  String? hoTen;
  String? donVi;
  String? chucVu;
  String? idChucVu;
  String? idDonVi;
  String? tenTaiKhoan;
  String? sdt;
  String? cANumber;
  String? ngaySinh;
  bool? gioiTinh;
  String? email;
  String? pathAnhDaiDien;
  String? pathChuKy;
  String? user;
  String? anhDaiDien;
  String? anhChuKy;

  InfoCanBo(
      {this.id,
      this.hoTen,
      this.donVi,
      this.chucVu,
      this.idChucVu,
      this.idDonVi,
      this.tenTaiKhoan,
      this.sdt,
      this.cANumber,
      this.ngaySinh,
      this.gioiTinh,
      this.email,
      this.pathAnhDaiDien,
      this.pathChuKy,
      this.user,
      this.anhDaiDien,
      this.anhChuKy});

  InfoCanBo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    hoTen = json['HoTen'];
    donVi = json['DonVi'];
    chucVu = json['ChucVu'];
    idChucVu = json['IdChucVu'];
    idDonVi = json['IdDonVi'];
    tenTaiKhoan = json['TenTaiKhoan'];
    sdt = json['Sdt'];
    cANumber = json['CANumber'];
    ngaySinh = json['NgaySinh'];
    gioiTinh = json['GioiTinh'];
    email = json['Email'];
    pathAnhDaiDien = json['PathAnhDaiDien'];
    pathChuKy = json['PathChuKy'];
    user = json['User'];
    anhDaiDien = json['AnhDaiDien'];
    anhChuKy = json['AnhChuKy'];
  }

  InfoCanBoModel toDomain() => InfoCanBoModel(
        id: id,
        hoTen: hoTen,
        donVi: donVi,
        chucVu: chucVu,
        idChucVu: idChucVu,
        idDonVi: idDonVi,
        tenTaiKhoan: tenTaiKhoan,
        sdt: sdt,
        ngaySinh: ngaySinh,
        gioiTinh: gioiTinh,
        email: email,
        pathAnhDaiDien: pathAnhDaiDien,
        pathChuKy: pathChuKy,
        user: user,
        anhDaiDien: anhDaiDien,
        anhChuKy: anhChuKy,
      );
}
