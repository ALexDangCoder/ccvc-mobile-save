
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/utils/extensions/string_extension.dart';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_ket_qua_y_kien_xu_ly_response.g.dart';

@JsonSerializable()
class DanhSachKetQuaYKXLModelResponse extends Equatable {
  @JsonKey(name: 'DanhSachKetQua')
  List<YKienXuLyYKNDModelResponse>? danhSachKetQua;
  @JsonKey(name: 'NoiDungThongDiep')
  String? noiDungThongDiep;
  @JsonKey(name: 'MaTraLoi')
  int? maTraLoi;

  DanhSachKetQuaYKXLModelResponse({
    this.danhSachKetQua,
    this.noiDungThongDiep,
    this.maTraLoi,
  });

  factory DanhSachKetQuaYKXLModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachKetQuaYKXLModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachKetQuaYKXLModelResponseToJson(this);
  DanhSachKetQuaYKXLModel toModel()=>DanhSachKetQuaYKXLModel(
    danhSachKetQua:danhSachKetQua?.map((e) => e.toModel()).toList()??[],
    noiDungThongDiep:noiDungThongDiep,
    maTraLoi:maTraLoi,
  );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class YKienXuLyYKNDModelResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'KienNghiId')
  String? kienNghiId;
  @JsonKey(name: 'NguoiXinYKien')
  String? nguoiXinYKien;
  @JsonKey(name: 'NguoiChoYKien')
  String? nguoiChoYKien;
  @JsonKey(name: 'DaChoYKien')
  bool? daChoYKien;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'NgaySua')
  String? ngaySua;
  @JsonKey(name: 'Type')
  int? type;
  @JsonKey(name: 'TenNguoiChoYKien')
  String? tenNguoiChoYKien;
  @JsonKey(name: 'TenNguoiXinYKien')
  String? tenNguoiXinYKien;
  @JsonKey(name: 'DSFile')
  String? dSFile;

  YKienXuLyYKNDModelResponse({
    this.id,
    this.kienNghiId,
    this.nguoiXinYKien,
    this.nguoiChoYKien,
    this.daChoYKien,
    this.noiDung,
    this.ngayTao,
    this.ngaySua,
    this.type,
    this.tenNguoiChoYKien,
    this.tenNguoiXinYKien,
    this.dSFile,
  });

  factory YKienXuLyYKNDModelResponse.fromJson(Map<String, dynamic> json) =>
      _$YKienXuLyYKNDModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YKienXuLyYKNDModelResponseToJson(this);

  YKienXuLyYKNDModel toModel()=>YKienXuLyYKNDModel(
    id:id,
    kienNghiId:kienNghiId,
    nguoiXinYKien:nguoiXinYKien,
    nguoiChoYKien:nguoiChoYKien,
    daChoYKien:daChoYKien,
    noiDung:noiDung?.parseHtml(),
    ngayTao:ngayTao,
    ngaySua:ngaySua,
    type:type,
    tenNguoiChoYKien:tenNguoiChoYKien,
    tenNguoiXinYKien:tenNguoiXinYKien,
    dSFile:dSFile,
  );
  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
