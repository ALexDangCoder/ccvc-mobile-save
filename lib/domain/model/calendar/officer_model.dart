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
  int? status;
  String? confirmDate = '';
  String? taskContent = '';

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
    this.status = 0,
    this.confirmDate,
    this.taskContent,
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

  DonViModel toDonViModel() => DonViModel(
        id: id ?? '',
        donViId: donViId ?? '',
        tenDonVi: tenDonVi ?? '',
        canBoId: canBoId ?? '',
        name: hoTen ?? '',
        userId: userId ?? '',
        status: status ?? 0,
        noidung: taskContent ?? '',
      );
}
