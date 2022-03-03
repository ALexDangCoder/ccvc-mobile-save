class HandingComment {
  String? id;

  String? noiDung;

  String? chucVu;

  String? avatar;
  String? tenNhanVien;
  String? ngayTao;

  List<String> listFile = [];

  HandingComment({
    this.id,
    this.noiDung,
    this.chucVu,
    this.avatar,
    this.tenNhanVien,
    this.ngayTao,
    required this.listFile,
  });
}

HandingComment handingComment = HandingComment(
  id: '1',
  noiDung: 'Cần thực hiện sớm',
  chucVu: 'ChucVu',
  avatar:
      'https://th.bing.com/th/id/R.00d06daad137141c6e44f55cd67e6a84?rik=kSj6NrybAOc9cQ&pid=ImgRaw&r=0',
  tenNhanVien: 'Hà kiều Anh',
  ngayTao: '2022-02-15T07:45:00',
  listFile: [],
);
