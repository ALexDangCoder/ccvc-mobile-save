import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';

class ChuongTrinhHopModel {
  List<CanBoModel>? listCanBo;
  CountStatus? countStatus;

  ChuongTrinhHopModel.empty();

  ChuongTrinhHopModel({required this.listCanBo, required this.countStatus});
}

class CanBoModel {
  String? tenChucVu;
  bool? diemDanh;
  bool? disable;
  int? trangThai;
  bool? isVangMat;
  String? id;
  String? lichHopId;
  String? donViId;
  String? canBoId;
  String? vaiTro;
  String? ghiChu;
  String? parentId;
  int? vaiTroThamGia;
  String? email;
  String? soDienThoai;
  String? dauMoiLienHe;
  String? tenCoQuan;
  String? tenCanBo;
  bool? isThuKy;
  bool? isThamGiaBocBang;
  String? createAt;

  CanBoModel({
    required this.tenChucVu,
    required this.diemDanh,
    required this.disable,
    required this.trangThai,
    required this.isVangMat,
    required this.id,
    required this.lichHopId,
    required this.donViId,
    required this.canBoId,
    required this.vaiTro,
    required this.tenCanBo,
    required this.ghiChu,
    required this.parentId,
    required this.vaiTroThamGia,
    required this.email,
    required this.soDienThoai,
    required this.dauMoiLienHe,
    required this.tenCoQuan,
    required this.isThuKy,
    required this.isThamGiaBocBang,
    required this.createAt,
  });
}
