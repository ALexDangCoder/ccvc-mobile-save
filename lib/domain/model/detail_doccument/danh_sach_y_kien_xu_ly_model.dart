import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';

class DataDanhSachYKienXuLy {
  String? messages;
  List<DanhSachYKienXuLy>? data;
  String? validationResult;
  bool? isSuccess;

  DataDanhSachYKienXuLy({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });
}

class DanhSachYKienXuLy {
  String? id;
  String? vanBanId;
  bool isInput = false;
  String? taskId;
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
  String? avatarCommon;
  String? avatar;
  List<YKienXuLyFileDinhKem>? yKienXuLyFileDinhKem;

  DanhSachYKienXuLy({
    this.isInput = false,
    this.id,
    this.vanBanId,
    this.taskId,
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
    this.avatarCommon,
    this.avatar,
    this.yKienXuLyFileDinhKem,
  });

  DanhSachYKienXuLy.empty();
}

class YKienXuLyFileDinhKem {
  String? id;
  String? yKienXuLyId;
  String? fileDinhKemId;
  String? dataKySo;
  String? keyKySo;
  FileDinhKems? fileDinhKem;

  YKienXuLyFileDinhKem({
    this.id,
    this.yKienXuLyId,
    this.fileDinhKemId,
    this.dataKySo,
    this.keyKySo,
    this.fileDinhKem,
  });
}
