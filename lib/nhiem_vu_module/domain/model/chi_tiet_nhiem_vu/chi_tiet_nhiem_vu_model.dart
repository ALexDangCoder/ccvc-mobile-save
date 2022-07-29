import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_header.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class ChiTietNhiemVuModel {
  String? id;
  String? processTypeId;
  String? statusCode;
  String? statusName;
  String? statusId;
  String? taskId;
  String? processTypeName;
  String? processTypeCode;
  String? processCode;
  String? nguoiTaoId;
  String? hanXuLy;
  String? nguoiGiao;
  String? hanXuLyVPCP;
  String? processContent;
  Metadata? metadata;
  bool? coTheSua;
  bool? coTheXoa;
  bool? coTheDonDoc;
  bool? coTheThuHoi;
  bool? coTheTraLai;
  bool? coTheCapNhatTinhHinhThucHien;
  bool? coThePhanXuLy;

  ChiTietNhiemVuModel({
    this.id,
    this.processTypeId,
    this.statusCode,
    this.statusName,
    this.statusId,
    this.taskId,
    this.processTypeName,
    this.processTypeCode,
    this.processCode,
    this.nguoiTaoId,
    this.hanXuLy,
    this.nguoiGiao,
    this.hanXuLyVPCP,
    this.processContent,
    this.metadata,
    this.coTheSua,
    this.coTheXoa,
    this.coTheDonDoc,
    this.coTheThuHoi,
    this.coTheTraLai,
    this.coTheCapNhatTinhHinhThucHien,
    this.coThePhanXuLy,
  });

  List<ChiTietHeaderRow> toListRow() {
    final List<ChiTietHeaderRow> list = [
      ChiTietHeaderRow(
        key: S.current.loai_nhiem_vu,
        value: processTypeName ?? '',
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.so_nhiem_vu,
        value: processCode ?? '',
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.tinh_hinh_thuc_hien,
        value: statusCode ?? '',
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.han_xu_ly,
        value: hanXuLy ?? '',
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.nguoi_giao,
        value: nguoiGiao ?? '',
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.just_noi_dung,
        value: processContent?.parseHtml() ?? '',
        isNote: false,
      ),
    ];

    return list;
  }
}

class Metadata {
  String? donViTaoId;
  String? daGuiVPCP;
  String? donViTheoDoi;
  String? nguoiGiao;
  String? nguoiGiaoId;
  String? nguoiTheoDoi;

  Metadata({
    this.donViTaoId,
    this.daGuiVPCP,
    this.donViTheoDoi,
    this.nguoiGiao,
    this.nguoiGiaoId,
    this.nguoiTheoDoi,
  });
}
