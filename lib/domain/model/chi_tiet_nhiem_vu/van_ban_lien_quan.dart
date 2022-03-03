import 'dart:io';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class VanBanLienQuanModel {
  String id = '';
  List<ItemVanBanLienQuanModel> vanBanGiaoNV = [];
  List<ItemVanBanLienQuanModel> vanBanKhac = [];

  VanBanLienQuanModel.empty();

  VanBanLienQuanModel(
      {required this.id, required this.vanBanGiaoNV, required this.vanBanKhac});
}

class ItemVanBanLienQuanModel {
  String id = '';
  String soKyHieu = '';
  String ngayVB = '';
  String trichYeu = '';
  File fileDinhKem = File('');

  ItemVanBanLienQuanModel.empty();

  ItemVanBanLienQuanModel({
    required this.id,
    required this.soKyHieu,
    required this.trichYeu,
    required this.ngayVB,
    required this.fileDinhKem,
  });

  List<RowDataExpandModel> dataRowVBLQ() {
    final List<RowDataExpandModel> list = [
      RowDataExpandModel(
        key: S.current.so_ky_hieu,
        value: soKyHieu,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.ngay_vb,
        value: ngayVB,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.trich_yeu,
        value: trichYeu,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.file_dinh_kem,
        value: fileDinhKem,
        type: TypeDataNV.file,
      ),
    ];
    return list;
  }
}

class RowDataExpandModel {
  String key;
  dynamic value;
  TypeDataNV type;

  RowDataExpandModel({
    required this.key,
    required this.value,
    required this.type,
  });
}
