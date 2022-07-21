class TreeDonViDanhBA {
  bool bitDauMoiPAKN;
  bool bit_DonViBoPhan;
  bool bit_DonViSuNghiep;
  bool bit_DonViThuocBo;
  dynamic bit_KieuDonVi;
  dynamic bit_TrangThaiDonVi;
  int capDonVi;
  String duongDan_ID_DonVi;
  String duongDan_ID_DonVi_Cha;
  String email;
  dynamic fax;
  bool hasDonViCon;
  String iDDonViCha;
  String iD_DonVi_Goc;
  String id;
  int level;
  String maDonVi;
  dynamic maLienThong;
  dynamic soDienThoai;
  String tenDonVi;
  String tenDonViCha;
  String tenDonViGoc;
  int thuTu;


  TreeDonViDanhBA({
    this.bitDauMoiPAKN = false,
    this.bit_DonViBoPhan  = false,
    this.bit_DonViSuNghiep  = false,
    this.bit_DonViThuocBo  = false,
    this.bit_KieuDonVi,
    this.bit_TrangThaiDonVi,
    this.capDonVi = 0,
    this.duongDan_ID_DonVi ='',
    this.duongDan_ID_DonVi_Cha = '',
    this.email = '',
    this.fax,
    this.hasDonViCon = false,
    this.iDDonViCha = '',
    this.iD_DonVi_Goc = '',
    this.id = '',
    this.level = 0,
    this.maDonVi = '',
    this.maLienThong = '',
    this.soDienThoai,
    this.tenDonVi = '',
    this.tenDonViCha = '',
    this.tenDonViGoc = '',
    this.thuTu = 0,
  });
}
