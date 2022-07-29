import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

class Officer {
  String? id = '';
  String? donViId = '';
  String? tenDonVi = '';
  String? canBoId = '';
  String? hoTen = '';
  String? userName = '';
  String? userId = '';
  String? scheduleId = '';
  bool? isConfirm = false;
  String? parentId;
  int? status;
  String? confirmDate = '';
  String? taskContent = '';
  bool? isThamGia;

  Officer({
    this.id,
    this.donViId,
    this.tenDonVi,
    this.canBoId,
    this.hoTen,
    this.userName,
    this.userId,
    this.scheduleId,
    this.isConfirm,
    this.parentId,
    this.status = 0,
    this.confirmDate,
    this.taskContent,
    this.isThamGia,
  });

  String getTitle() {
    var result = '';
    if ((tenDonVi?.isNotEmpty ?? false) && (hoTen?.isEmpty ?? true)) {
      result = tenDonVi!;
    }
    if (hoTen?.isNotEmpty ?? false) {
      result = hoTen!;
    }
    return result;
  }

  String getUnit() {
    var result = '';
    if (tenDonVi?.isNotEmpty ?? false) {
      result = tenDonVi!;
    }
    return result;
  }

  DonViModel toDonViModel() => DonViModel(
        id: id ?? '',
        donViId: donViId ?? id ?? '',
        tenDonVi: tenDonVi ?? '',
        canBoId: canBoId ?? '',
        tenCanBo: hoTen ?? '',
        userId: userId ?? '',
        status: status ?? 0,
        noidung: taskContent ?? '',
        name: getTitle(),
      );

  DonViModel toUnitName() => DonViModel(
        id: id ?? '',
        donViId: donViId ?? id ?? '',
        tenDonVi: tenDonVi ?? '',
        canBoId: canBoId ?? '',
        tenCanBo: hoTen ?? '',
        userId: userId ?? '',
        status: status ?? 0,
        noidung: taskContent ?? '',
        name: getUnit(),
      );
}
