import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';

class YKienSuLyNhiemVuModel {
  String? id;
  String? nhiemVuId;
  String? noiDung;
  String? nguoiTaoId;
  String? ngayTao;
  String? ngaySua;
  String? hashValue;
  String? hashAlg;
  bool? isSign;
  bool? issuer;
  String? signerInfos;
  String? serialNumber;
  String? tenNhanVien;
  String? chucVu;
  String? phanXuLy;
  List<YKienXuLyFileDinhKem>? yKienXuLyFileDinhKem;
  String avatarCommon;
  String? avatar;

  YKienSuLyNhiemVuModel({
    this.id,
    this.nhiemVuId,
    this.noiDung,
    this.nguoiTaoId,
    this.ngayTao,
    this.ngaySua,
    this.hashValue,
    this.hashAlg,
    this.isSign,
    this.issuer,
    this.signerInfos,
    this.serialNumber,
    this.tenNhanVien,
    this.chucVu,
    this.phanXuLy,
    this.yKienXuLyFileDinhKem,
    this.avatarCommon = '',
    this.avatar,
  });
}

