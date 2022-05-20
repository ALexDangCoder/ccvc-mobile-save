class TreeDonViDanhBA {
  bool bitDauMoiPAKN = false;
  bool bit_DonViBoPhan = false;
  bool bit_DonViSuNghiep = false;
  bool bit_DonViThuocBo = false;
  dynamic bit_KieuDonVi;
  dynamic bit_TrangThaiDonVi;
  int capDonVi = 0;
  String duongDan_ID_DonVi = '';
  String duongDan_ID_DonVi_Cha = '';
  String email = '';
  dynamic fax;
  bool hasDonViCon = false;
  String iDDonViCha = '';
  String iD_DonVi_Goc = '';
  String id = '';
  int level = 0;
  String maDonVi = '';
  dynamic maLienThong;
  dynamic soDienThoai;
  String tenDonVi = '';
  String tenDonViCha = '';
  String tenDonViGoc = '';
  int thuTu = 0;

  TreeDonViDanhBA.Emty();

  TreeDonViDanhBA({
    required this.bitDauMoiPAKN,
    required this.bit_DonViBoPhan,
    required this.bit_DonViSuNghiep,
    required this.bit_DonViThuocBo,
    this.bit_KieuDonVi,
    this.bit_TrangThaiDonVi,
    required this.capDonVi,
    required this.duongDan_ID_DonVi,
    required this.duongDan_ID_DonVi_Cha,
    required this.email,
    this.fax,
    required this.hasDonViCon,
    required this.iDDonViCha,
    required this.iD_DonVi_Goc,
    required this.id,
    required this.level,
    required this.maDonVi,
    this.maLienThong,
    this.soDienThoai,
    required this.tenDonVi,
    required this.tenDonViCha,
    required this.tenDonViGoc,
    required this.thuTu,
  });
}
