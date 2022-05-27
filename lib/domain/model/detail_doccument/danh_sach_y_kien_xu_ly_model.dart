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

class TraLoiYKien {
  String id;
  String taskXinYKienId;
  String nguoiTraLoiId;
  String hoTenNguoiTraLoi;
  String donViNguoiTraLoi;
  String chucVuNguoiTraLoi;
  String noiDungTraLoi;
  String thoiGianTraLoi;
  String thoiGianTraLoiStr;
  bool isDaTraLoi;
  List<YKienXuLyFileDinhKem>? lstFileDinhKemTraLoi;
  bool isSign;
  bool issuer;
  String avatarCommon;
  String avatar;

  TraLoiYKien({
    this.id = '',
    this.taskXinYKienId = '',
    this.nguoiTraLoiId = '',
    this.hoTenNguoiTraLoi = '',
    this.donViNguoiTraLoi = '',
    this.chucVuNguoiTraLoi = '',
    this.noiDungTraLoi = '',
    this.thoiGianTraLoi = '',
    this.thoiGianTraLoiStr = '',
    this.isDaTraLoi = false,
    this.lstFileDinhKemTraLoi,
    this.isSign = false,
    this.issuer = false,
    this.avatarCommon = '',
    this.avatar = '',
  });
}

class DanhSachYKienXuLy {
  String? id;
  String? vanBanId;
  String? taskId;
  String? noiDung;
  String? nguoiTaoId;
  String? ngayTao;
  String? ngaySua;
  String? hashValue;
  List<TraLoiYKien>? listTraloiYKien;
  bool? isSign;
  bool canRelay = false;
  bool? issuer;
  String? tenNhanVien;
  String? chucVu;
  String? phanXuLy;
  String? avatarCommon;
  String? avatar;
  List<YKienXuLyFileDinhKem>? yKienXuLyFileDinhKem;

  DanhSachYKienXuLy({
    this.listTraloiYKien,
    this.id,
    this.vanBanId,
    this.taskId,
    this.noiDung,
    this.nguoiTaoId,
    this.ngayTao,
    this.ngaySua,
    this.hashValue,
    this.isSign,
    this.canRelay = false,
    this.issuer,
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
