import 'dart:convert';

import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
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

  DanhSachKetQuaYKXLModel toModel() => DanhSachKetQuaYKXLModel(
        danhSachKetQua: danhSachKetQua?.map((e) => e.toModel()).toList() ?? [],
        noiDungThongDiep: noiDungThongDiep,
        maTraLoi: maTraLoi,
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
  @JsonKey(name: 'AnhDaiDienNguoiCho')
  String? anhDaiDienNguoiCho;
  @JsonKey(name: 'AnhDaiDienNguoiXin')
  String? anhDaiDienNguoiXin;

  YKienXuLyYKNDModelResponse(
      {this.id,
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
      this.anhDaiDienNguoiCho,
      this.anhDaiDienNguoiXin});

  factory YKienXuLyYKNDModelResponse.fromJson(Map<String, dynamic> json) =>
      _$YKienXuLyYKNDModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YKienXuLyYKNDModelResponseToJson(this);

  YKienXuLyYKNDModel toModel() => YKienXuLyYKNDModel(
        id: id,
        kienNghiId: kienNghiId,
        nguoiXinYKien: nguoiXinYKien,
        nguoiChoYKien: nguoiChoYKien,
        daChoYKien: daChoYKien,
        noiDung: noiDung,
        ngayTao: ngayTao == null
            ? ''
            : DateTime.parse(ngayTao!).formatApiListBieuQuyetMobile,
        ngaySua: ngaySua == null
            ? ''
            : DateTime.parse(ngaySua!).formatApiListBieuQuyetMobile,
        type: type,
        tenNguoiChoYKien: tenNguoiChoYKien,
        tenNguoiXinYKien: tenNguoiXinYKien,
        dSFile: dSFile == null
            ? null
            : (jsonDecode(dSFile ?? '') as List<dynamic>)
                .map((e) => FileResponse.fromJson(e).toModel())
                .toList(),
        anhDaiDienNguoiCho: anhDaiDienNguoiCho,
        anhDaiDienNguoiXin: anhDaiDienNguoiXin,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class FileResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'DungLuong')
  String? dungLuong;
  @JsonKey(name: 'DaKySo')
  bool? daKySo;
  @JsonKey(name: 'DaGanQR')
  bool? daGanQR;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'SuDung')
  bool? suDung;

  FileResponse(
    this.id,
    this.ten,
    this.duongDan,
    this.dungLuong,
    this.daKySo,
    this.daGanQR,
    this.ngayTao,
    this.nguoiTaoId,
    this.suDung,
  );

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileResponseToJson(this);

  FileModel toModel() => FileModel(
        id,
        ten,
        '${Get.find<AppConstants>().baseUrlPAKN}/$duongDan',
        dungLuong,
        daKySo,
        daGanQR,
        ngayTao,
        nguoiTaoId,
        suDung,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
