import 'package:ccvc_mobile/home_module/domain/model/home/nguoi_gan_cong_viec_model.dart';

class NguoiGanResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;

  NguoiGanResponse(
      {this.data, this.statusCode, this.succeeded,});

  NguoiGanResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  List<Items>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  Data(
      {this.items,
        this.pageIndex,
        this.pageSize,
        this.totalCount,
        this.totalPage,});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalCount'] = totalCount;
    data['totalPage'] = totalPage;
    return data;
  }
  NguoiGanCongViecModel toDomain() => NguoiGanCongViecModel(
      items:items?.map((e) => e.toDomain()).toList()??[],
  );
}

class Items {
  String? id;
  String? maCanBo;
  String? hoTen;
  String? phoneDiDong;
  String? phoneCoQuan;
  String? phoneNhaRieng;
  String? email;
  bool? gioiTinh;
  String? gioiTinhStr;
  String? ngaySinh;
  List<String>? userName;
  String? cmtnd;
  String? anhDaiDienFilePath;
  String? anhChuKyFilePath;
  String? anhChuKyNhayFilePath;
  bool? bitChuyenCongTac;
  String? thoiGianCapNhat;
  bool? bitNhanTinBuonEmail;
  bool? bitNhanTinBuonSMS;
  bool? bitDanhBa;
  List<String>? chucVu;
  List<String>? donVi;
  bool? bitThuTruongDonVi;
  bool? bitDauMoiPAKN;
  String? diaChi;
  int? thuTu;
  int? iThuTu;
  String? tinh;
  String? huyen;
  String? xa;
  String? hinhThucNhanTin;
  Items(
      {this.id,
        this.maCanBo,
        this.hoTen,
        this.phoneDiDong,
        this.phoneCoQuan,
        this.phoneNhaRieng,
        this.email,
        this.gioiTinh,
        this.gioiTinhStr,
        this.ngaySinh,
        this.userName,
        this.cmtnd,
        this.anhDaiDienFilePath,
        this.anhChuKyFilePath,
        this.anhChuKyNhayFilePath,
        this.bitChuyenCongTac,
        this.thoiGianCapNhat,
        this.bitNhanTinBuonEmail,
        this.bitNhanTinBuonSMS,
        this.bitDanhBa,
        this.chucVu,
        this.donVi,
        this.bitThuTruongDonVi,
        this.bitDauMoiPAKN,
        this.diaChi,
        this.thuTu,
        this.iThuTu,
        this.tinh,
        this.huyen,
        this.xa,
        this.hinhThucNhanTin,
      });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maCanBo = json['maCanBo'];
    hoTen = json['hoTen'];
    phoneDiDong = json['phone_DiDong'];
    phoneCoQuan = json['phone_CoQuan'];
    phoneNhaRieng = json['phone_NhaRieng'];
    email = json['email'];
    gioiTinh = json['gioiTinh'];
    gioiTinhStr = json['gioiTinhStr'];
    ngaySinh = json['ngaySinh'];
    userName = json['userName'].cast<String>();
    cmtnd = json['cmtnd'];
    anhDaiDienFilePath = json['anhDaiDien_FilePath'];
    anhChuKyFilePath = json['anhChuKy_FilePath'];
    anhChuKyNhayFilePath = json['anhChuKyNhay_FilePath'];
    bitChuyenCongTac = json['bit_ChuyenCongTac'];
    thoiGianCapNhat = json['thoiGian_CapNhat'];
    bitNhanTinBuonEmail = json['bit_NhanTinBuon_Email'];
    bitNhanTinBuonSMS = json['bit_NhanTinBuon_SMS'];
    bitDanhBa = json['bit_DanhBa'];
    chucVu = json['chucVu'].cast<String>();
    donVi = json['donVi'].cast<String>();
    bitThuTruongDonVi = json['bit_ThuTruongDonVi'];
    bitDauMoiPAKN = json['bitDauMoiPAKN'];
    diaChi = json['diaChi'];
    thuTu = json['thuTu'];
    iThuTu = json['_ThuTu'];
    tinh = json['tinh'];
    huyen = json['huyen'];
    xa = json['xa'];
    hinhThucNhanTin = json['hinhThucNhanTin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['maCanBo'] = maCanBo;
    data['hoTen'] = hoTen;
    data['phone_DiDong'] = phoneDiDong;
    data['phone_CoQuan'] = phoneCoQuan;
    data['phone_NhaRieng'] = phoneNhaRieng;
    data['email'] = email;
    data['gioiTinh'] = gioiTinh;
    data['gioiTinhStr'] = gioiTinhStr;
    data['ngaySinh'] = ngaySinh;
    data['userName'] = userName;
    data['cmtnd'] = cmtnd;
    data['anhDaiDien_FilePath'] = anhDaiDienFilePath;
    data['anhChuKy_FilePath'] = anhChuKyFilePath;
    data['anhChuKyNhay_FilePath'] = anhChuKyNhayFilePath;
    data['bit_ChuyenCongTac'] = bitChuyenCongTac;
    data['thoiGian_CapNhat'] = thoiGianCapNhat;
    data['bit_NhanTinBuon_Email'] = bitNhanTinBuonEmail;
    data['bit_NhanTinBuon_SMS'] = bitNhanTinBuonSMS;
    data['bit_DanhBa'] = bitDanhBa;
    data['chucVu'] = chucVu;
    data['donVi'] = donVi;
    data['bit_ThuTruongDonVi'] = bitThuTruongDonVi;
    data['bitDauMoiPAKN'] = bitDauMoiPAKN;
    data['diaChi'] = diaChi;
    data['thuTu'] = thuTu;
    data['_ThuTu'] = iThuTu;
    data['tinh'] = tinh;
    data['huyen'] = huyen;
    data['xa'] = xa;
    data['hinhThucNhanTin'] = hinhThucNhanTin;
    return data;
  }
  ItemNguoiGanModel toDomain() => ItemNguoiGanModel(
      chucVu: chucVu??[],
      id: id??'',
      donVi: donVi??[],
      hoTen:hoTen??'',
  );
}
