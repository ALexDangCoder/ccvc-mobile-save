import 'package:hive/hive.dart';

part 'user_infomation.g.dart';

@HiveType(typeId: 1)
class UserInformation {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? canBoDepartmentId;
  @HiveField(2)
  String? hoTen;
  @HiveField(3)
  String? anhDaiDienFilePath;
  @HiveField(4)
  String? chucVu;
  @HiveField(5)
  String? donVi;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? userName;
  @HiveField(8)
  String? userCanBoDepartmentId;
  @HiveField(9)
  DonViGoc? donViGoc;
  @HiveField(10)
  DonViTrucThuoc? donViTrucThuoc;
  @HiveField(11)
  bool? gioiTinh;
  @HiveField(12)
  String? ngaySinh;
  @HiveField(13)
  String? soDienThoai;

  UserInformation(
      {this.id,
      this.canBoDepartmentId,
      this.hoTen,
      this.anhDaiDienFilePath,
      this.chucVu,
      this.donVi,
      this.email,
      this.userName,
      this.userCanBoDepartmentId,
      this.donViGoc,
      this.donViTrucThuoc,
      this.gioiTinh,
      this.ngaySinh,
      this.soDienThoai});
}

@HiveType(typeId: 2)
class DonViGoc {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? tenDonVi;
  @HiveField(2)
  String? chucVuId;
  @HiveField(3)
  String? chucVu;

  DonViGoc({this.id, this.tenDonVi, this.chucVuId, this.chucVu});
}

@HiveType(typeId: 3)
class DonViTrucThuoc {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? tenDonVi;
  @HiveField(2)
  String? chucVuId;
  @HiveField(3)
  String? chucVu;
  @HiveField(4)
  String? maChucVu;

  DonViTrucThuoc({
    this.id,
    this.tenDonVi,
    this.chucVuId,
    this.chucVu,
    this.maChucVu,
  });
}
