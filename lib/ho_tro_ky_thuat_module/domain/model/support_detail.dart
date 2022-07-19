class SupportDetail {
  String? id;
  String? moTaSuCo;
  String? tenThietBi;
  String? soDienThoai;
  String? diaChi;
  String? thoiGianYeuCau;
  String? nguoiYeuCau;
  String? chucVu;
  String? donVi;
  String? trangThaiXuLy;
  String? codeTrangThai;
  String? ketQuaXuLy;
  String? nguoiXuLy;
  String? nhanXet;
  String? buildingId;
  String? districId;
  String? ngayHoanThanh;
  String? room;
  List<String>? danhSachSuCo;

  SupportDetail({
    this.id,
    this.moTaSuCo,
    this.room,
    this.tenThietBi,
    this.soDienThoai,
    this.diaChi,
    this.thoiGianYeuCau,
    this.nguoiYeuCau,
    this.chucVu,
    this.donVi,
    this.trangThaiXuLy,
    this.ketQuaXuLy,
    this.nguoiXuLy,
    this.nhanXet,
    this.districId,
    this.buildingId,
    this.codeTrangThai,
    this.ngayHoanThanh,
    this.danhSachSuCo,
  });

  @override
  String toString() {
    return 'SupportDetail{id: $id, moTaSuCo: $moTaSuCo, tenThietBi: $tenThietBi, soDienThoai: $soDienThoai, diaChi: $diaChi, thoiGianYeuCau: $thoiGianYeuCau, nguoiYeuCau: $nguoiYeuCau, chucVu: $chucVu, donVi: $donVi, trangThaiXuLy: $trangThaiXuLy, codeTrangThai: $codeTrangThai, ketQuaXuLy: $ketQuaXuLy, nguoiXuLy: $nguoiXuLy, nhanXet: $nhanXet, ngayHoanThanh: $ngayHoanThanh, room: $room, danhSachSuCo: $danhSachSuCo}';
  }
}
