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
}
