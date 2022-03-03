import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_phien_hop_response.g.dart';

@JsonSerializable()
class ListPhienHopRespone {
  @JsonKey(name: 'data')
  List<DataListPhienHopRespone> data;

  ListPhienHopRespone(this.data);

  factory ListPhienHopRespone.fromJson(Map<String, dynamic> json) =>
      _$ListPhienHopResponeFromJson(json);

  Map<String, dynamic> toJson() => _$ListPhienHopResponeToJson(this);

  List<ListPhienHopModel> toDomain() => data.map((e) => e.toDoMains()).toList();
}

@JsonSerializable()
class DataListPhienHopRespone {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'tieuDe')
  String? tieuDe;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'vaiTroThamGia')
  int? vaiTroThamGia;
  @JsonKey(name: 'thuTu')
  int? thuTu;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'createBy')
  String? createBy;
  @JsonKey(name: 'files')
  List<FilesRespone>? files;

  DataListPhienHopRespone({
    this.id,
    this.lichHopId,
    this.tieuDe,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.canBoId,
    this.donViId,
    this.vaiTroThamGia,
    this.thuTu,
    this.noiDung,
    this.hoTen,
    this.createBy,
    this.files,
  });

  factory DataListPhienHopRespone.fromJson(Map<String, dynamic> json) =>
      _$DataListPhienHopResponeFromJson(json);

  Map<String, dynamic> toJson() => _$DataListPhienHopResponeToJson(this);

  ListPhienHopModel toDoMains() => ListPhienHopModel(
        id: id,
        lichHopId: lichHopId,
        tieuDe: tieuDe,
        thoiGianBatDau: thoiGianBatDau,
        thoiGianKetThuc: thoiGianKetThuc,
        canBoId: canBoId,
        donViId: donViId,
        vaiTroThamGia: vaiTroThamGia,
        thuTu: thuTu,
        noiDung: noiDung,
        hoTen: hoTen,
        createBy: createBy,
        files: files?.map((e) => e.toDoMain()).toList() ?? [],
      );
}

@JsonSerializable()
class FilesRespone {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'extension')
  String? extension;
  @JsonKey(name: 'size')
  String? size;
  @JsonKey(name: 'path')
  String? path;
  @JsonKey(name: 'entityId')
  String? entityId;
  @JsonKey(name: 'entityName')
  String? entityName;

  FilesRespone({
    this.id,
    this.name,
    this.extension,
    this.size,
    this.path,
    this.entityId,
    this.entityName,
  });

  factory FilesRespone.fromJson(Map<String, dynamic> json) =>
      _$FilesResponeFromJson(json);

  Map<String, dynamic> toJson() => _$FilesResponeToJson(this);

  Files toDoMain() => Files(
        id: id,
        name: name,
        extension: extension,
        size: size,
        path: path,
        entityId: entityId,
        entityName: entityName,
      );
}
