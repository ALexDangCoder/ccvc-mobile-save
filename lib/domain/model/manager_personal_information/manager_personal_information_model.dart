import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

enum Status { OFFLINE, ONLINME }

extension CheckStatus on Status {
  String getText() {
    switch (this) {
      case Status.OFFLINE:
        return S.current.hoat_dong;
      case Status.ONLINME:
        return S.current.k_hoat_dong;
    }
  }
}

class ManagerPersonalInformationModel {
  String? id;
  String? maCanBo;
  String? hoTen;
  String? phoneDiDong;
  String? phoneCoQuan;
  String? phoneNhaRieng;
  String? email;
  bool? gioiTinh;
  String? ngaySinh;
  String? iDDonViHoatDong;
  String? cmtnd;
  String? anhDaiDienFilePath;
  String? anhChuKyFilePath;
  String? anhChuKyNhayFilePath;
  String? thoiGianCapNhat;
  String? chucVu;
  String? donVi;

  //bool? bitThuTruongDonVi;
  // bool? bitDauMoiPAKN;
  String? diaChi;
  int? thuTu;
  int? iThuTu;
  String? tinh;
  String? huyen;
  String? xa;
  bool? isDefault;
  int? trangThai;
  String? ungDung;
  Status status = Status.OFFLINE;

  ManagerPersonalInformationModel({
    this.id,
    this.maCanBo,
    this.hoTen,
    this.phoneDiDong,
    this.phoneCoQuan,
    this.phoneNhaRieng,
    this.email,
    this.gioiTinh,
    this.ngaySinh,
    this.iDDonViHoatDong,
    this.cmtnd,
    this.anhDaiDienFilePath,
    this.anhChuKyFilePath,
    this.anhChuKyNhayFilePath,
    this.thoiGianCapNhat,
    this.chucVu,
    this.donVi,
    //  this.bitThuTruongDonVi,
    //  this.bitDauMoiPAKN,
    this.diaChi,
    this.thuTu,
    this.iThuTu,
    this.tinh,
    this.huyen,
    this.xa,
    this.isDefault,
    this.trangThai,
    this.ungDung,
  }) {
    if (trangThai == 1) {
      status = Status.OFFLINE;
    } else {
      status = Status.ONLINME;
    }
  } // List<UserAccounts>? userAccounts;

  static ManagerPersonalInformationModel fakeData =
      ManagerPersonalInformationModel(
    id: 'a',
    maCanBo: '123',
    hoTen: 'luc',
    phoneDiDong: '01234567689',
    phoneCoQuan: '0123456789',
    phoneNhaRieng: '01234346567',
    email: 'luc@gmail.com',
    gioiTinh: false,
    ngaySinh: '2001-04-01',
    iDDonViHoatDong: 'a',
    cmtnd: '1234567890',
    anhDaiDienFilePath: 'a',
    anhChuKyFilePath: 'a',
    anhChuKyNhayFilePath: 'a',
    thoiGianCapNhat: 'a',
    chucVu: 'bi thu',
    donVi: 'lanh dao',
    diaChi: 'lam loi',
    thuTu: 2,
    iThuTu: 3,
    tinh: 'a',
    huyen: 'a',
    xa: 'a',
    isDefault: false,
    trangThai: 1,
    ungDung: 'a',
  );

