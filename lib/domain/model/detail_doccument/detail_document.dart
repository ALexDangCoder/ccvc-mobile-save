import 'dart:core';

import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';

enum TrangThaiMission {
  THU_HOI,
  CHUA_THUC_HIEN,
  DA_HOAN_THANH,
  CHO_PHAN_XU_LY,
  DANG_THUC_HIEN,
  TRA_LAI
}

extension StatusMission on TrangThaiMission {
  String getName() {
    switch (this) {
      case TrangThaiMission.THU_HOI:
        return 'THU_HOI';
      case TrangThaiMission.CHUA_THUC_HIEN:
        return 'CHUA_THUC_HIEN';
      case TrangThaiMission.DA_HOAN_THANH:
        return 'DA_HOAN_THANH';
      case TrangThaiMission.CHO_PHAN_XU_LY:
        return 'CHO_PHAN_XU_LY';
      case TrangThaiMission.DANG_THUC_HIEN:
        return 'DANG_THUC_HIEN';
      case TrangThaiMission.TRA_LAI:
        return 'TRA_LAI';
    }
  }
}

class DetailDocumentModel {
  String? soVanBan = '';
  String? soDen = '';
  String? soPhu = '';
  String? noiGui = '';
  String? loaiVanBan = '';
  String? soKyHieu = '';
  String? ngayBH = '';
  String? ngayDen = '';
  String? doKhan = '';
  String? ngayHanXL = '';
  String? hanXL = '';
  String? nguoiKy = '';
  int? soBan = 0;
  int? soTrang = 0;
  String? phuongThucNhan = '';
  String? trichYeu = '';
  bool vanBanQlPL = false;
  bool hoiBao = false;
  bool daNhanBanGiay = false;

  DetailDocumentModel(
      {required this.soVanBan,
      required this.soDen,
      required this.trichYeu,
      required this.daNhanBanGiay,
      required this.doKhan,
      required this.hanXL,
      required this.hoiBao,
      required this.loaiVanBan,
      required this.ngayBH,
      required this.ngayDen,
      required this.ngayHanXL,
      required this.nguoiKy,
      required this.noiGui,
      required this.phuongThucNhan,
      required this.soBan,
      required this.soPhu,
      required this.soKyHieu,
      required this.soTrang,
      required this.vanBanQlPL});

  DetailDocumentModel.fromDetail();

  factory DetailDocumentModel.fromJson(Map<String, dynamic> json) {
    return DetailDocumentModel(
        soVanBan: json['CoTheCapNhatTinhHinhThucHien'],
        soDen: json['CoTheDonDoc'],
        soPhu: json['CoTheSua'],
        noiGui: json['CoTheThuHoi'],
        loaiVanBan: json['CoTheTraLai'],
        soKyHieu: json['CoTheXoa'],
        ngayBH: json['HanXuLy'].trim(),
        ngayDen: json['HanXuLyVPCP'].trim(),
        doKhan: json['Id'].trim(),
        ngayHanXL: json['NguoiGiao'].trim(),
        hanXL: json['NguoiTaoId'].trim(),
        nguoiKy: json['ProcessCode'].trim(),
        soBan: json['ProcessContent'].stripHtmlIfNeeded().trim(),
        soTrang: json['ProcessTypeId'].trim(),
        phuongThucNhan: json['ProcessTypeName'].trim(),
        trichYeu: json['StatusCode'].trim(),
        vanBanQlPL: json['StatusId'].trim(),
        hoiBao: json['StatusName'].trim(),
        daNhanBanGiay: json['TaskId'].trim());
  }

  List<DocumentDetailRow> toListRow() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow('Sổ văn bản', soVanBan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số đến', soDen, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số phụ', soPhu, TypeDocumentDetailRow.text),
      DocumentDetailRow('Nơi gửi', noiGui, TypeDocumentDetailRow.text),
      DocumentDetailRow('Loại văn bản', loaiVanBan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số ký hiệu', soKyHieu, TypeDocumentDetailRow.text),
      DocumentDetailRow('Ngày BH', ngayBH, TypeDocumentDetailRow.text),
      DocumentDetailRow('Ngày đến', ngayDen, TypeDocumentDetailRow.text),
      DocumentDetailRow('Độ khẩn', doKhan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Ngày hạn XL', ngayHanXL, TypeDocumentDetailRow.text),
      DocumentDetailRow('Hạn Xử lý', hanXL, TypeDocumentDetailRow.text),
      DocumentDetailRow('Người ký', nguoiKy, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số bản', soBan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số trang', soTrang, TypeDocumentDetailRow.text),
      DocumentDetailRow(
          'Phương thức nhận', phuongThucNhan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Trích yếu', trichYeu, TypeDocumentDetailRow.text),
    ];

    //   if (ProcessTypeName == 'Nhiệm vụ CP/VPCP') {
    //     list.insert(
    //       2,
    //       DocumentDetailRow('detail_mission_dvtheodoi', metadata.DonViTheoDoi,
    //           TypeDocumentDetailRow.text),
    //     );
    //     list.add(DocumentDetailRow(tr('detail_mission_hanxylyly_VPCP'),
    //         HanXuLyVPCP, TypeDocumentDetailRow.text));
    //     list.add(DocumentDetailRow(tr('detail_mission_nguoitheodoi'),
    //         metadata.NguoiTheoDoi, TypeDocumentDetailRow.text));
    //   } else {
    //     list.insert(
    //         2,
    //         DocumentDetailRow(tr('detail_mission_nguoiGiao'), NguoiGiao,
    //             TypeDocumentDetailRow.text));
    //   }
    //
    //   return list;
    // }

    // List<DocumentDetailRow> toListRowReturnMissionCp() {
    //   final List<DocumentDetailRow> list = [
    //     DocumentDetailRow(tr('detail_mission_noidung'), ProcessContent,
    //         TypeDocumentDetailRow.text),
    //     DocumentDetailRow(
    //         tr('detail_mission_sonv'), ProcessCode, TypeDocumentDetailRow.text),
    //     DocumentDetailRow(
    //         tr('detail_mission_so/kyhieu'), '', TypeDocumentDetailRow.text),
    //     DocumentDetailRow(
    //         tr('detail_mission_ngayvanban'), '', TypeDocumentDetailRow.text),
    //   ];
    //   return list;
    // }
    return list;
  }

  List<DocumentDetailRow> toListCheckBox() {
    final List<DocumentDetailRow> listCheckbox = [
      DocumentDetailRow(
          'Văn bản QPPL', vanBanQlPL, TypeDocumentDetailRow.checkbox),
      DocumentDetailRow(
          'Hồi báo văn bản', hoiBao, TypeDocumentDetailRow.checkbox),
      DocumentDetailRow(
          'Đã nhận bản giấy', daNhanBanGiay, TypeDocumentDetailRow.checkbox)
    ];

    return listCheckbox;
  }
}
