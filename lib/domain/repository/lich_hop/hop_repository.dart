import 'package:ccvc_mobile/data/request/lich_hop/add_file_tao_lich_hop_request.dart';
import 'dart:io';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/add_file_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/bieu_quyet_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/gui_mail_ket_luat_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/select_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/co_cau_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/them_y_kiem_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';

mixin HopRepository {
  Future<Result<List<DashBoardThongKeModel>>> getDashBoardThongKe(
    String dateFrom,
    String dateTo,
  );

  Future<Result<List<TiLeThamGiaModel>>> postTiLeThamGia(
    String dateFrom,
    String dateTo,
  );

  Future<Result<List<ToChucBoiDonViModel>>> postToChucBoiDonVi(
    String dateFrom,
    String dateTo,
  );

  Future<Result<List<CoCauLichHopModel>>> postCoCauLichHop(
    String dateFrom,
    String dateTo,
  );

  Future<Result<List<StatisticByMonthModel>>> postStatisticByMonth(
    String dateFrom,
    String dateTo,
  );

  Future<Result<DashBoardLichHopModel>> getDashBoardLichHop(
    String dateStart,
    String dateTo,
  );

  Future<Result<List<MenuModel>>> getDataMenu(String startTime, String endTime);

  Future<Result<DanhSachLichHopModel>> postDanhSachLichHop(
    DanhSachLichHopRequest body,
  );

  Future<Result<List<LoaiSelectModel>>> getLoaiHop(
    CatogoryListRequest catogoryListRequest,
  );

  Future<Result<List<LoaiSelectModel>>> getLinhVuc(
    CatogoryListRequest catogoryListRequest,
  );

  Future<Result<List<NguoiChutriModel>>> getNguoiChuTri(
    NguoiChuTriRequest nguoiChuTriRequest,
  );

  Future<Result<List<NguoiChutriModel>>> getDanhSachNguoiChuTriPhienHop(
      String id);

  Future<Result<List<String>>> postEventCalendar(EventCalendarRequest request);

  Future<Result<AddFileModel>> postFileTaoLichHop(
    int entityType,
    String entityName,
    String entityId,
    bool isMutil,
    List<File> files,
  );

  Future<Result<List<ListPhienHopModel>>> getDanhSachPhienHop(
    String id,
  );

  Future<Result<ChiTietLichHopModel>> getChiTietLichHop(String id);

  Future<Result<ThemYKiemModel>> themYKienHop(
    ThemYKienRequest themYKienRequest,
  );

  Future<Result<ChuongTrinhHopModel>> getChuongTrinhHop(
    String id,
  );

  Future<Result<SoLuongPhatBieuModel>> getSoLuongPhatBieu(String id);

  Future<Result<TongPhienHopModel>> getTongPhienHop(
    String id,
  );

  Future<Result<SelectPhienHopModel>> slectPhienHop(
    String id,
  );

  Future<Result<List<TaoPhienHopModel>>> getThemPhienHop(
    String lichHopId,
    TaoPhienHopRepuest taoPhienHopRepuest,
  );

  Future<Result<BieuQuyetModel>> themBieuQuyet(
    BieuQuyetRequest bieuQuyetRequest,
  );

  Future<Result<ChonBienBanCuocHopModel>> postChonMauBienBanHop(
    ChonBienBanHopRequest chonBienBanHopRequest,
  );

  Future<Result<List<PhatBieuModel>>> getDanhSachPhatBieuLichHop(
    int status,
    String lichHopId,
  );

  Future<Result<List<PhatBieuModel>>> getDanhSachPhatBieuLichHopNoStatus(
    String lichHopId,
  );

  Future<Result<List<PhatBieuModel>>> getDanhSachBieuQuyetLichHop(String id);

  Future<Result<ChuongTrinhHopModel>> getDanhSachCanBoTPTG(String id);

  Future<Result<MessageModel>> suaKetLuan(
    String scheduleId,
    String content,
    String reportStatusId,
    String reportTemplateId,
    List<File>? files,
  );

  Future<Result<GuiMailKetLuatHopModel>> sendMailKetLuanHop(String id);

  Future<Result<List<MoiHopModel>>> postMoiHop(
    String lichHopId,
    bool IsMultipe,
    bool isSendMail,
    List<MoiHopRequest> body,
  );

  Future<Result<ThongTinPhongHopModel?>> getListThongTinPhongHop(
      String idLichHop);

  Future<Result<List<ThietBiPhongHopModel>>> getListThietBiPhongHop(
      String lichHopId);

  Future<Result<ChiTietLichHopModel>> taoLichHop(
      TaoLichHopRequest taoLichHopRequest);

  Future<Result<XemKetLuanHopModel>> getXemKetLuanHop(String id);

  Future<Result<List<YKienModel>>> getDanhSachYKien(String id);

  Future<Result<List<StatusKetLuanHopModel>>> getListStatusKetLuanHop();

  Future<Result<MessageModel>> deleteKetLuanHop(String id);

  Future<Result<MessageModel>> deleteChiTietLichHop(String id);

  Future<Result<MessageModel>> huyChiTietLichHop(
    String scheduleId,
    int statusId,
    bool isMulti,
  );

  Future<Result<ChiTietLichHopModel>> postSuaLichHop(
    TaoLichHopRequest TaoLichHopRequest,
  );
}
