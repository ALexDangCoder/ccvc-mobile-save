import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';

class DanhSachCanBoHopResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DanhSachCanBoHopResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  DanhSachCanBoHopResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  List<ListCanBo>? listCanBo;
  CountStatus? countStatus;

  Data({this.listCanBo, this.countStatus});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['listCanBo'] != null) {
      listCanBo = <ListCanBo>[];
      json['listCanBo'].forEach((v) {
        listCanBo!.add(ListCanBo.fromJson(v));
      });
    }
    countStatus = json['countStatus'] != null
        ? CountStatus.fromJson(json['countStatus'])
        : null;
  }
}

class ListCanBo {
  String? tenChucVu;
  bool? diemDanh;
  bool? disable;
  int? trangThai;
  bool? isVangMat;
  String? id;
  String? lichHopId;
  String? donViId;
  String? canBoId;
  int? vaiTroThamGia;
  String? soDienThoai;
  String? dauMoiLienHe;
  String? tenCanBo;
  String? tenCoQuan;
  bool? isThuKy;
  bool? isThamGiaBocBang;
  String? createAt;
  String? parentId;
  String? ghiChu;

  ListCanBo({
    this.tenChucVu,
    this.diemDanh,
    this.disable,
    this.trangThai,
    this.isVangMat,
    this.id,
    this.lichHopId,
    this.donViId,
    this.canBoId,
    this.vaiTroThamGia,
    this.soDienThoai,
    this.dauMoiLienHe,
    this.tenCanBo,
    this.tenCoQuan,
    this.isThuKy,
    this.isThamGiaBocBang,
    this.createAt,
    this.parentId,
    this.ghiChu,
  });

  ListCanBo.fromJson(Map<String, dynamic> json) {
    tenChucVu = json['tenChucVu'];
    diemDanh = json['diemDanh'];
    disable = json['disable'];
    trangThai = json['trangThai'];
    isVangMat = json['isVangMat'];
    id = json['id'];
    lichHopId = json['lichHopId'];
    donViId = json['donViId'];
    canBoId = json['canBoId'];
    vaiTroThamGia = json['vaiTroThamGia'];
    soDienThoai = json['soDienThoai'];
    dauMoiLienHe = json['dauMoiLienHe'];
    tenCanBo = json['tenCanBo'];
    tenCoQuan = json['tenCoQuan'];
    isThuKy = json['isThuKy'];
    isThamGiaBocBang = json['isThamGiaBocBang'];
    createAt = json['createAt'];
    parentId = json['parentId'];
    ghiChu = json['ghiChu'];
  }

  NguoiChutriModel toDomain() => NguoiChutriModel(
        id: id ?? '',
        tenDonVi: tenChucVu ?? '',
        hoTen: tenCanBo ?? '',
        isThuKy: isThuKy,
        vaiTroThamGia: vaiTroThamGia,
        trangThai: trangThai,
        donViId: donViId,
        canBoId: canBoId,
        parentId: parentId,
        tenCanBo: tenCanBo,
        tenCoQuan: tenCoQuan,
        ghiChu: ghiChu,
      );
}

class CountStatus {
  int? tongSoThamGia;
  int? tongSoTuChoi;
  int? daDiemDanh;
  int? chuaDiemDanh;

  CountStatus({
    this.tongSoThamGia,
    this.tongSoTuChoi,
    this.daDiemDanh,
    this.chuaDiemDanh,
  });

  CountStatus.fromJson(Map<String, dynamic> json) {
    tongSoThamGia = json['tongSoThamGia'];
    tongSoTuChoi = json['tongSoTuChoi'];
    daDiemDanh = json['daDiemDanh'];
    chuaDiemDanh = json['chuaDiemDanh'];
  }
}
