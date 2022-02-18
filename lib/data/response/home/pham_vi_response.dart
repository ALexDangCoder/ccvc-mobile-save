import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';

class PhamViResponse {
  String? userId;
  String? canBoDepartmentId;
  String? userCanBoDepartmentId;
  String? chucVuId;
  String? donViId;
  String? chucVu;
  String? donVi;
  bool? isDefault;
  bool? isCurrentActive;

  PhamViResponse(
      {this.userId,
      this.canBoDepartmentId,
      this.userCanBoDepartmentId,
      this.chucVuId,
      this.donViId,
      this.chucVu,
      this.donVi,
      this.isDefault,
      this.isCurrentActive});

  PhamViModel toDomain() =>
      PhamViModel(chucVu: chucVu ?? '', chucVuId: chucVuId ?? '');

  PhamViResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (json.isNotEmpty) {
      final result = data[0];
      userId = result['userId'];
      canBoDepartmentId = result['canBoDepartmentId'];
      userCanBoDepartmentId = result['userCanBoDepartmentId'];
      chucVuId = result['chucVuId'];
      donViId = result['donViId'];
      chucVu = result['chucVu'];
      donVi = result['donVi'];
      isDefault = result['isDefault'];
      isCurrentActive = result['isCurrentActive'];
    }
  }
}
