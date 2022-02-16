class HandingComment {
  String Id = '';
  String NoiDung = '';
  String ChucVu = '';
  String Avatar = '';
  String TenNhanVien = '';
  String NgayTao = '';
  List<String> list = [];

  HandingComment(
    this.Id,
    this.NoiDung,
    this.ChucVu,
    this.Avatar,
    this.TenNhanVien,
    this.NgayTao,
    this.list,
  );
}

HandingComment handingComment =
  HandingComment(
    '1',
    'Cần thực hiện sớm',
    'ChucVu',
    'https://th.bing.com/th/id/R.00d06daad137141c6e44f55cd67e6a84?rik=kSj6NrybAOc9cQ&pid=ImgRaw&r=0',
    'Hà kiều Anh',
    '2022-02-15T07:45:00',
    [],
  );

