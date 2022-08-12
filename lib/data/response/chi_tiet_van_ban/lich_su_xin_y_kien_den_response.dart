import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/danh_sach_y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_xin_y_kien_den_response.g.dart';

@JsonSerializable()
class LichSuXinYKienDenResponse {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<DanhSachXinYkienResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  LichSuXinYKienDenResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory LichSuXinYKienDenResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LichSuXinYKienDenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichSuXinYKienDenResponseToJson(this);

  DataDanhSachYKienXuLy toModel() => DataDanhSachYKienXuLy(
        messages: messages,
        data: data?.map((e) => e.toModel()).toList() ?? [],
        validationResult: validationResult,
        isSuccess: isSuccess,
      );
}

@JsonSerializable()
class DanhSachXinYkienResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'TaskId')
  String? taskId;
  @JsonKey(name: 'NguoiTaoXuLyId')
  String? nguoiTaoXuLyId;
  @JsonKey(name: 'HoTenNguoiXin')
  String? hoTenNguoiXin;
  @JsonKey(name: 'DonViNguoiXin')
  String? donViNguoiXin;
  @JsonKey(name: 'ChucVuNguoiXin')
  String? chucVuNguoiXin;
  @JsonKey(name: 'NoiDungXinYKien')
  String? noiDungXinYKien;
  @JsonKey(name: 'ThoiGianTao')
  String? thoiGianTao;
  @JsonKey(name: 'ThoiGianTaoStr')
  String? thoiGianTaoStr;
  @JsonKey(name: 'ListTraLoiYKien')
  List<ListTraLoiYKien>? listTraLoiYKien;
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
  @JsonKey(name: 'NguoiTraLoi')
  String? nguoiTraLoi;
  @JsonKey(name: 'CountLeft')
  String? countLeft;
  @JsonKey(name: 'Tooltip')
  String? tooltip;
  @JsonKey(name: 'AvatarCommon')
  String? avatarCommon;
  @JsonKey(name: 'Avatar')
  String? avatar;

  DanhSachXinYkienResponse({
    this.id,
    this.taskId,
    this.nguoiTaoXuLyId,
    this.hoTenNguoiXin,
    this.donViNguoiXin,
    this.chucVuNguoiXin,
    this.noiDungXinYKien,
    this.thoiGianTao,
    this.thoiGianTaoStr,
    this.listTraLoiYKien,
    this.hashValue,
    this.hashAlg,
    this.isSign,
    this.issuer,
    this.signerInfos,
    this.serialNumber,
    this.nguoiTraLoi,
    this.countLeft,
    this.tooltip,
    this.avatarCommon,
    this.avatar,
  });

  factory DanhSachXinYkienResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachXinYkienResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachXinYkienResponseToJson(this);

  DanhSachYKienXuLy toModel() => DanhSachYKienXuLy(
        id: id,
        taskId: taskId,
        noiDung: noiDungXinYKien?.parseHtml(),
        nguoiTaoId: nguoiTaoXuLyId,
        ngayTao: thoiGianTaoStr?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DATE_DD_MM_YYYY,
            ) ??
            '',
        isSign: isSign,
        issuer: issuer,
        canRelay: listTraLoiYKien
                ?.where(
                  (element) =>
                      element.nguoiTraLoiId ==
                      HiveLocal.getDataUser()?.userInformation?.id,
                )
                .toList()
                .isNotEmpty ??
            false,
        tenNhanVien: hoTenNguoiXin,
        avatarCommon: avatarCommon,
        avatar: avatar != null
            ? '${Get.find<AppConstants>().baseUrlQLNV}$avatar'
            : avatarCommon,
        listTraloiYKien: listTraLoiYKien?.map((e) => e.toModel()).toList(),
      );
}

@JsonSerializable()
class ListTraLoiYKien {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'TaskXinYKienId')
  String? taskXinYKienId;
  @JsonKey(name: 'NguoiTraLoiId')
  String? nguoiTraLoiId;
  @JsonKey(name: 'HoTenNguoiTraLoi')
  String? hoTenNguoiTraLoi;
  @JsonKey(name: 'DonViNguoiTraLoi')
  String? donViNguoiTraLoi;
  @JsonKey(name: 'ChucVuNguoiTraLoi')
  String? chucVuNguoiTraLoi;
  @JsonKey(name: 'NoiDungTraLoi')
  String? noiDungTraLoi;
  @JsonKey(name: 'ThoiGianTraLoi')
  String? thoiGianTraLoi;
  @JsonKey(name: 'ThoiGianTraLoi_Str')
  String? thoiGianTraLoiStr;
  @JsonKey(name: 'isDaTraLoi')
  bool? isDaTraLoi;
  @JsonKey(name: 'LstFileDinhKemTraLoi')
  List<YKienXuLyFileDinhKemResponse>? lstFileDinhKemTraLoi;
  @JsonKey(name: 'IsSign')
  bool? isSign;
  @JsonKey(name: 'Issuer')
  bool? issuer;
  @JsonKey(name: 'AvatarCommon')
  String? avatarCommon;
  @JsonKey(name: 'Avatar')
  String? avatar;

  ListTraLoiYKien({
    this.id,
    this.taskXinYKienId,
    this.nguoiTraLoiId,
    this.hoTenNguoiTraLoi,
    this.donViNguoiTraLoi,
    this.chucVuNguoiTraLoi,
    this.noiDungTraLoi,
    this.thoiGianTraLoi,
    this.thoiGianTraLoiStr,
    this.isDaTraLoi,
    this.lstFileDinhKemTraLoi,
    this.isSign,
    this.issuer,
    this.avatarCommon,
    this.avatar,
  });

  factory ListTraLoiYKien.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ListTraLoiYKienFromJson(json);

  Map<String, dynamic> toJson() => _$ListTraLoiYKienToJson(this);

  TraLoiYKien toModel() => TraLoiYKien(
        id: id ?? '',
        taskXinYKienId: taskXinYKienId ?? '',
        nguoiTraLoiId: nguoiTraLoiId ?? '',
        hoTenNguoiTraLoi: hoTenNguoiTraLoi ?? '',
        donViNguoiTraLoi: donViNguoiTraLoi ?? '',
        noiDungTraLoi: noiDungTraLoi?.parseHtml() ?? '',
        thoiGianTraLoi: thoiGianTraLoi ?? '',
        thoiGianTraLoiStr: thoiGianTraLoiStr?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DATE_DD_MM_HM,
            ) ??
            '',
        isDaTraLoi: isDaTraLoi ?? false,
        lstFileDinhKemTraLoi:
            lstFileDinhKemTraLoi?.map((e) => e.toModel()).toList(),
        issuer: issuer ?? false,
        avatar: avatar ?? '',
      );
}