  List<ManagerPersonalInformationRow> toListMobile() {
    final List<ManagerPersonalInformationRow> list = [
      ManagerPersonalInformationRow(S.current.ho_va_ten, hoTen, TypeRow.text),
      ManagerPersonalInformationRow(S.current.ma_can_bo, maCanBo, TypeRow.text),
      ManagerPersonalInformationRow(S.current.thu_tus, thuTu, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.ngay_sinh,
        ngaySinh,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.cmnd, cmtnd, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.gioi_tinh,
        gioiTinh,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.email, email, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.sdt_co_quan,
        phoneCoQuan,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(
        S.current.sdt_lien_he,
        phoneDiDong,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(
        S.current.tinh_thanh,
        tinh,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.quan_huyen, huyen, TypeRow.text),
      ManagerPersonalInformationRow(S.current.phuong_xa, xa, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.dia_chi_lien_he,
        diaChi,
        TypeRow.text,
      ),
    ];
    return list;
  }

  List<ManagerPersonalInformationRow> toListRowDetailJob() {
    final List<ManagerPersonalInformationRow> list = [
      ManagerPersonalInformationRow(S.current.ho_va_ten, hoTen, TypeRow.text),
      ManagerPersonalInformationRow(S.current.ma_can_bo, maCanBo, TypeRow.text),
      ManagerPersonalInformationRow(S.current.thu_tus, thuTu, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.ngay_sinh,
        ngaySinh,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.cmnd, cmtnd, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.gioi_tinh,
        gioiTinh ?? false ? S.current.Nam : S.current.Nu,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.email, email, TypeRow.text),
    ];
    return list;
  }

  List<ManagerPersonalInformationRow> toListAdress() {
    final List<ManagerPersonalInformationRow> list = [
      ManagerPersonalInformationRow(
        S.current.sdt_co_quan,
        phoneCoQuan,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(
        S.current.sdt_lien_he,
        phoneDiDong,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(
        S.current.tinh_thanh,
        tinh,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.quan_huyen, huyen, TypeRow.text),
      ManagerPersonalInformationRow(S.current.phuong_xa, xa, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.dia_chi_lien_he,
        diaChi,
        TypeRow.text,
      ),
    ];

    return list;
  }

  List<ManagerPersonalInformationRow> toListDonVi() {
    final List<ManagerPersonalInformationRow> list = [
      ManagerPersonalInformationRow(S.current.stt, thuTu, TypeRow.text),
      ManagerPersonalInformationRow(S.current.don_vi, donVi, TypeRow.text),
      ManagerPersonalInformationRow(S.current.chuc_vu, chucVu, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.mac_dinh,
        isDefault,
        TypeRow.checkbox,
      ),
    ];
    if (trangThai == 1) {
      list.insert(
        3,
        ManagerPersonalInformationRow(
          S.current.trang_thai,
          S.current.hoat_dong,
          TypeRow.status,
        ),
      );
    } else {
      list.add(
        ManagerPersonalInformationRow(
          S.current.trang_thai,
          S.current.k_hoat_dong,
          TypeRow.status,
        ),
      );
    }
    return list;
  }

  List<ManagerPersonalInformationRow> toListUngDung() {
    final List<ManagerPersonalInformationRow> list = [
      ManagerPersonalInformationRow(S.current.stt, thuTu, TypeRow.text),
      ManagerPersonalInformationRow(
        S.current.ten_dang_nhap,
        hoTen,
        TypeRow.text,
      ),
      ManagerPersonalInformationRow(S.current.ung_dung, ungDung, TypeRow.list),
    ];
    if (trangThai == 1) {
      list.add(
        ManagerPersonalInformationRow(
          S.current.trang_thai,
          S.current.hoat_dong,
          TypeRow.status,
        ),
      );
    } else {
      list.add(
        ManagerPersonalInformationRow(
          S.current.trang_thai,
          S.current.k_hoat_dong,
          TypeRow.status,
        ),
      );
    }
    return list;
  }

  Map<String, dynamic> getInfoToMap() {
    return {
      S.current.id: id ?? '',
      S.current.ho_va_ten: hoTen ?? '',
      S.current.ma_can_bo: maCanBo ?? '',
      S.current.thu_tus: thuTu.toString(),
      S.current.ngay_sinh:
          DateTime.parse(ngaySinh ?? '').toStringWithListFormat,
      S.current.cmnd: cmtnd ?? '',
      S.current.gioi_tinh: gioiTinh ?? false ? S.current.Nam : S.current.Nu,
      S.current.email: email ?? '',
      S.current.sdt_co_quan: phoneCoQuan ?? '',
      S.current.sdt_lien_he: phoneDiDong ?? '',
      S.current.tinh_thanh:
          DateTime.parse(ngaySinh ?? '').toStringWithListFormat,
      S.current.quan_huyen:
          DateTime.parse(ngaySinh ?? '').toStringWithListFormat,
      S.current.phuong_xa:
          DateTime.parse(ngaySinh ?? '').toStringWithListFormat,
      S.current.dia_chi_lien_he: diaChi ?? '',
    };
  }
}
