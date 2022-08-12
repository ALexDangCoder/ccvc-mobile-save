import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_y_kien_xu_ly_response.g.dart';

@JsonSerializable()
class DataDanhSachYKienXuLyResponse {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<DanhSachYKienXuLyResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataDanhSachYKienXuLyResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory DataDanhSachYKienXuLyResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataDanhSachYKienXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataDanhSachYKienXuLyResponseToJson(this);

  DataDanhSachYKienXuLy toModel() => DataDanhSachYKienXuLy(
        messages: messages,
        data: data?.map((e) => e.toModel()).toList() ?? [],
        validationResult: validationResult,
        isSuccess: isSuccess,
      );
}

@JsonSerializable()
class DanhSachYKienXuLyResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'VanBanId')
  String? vanBanId;
  @JsonKey(name: 'TaskId')
  String? taskId;
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
  @JsonKey(name: 'AvatarCommon')
  String? avatarCommon;
  @JsonKey(name: 'Avatar')
  String? avatar;
  @JsonKey(name: 'YKienXuLyFileDinhKem')
  List<YKienXuLyFileDinhKemResponse>? yKienXuLyFileDinhKem;

  DanhSachYKienXuLyResponse({
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

  factory DanhSachYKienXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachYKienXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachYKienXuLyResponseToJson(this);

  DanhSachYKienXuLy toModel() => DanhSachYKienXuLy(
        id: id,
        vanBanId: vanBanId,
        taskId: taskId,
        noiDung: noiDung?.parseHtml(),
        nguoiTaoId: nguoiTaoId,
        ngayTao: ngayTao?.changeToNewPatternDate(
              DateTimeFormat.DATE_TIME_RECEIVE,
              DateTimeFormat.DATE_DD_MM_HM,
            ) ??
            '',
        ngaySua: ngaySua,
        hashValue: hashValue,
        isSign: isSign,
        issuer: issuer,
        tenNhanVien: tenNhanVien,
        chucVu: chucVu,
        phanXuLy: phanXuLy,
        avatarCommon: avatarCommon,
        avatar: avatar != null
            ? '${Get.find<AppConstants>().baseUrlQLNV}$avatar'
            : avatarCommon,
        yKienXuLyFileDinhKem:
            yKienXuLyFileDinhKem?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class YKienXuLyFileDinhKemResponse {
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
}
