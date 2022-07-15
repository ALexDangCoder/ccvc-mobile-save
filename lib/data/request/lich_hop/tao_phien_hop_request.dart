import 'package:json_annotation/json_annotation.dart';

part 'tao_phien_hop_request.g.dart';

@JsonSerializable()
class TaoPhienHopDetailRepuest {
  String? canBoId;
  String? donViId;
  int? vaiTroThamGia;
  String? thoiGian_BatDau;
  String? thoiGian_KetThuc;
  String? noiDung;
  String? tieuDe;
  String? hoTen;
  bool IsMultipe;
  String? gioBatDau;
  String? gioKetThuc;

  TaoPhienHopDetailRepuest({
    this.canBoId,
    this.donViId,
    this.vaiTroThamGia,
    this.thoiGian_BatDau,
    this.thoiGian_KetThuc,
    this.noiDung,
    this.tieuDe,
    this.hoTen,
    this.IsMultipe = false,
    this.gioBatDau,
    this.gioKetThuc,
  });

  factory TaoPhienHopDetailRepuest.fromJson(Map<String, dynamic> json) =>
      _$TaoPhienHopDetailRepuestFromJson(json);

  Map<String, dynamic> toJson() => _$TaoPhienHopDetailRepuestToJson(this);
}

@JsonSerializable()
class FilesRepuest {
  String? id;
  String? name;
  String? extension;
  String? size;
  String? path;
  String? entityId;
  String? entityName;

  FilesRepuest({
    this.id,
    this.name,
    this.extension,
    this.size,
    this.path,
    this.entityId,
    this.entityName,
  });

  factory FilesRepuest.fromJson(Map<String, dynamic> json) =>
      _$FilesRepuestFromJson(json);

  Map<String, dynamic> toJson() => _$FilesRepuestToJson(this);
}
