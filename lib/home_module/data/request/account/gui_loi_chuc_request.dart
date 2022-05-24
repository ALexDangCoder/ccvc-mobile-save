class GuiLoiChucRequest {
  String? nguoiGuiId;
  String? tenNguoiGui;
  String? chucVu;
  String? donVi;
  String? nguoiNhanId;
  String? tenNguoiNhan;
  String? emailNguoiNhan;
  String? content;
  String? cardId;
  bool? isDeleted;

  GuiLoiChucRequest(
      {this.nguoiGuiId,
        this.tenNguoiGui,
        this.chucVu,
        this.donVi,
        this.nguoiNhanId,
        this.tenNguoiNhan,
        this.emailNguoiNhan,
        this.content,
        this.cardId,
        this.isDeleted});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nguoiGuiId'] = nguoiGuiId;
    data['tenNguoiGui'] = tenNguoiGui;
    data['chucVu'] = chucVu;
    data['donVi'] = donVi;
    data['nguoiNhanId'] = nguoiNhanId;
    data['tenNguoiNhan'] = tenNguoiNhan;
    data['emailNguoiNhan'] = emailNguoiNhan;
    data['content'] = content;
    data['cardId'] = cardId;
    data['isDeleted'] = isDeleted;
    return data;
  }
}