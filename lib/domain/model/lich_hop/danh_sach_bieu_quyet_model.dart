import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';

class DanhSachBietQuyetModel {
  String? id;
  String? idLichHop;
  String? idPhienHopCanBo;
  String? noiDung;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  bool? loaiBieuQuyet;
  List<DanhSachKetQuaBieuQuyet>? danhSachKetQuaBieuQuyet;

  DanhSachBietQuyetModel({
    required this.id,
    required this.idLichHop,
    required this.idPhienHopCanBo,
    required this.noiDung,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.loaiBieuQuyet,
    required this.danhSachKetQuaBieuQuyet,
  });
}

String loaiBieuQuyetFunc(bool loaiBieuQuyet) {
  if (loaiBieuQuyet == false) {
    return S.current.bo_khieu_kin;
  }
  return S.current.bo_phieu_cong_khai;
}

String coverDateTime(String dates) {
  final dateCover = DateFormat('yyyy-MM-ddTHH:mm:ss')
      .parse(dates)
      .formatApiListBieuQuyetMobile;
  return dateCover;
}

String coverDateTimeApi(String dates) {
  final dateCover =
      DateFormat('MM/dd/yyyy HH:mm:ss').parse(dates).formatBieuQuyetChooseTime;
  return dateCover;
}

class DanhSachKetQuaBieuQuyet {
  String? luaChonId;
  String? tenLuaChon;
  String? mauLuaChon;
  int? soLuongLuaChon;
  bool? isVote;

  DanhSachKetQuaBieuQuyet({
    required this.luaChonId,
    required this.tenLuaChon,
    required this.mauLuaChon,
    required this.soLuongLuaChon,
    required this.isVote,
  });
}
