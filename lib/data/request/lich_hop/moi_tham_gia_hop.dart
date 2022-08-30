import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MoiThamGiaHopRequest {
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'VaiTroThamGia')
  int? vaiTroThamGia;
  @JsonKey(name: 'DonViId')
  String? DonViId;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'userId')
  String? userId;


  @JsonKey(name: 'DauMoiLienHe')
  String? dauMoiLienHe;
  @JsonKey(name: 'Email')
  String? Email;
  @JsonKey(name: 'GhiChu')
  String? GhiChu;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'TenCoQuan')
  String? TenCoQuan;
  @JsonKey(name: 'dauMoi')
  String? dauMoi;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'noiDungLamViec')
  String? noiDungLamViec;
  @JsonKey(name: 'tenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'SoDienThoai')
  String? SoDienThoai;

  MoiThamGiaHopRequest({
    this.canBoId,
    this.donViId,
    this.vaiTroThamGia,
    this.DonViId,
    this.chucVu,
    this.hoTen,
    this.id,
    this.status,
    this.tenDonVi,
    this.type,
    this.userId,
    this.dauMoiLienHe,
    this.Email,
    this.GhiChu,
    this.soDienThoai,
    this.TenCoQuan,
    this.dauMoi,
    this.email,
    this.noiDungLamViec,
    this.tenCanBo,
    this.SoDienThoai,
  });

  MoiThamGiaHopRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    donViId = json['donViId'];
    tenDonVi = json['tenDonVi'];
    userId = json['userId'];
    hoTen = json['hoTen'];
    chucVu = json['chucVu'];
    type = json['type'];
    status = json['status'];
    donViId = json['DonViId'];
    canBoId = json['CanBoId'];
    vaiTroThamGia = json['VaiTroThamGia'];
    tenDonVi = json['tenDonVi'];
    dauMoi = json['dauMoi'];
    noiDungLamViec = json['noiDungLamViec'];
    email = json['email'];
    soDienThoai = json['soDienThoai'];
    tenCanBo = json['tenCanBo'];
    dauMoiLienHe = json['DauMoiLienHe'];
    email = json['Email'];
    soDienThoai = json['SoDienThoai'];
    vaiTroThamGia = json['VaiTroThamGia'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['id'] = id;
    }
    if (donViId != null) {
      data['donViId'] = donViId;
    }
    if (tenDonVi != null) {
      data['tenDonVi'] = tenDonVi;
    }
    if (userId != null) {
      data['userId'] = userId;
    }
    if (hoTen != null) {
      data['hoTen'] = hoTen;
    }
    if (chucVu != null) {
      data['chucVu'] = chucVu;
    }
    if (type != null) {
      data['type'] = type;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (donViId != null) {
      data['DonViId'] = donViId;
    }
    if (canBoId != null) {
      data['CanBoId'] = canBoId;
    }
    if (vaiTroThamGia != null) {
      data['VaiTroThamGia'] = vaiTroThamGia;
    }
    if (tenDonVi != null) {
      data['tenDonVi'] = tenDonVi;
    }
    if (dauMoi != null) {
      data['dauMoi'] = dauMoi;
    }
    if (noiDungLamViec != null) {
      data['noiDungLamViec'] = noiDungLamViec;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (soDienThoai != null) {
      data['soDienThoai'] = soDienThoai;
    }
    if (tenCanBo != null) {
      data['tenCanBo'] = tenCanBo;
    }
    if (dauMoiLienHe != null) {
      data['DauMoiLienHe'] = dauMoiLienHe;
    }
    if (email != null) {
      data['Email'] = email;
    }
    if (soDienThoai != null) {
      data['SoDienThoai'] = soDienThoai;
    }
    if (vaiTroThamGia != null) {
      data['VaiTroThamGia'] = vaiTroThamGia;
    }
    if (id != null) {
      data['id'] = id;
    }
    if (TenCoQuan != null) {
      data['TenCoQuan'] = TenCoQuan;
    }
    return data;
  }
}
