import 'package:json_annotation/json_annotation.dart';

part 'tao_phien_hop_request.g.dart';

@JsonSerializable()
class TaoPhienHopRepuest {
  String? canBoId;
  String? donViId;
  String? thoiGian_BatDau;
  String? thoiGian_KetThuc;
  String? noiDung;
  String? tieuDe;
  String? hoTen;
  bool IsMultipe;
  List<FilesRepuest>? file;

  TaoPhienHopRepuest(
      {this.canBoId,
      this.donViId,
      this.thoiGian_BatDau,
      this.thoiGian_KetThuc,
      this.noiDung,
      this.tieuDe,
      this.hoTen,
      this.IsMultipe = false,
      this.file});

  factory TaoPhienHopRepuest.fromJson(Map<String, dynamic> json) =>
      _$TaoPhienHopRepuestFromJson(json);

  Map<String, dynamic> toJson() => _$TaoPhienHopRepuestToJson(this);
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
