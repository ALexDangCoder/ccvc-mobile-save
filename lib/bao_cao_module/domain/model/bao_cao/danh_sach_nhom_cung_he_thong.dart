import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_nhom_cung_he_thong.g.dart';

class NhomCungHeThong {
  String? tenNhom;
  String? idNhom;
  List<ThanhVien>? listThanhVien;

  NhomCungHeThong({
    this.tenNhom,
    this.idNhom,
    this.listThanhVien,
  });
}

class DonViCungHeThong {
  String? tenDonVi;
  String? idDonVi;
  List<ThanhVien>? listThanhVien;

  DonViCungHeThong({
    this.tenDonVi,
    this.idDonVi,
    this.listThanhVien,
  });
}

class ThanhVien {
  String? tenThanhVien;
  String? idThanhVien;
  String? chucVu;

  ThanhVien({
    this.tenThanhVien,
    this.idThanhVien,
    this.chucVu,
  });
}

@JsonSerializable()
class ShareReport {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'groupId')
  String? groupId;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'expiredDate')
  String? expiredDate;
  @JsonKey(name: 'newUser')
  Map<String, String>? newUser;

  ShareReport({
    this.userId,
    this.groupId,
    this.type,
    this.expiredDate,
    this.newUser,
  });

  Map<String, dynamic> toJson() => _$ShareReportToJson(this);
}
