import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/y_kien_su_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'y_kien_su_ly_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataYKienXuLyFileDinhKemResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'Data')
  List<YKienSuLyNhiemVuModelResponse>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataYKienXuLyFileDinhKemResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  factory DataYKienXuLyFileDinhKemResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataYKienXuLyFileDinhKemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataYKienXuLyFileDinhKemResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class YKienSuLyNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'NhiemVuId')
  String? nhiemVuId;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'NgaySua')
  String? ngaySua;
  @JsonKey(name: 'HashValue')
  String? hashValue;
  @JsonKey(name: 'HashAlg')
  String? hashAlg;
  @JsonKey(name: 'IsSign')
  bool? isSign;
  @JsonKey(name: 'Issuer')
  bool? issuer;
  @JsonKey(name: 'SignerInfos')
  String? signerInfos;
  @JsonKey(name: 'SerialNumber')
  String? serialNumber;
  @JsonKey(name: 'TenNhanVien')
  String? tenNhanVien;
  @JsonKey(name: 'ChucVu')
  String? chucVu;
  @JsonKey(name: 'PhanXuLy')
  String? phanXuLy;
  @JsonKey(name: 'YKienXuLyFileDinhKem')
  List<YKienXuLyFileDinhKemResponse>? yKienXuLyFileDinhKem;
  @JsonKey(name: 'AvatarCommon')
  String? avatarCommon;
  @JsonKey(name: 'Avatar')
  String? avatar;

  YKienSuLyNhiemVuModelResponse({
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
    this.avatarCommon,
    this.avatar,
  });

  factory YKienSuLyNhiemVuModelResponse.fromJson(Map<String, dynamic> json) =>
      _$YKienSuLyNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YKienSuLyNhiemVuModelResponseToJson(this);

  YKienSuLyNhiemVuModel toModel() => YKienSuLyNhiemVuModel(
        id: id,
        nhiemVuId: nhiemVuId,
        noiDung: noiDung ?? '',
        nguoiTaoId: nguoiTaoId,
        ngayTao: ngayTao,
        ngaySua: ngaySua,
        hashValue: hashValue,
        hashAlg: hashAlg,
        isSign: isSign,
        issuer: issuer,
        signerInfos: signerInfos,
        serialNumber: serialNumber,
        tenNhanVien: tenNhanVien,
        chucVu: chucVu,
        phanXuLy: phanXuLy,
        yKienXuLyFileDinhKem:
            yKienXuLyFileDinhKem?.map((e) => e.toModel()).toList(),
        avatarCommon: avatarCommon ?? '',
        avatar: avatar,
      );

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class YKienXuLyFileDinhKemResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'YKienXuLyId')
  String? yKienXuLyId;
  @JsonKey(name: 'FileDinhKemId')
  String? fileDinhKemId;
  @JsonKey(name: 'DataKySo')
  String? dataKySo;
  @JsonKey(name: 'KeyKySo')
  String? keyKySo;
  @JsonKey(name: 'FileDinhKem')
  FileDinhKemsResponse? fileDinhKem;

  YKienXuLyFileDinhKemResponse({
    this.id,
    this.yKienXuLyId,
    this.fileDinhKemId,
    this.dataKySo,
    this.keyKySo,
    this.fileDinhKem,
  });

  factory YKienXuLyFileDinhKemResponse.fromJson(Map<String, dynamic> json) =>
      _$YKienXuLyFileDinhKemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YKienXuLyFileDinhKemResponseToJson(this);

  YKienXuLyFileDinhKem toModel() => YKienXuLyFileDinhKem(
        id: id,
        yKienXuLyId: yKienXuLyId,
        fileDinhKemId: fileDinhKemId,
        dataKySo: dataKySo,
        keyKySo: keyKySo,
        fileDinhKem: fileDinhKem?.toModel(),
      );

  @override
  List<Object?> get props => [];
}
