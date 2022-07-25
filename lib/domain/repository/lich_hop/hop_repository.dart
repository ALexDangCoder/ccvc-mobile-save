import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/cap_nhat_trang_thai_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/cu_can_bo_di_thay_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_thong_ke_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_theo_doi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/phan_cong_thu_ky_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/sua_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_moi_vote_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/add_file_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/them_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/bieu_quyet_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danhSachCanBoBieuQuyetModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/duyet_lich_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/file_upload_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/gui_mail_ket_luat_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_status_room_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_dang_theo_doi.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_theo_doi.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/responseModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/select_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/don_vi_con_phong_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/them_y_kiem_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/co_cau_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/thong_ke_linh_vuc.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';

mixin HopRepository {
  Future<Result<ChuongTrinhHopModel>> getDanhSachCuocHopTPTH(String id);

  Future<Result<List<NguoiDangTheoDoiModel>>> getNguoiDangTheoDoi(
    String type,
    String DateFrom,
    String DateTo,
  );

  Future<Result<NguoiTheoDoiModel>> getNguoiTheoDoi(NguoiTheoDoiRequest body);

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

  Future<Result<DanhSachLichHopModel>> postDanhSachThongKe(
    DanhSachThongKeRequest body,
  );

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
    String id,
  );

  Future<Result<List<NguoiChutriModel>>> getDanhSachThuHoi(
    String id,
    bool except,
  );

  Future<Result<List<String>>> postEventCalendar(EventCalendarRequest request);

  Future<Result<List<AddFileModel>>> postFileTaoLichHop(
    int? entityType,
    String? entityName,
    String? entityId,
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
    String canBoId,
    String donViId,
    int vaiTroThamGia,
    String thoiGianBatDau,
    String thoiGianKetThuc,
    String noiDung,
    String tieuDe,
    String hoTen,
    bool IsMultipe,
    List<File> file,
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
    String phienHop,
  );

  Future<Result<List<PhatBieuModel>>> getDanhSachPhatBieuLichHopNoStatus(
    String lichHopId,
  );

  Future<Result<List<DanhSachBietQuyetModel>>> getDanhSachBieuQuyetLichHop(
    String idLichHop,
    String canBoId,
    String idPhienHop,
  );

  Future<Result<ChuongTrinhHopModel>> getDanhSachCanBoTPTG(String id);

  Future<Result<MessageModel>> suaKetLuan(
      String scheduleId,
      String content,
      String reportStatusId,
      String reportTemplateId,
      List<File>? files,
      List<String> fileDelete);

  Future<Result<GuiMailKetLuatHopModel>> sendMailKetLuanHop(String id);

  Future<Result<List<CanBoModel>>> postMoiHop(
    String lichHopId,
    bool IsMultipe,
    bool isSendMail,
    List<MoiHopRequest> body,
  );

  Future<Result<ThongTinPhongHopModel>> getListThongTinPhongHop(
      String idLichHop);

  Future<Result<List<ThietBiPhongHopModel>>> getListThietBiPhongHop(
      String lichHopId);

  Future<Result<ChiTietLichHopModel>> taoLichHop(
    TaoLichHopRequest taoLichHopRequest,
  );

  Future<Result<XemKetLuanHopModel>> getXemKetLuanHop(String id);

  Future<Result<List<YkienCuocHopModel>>> getDanhSachYKien(
    String id,
    String phienHopId,
  );

  Future<Result<List<StatusKetLuanHopModel>>> getListStatusKetLuanHop();

  Future<Result<MessageModel>> deleteKetLuanHop(String id);

  Future<Result<bool>> deleteChiTietLichHop(
    String id,
    bool isMulti,
  );

  Future<Result<MessageModel>> huyChiTietLichHop(
    String scheduleId,
    int statusId,
    bool isMulti,
  );

  Future<Result<ChiTietLichHopModel>> postSuaLichHop(
    TaoLichHopRequest TaoLichHopRequest,
  );

  Future<Result<List<CalendarMeetingModel>>> getNhiemVuCHiTietHop(
      NhiemVuChiTietHopRequest nhiemVuChiTietHopRequest);

  Future<Result<List<DanhSachLoaiNhiemVuLichHopModel>>>
      getDanhSachLoaiNhiemVu();

  Future<Result<List<CalendarMeetingModel>>> postThemNhiemVu(
    ThemNhiemVuRequest themNhiemVuRequest,
  );

  Future<Result<ThemYKienModel>> suaChuongTrinhHop(
    String id,
    String lichHopId,
    String tieuDe,
    String thoiGianBatDau,
    String thoiGianKetThuc,
    String canBoId,
    String donViId,
    String noiDung,
    String hoTen,
    bool isMultipe,
    List<File> file,
    List<String> filesDelete,
  );

  Future<Result<ThemYKienModel>> xoaChuongTrinhHop(
    String id,
  );

  Future<Result<List<DanhSachNguoiThamGiaModel>>> getDanhSachNTGChuongTrinhHop(
    String id,
  );

  Future<Result<ResponseModel>> postPhanCongThuKy(
    PhanCongThuKyRequest phanCongThuKyRequest,
  );

  Future<Result<ResponseModel>> postTaoPhatBieu(
    TaoBieuQuyetRequest taoBieuQuyetRequest,
  );

  Future<Result<ResponseModel>> postDuyetOrHuyDuyetPhatBieu(
    List<String> ids,
    String lichHopId,
    int type,
  );

  Future<Result<bool>> postDiemDanh(
    List<String> data,
  );

  Future<Result<ResponseModel>> postThuHoiHop(
    bool isMulti,
    List<ThuHoiHopRequest> thuHoiHopRequest,
  );

  Future<Result<bool>> postHuyDiemDanh(
    String data,
  );

  Future<Result<List<DonViConPhong>>> getDonViConPhongHop(
    String id,
  );

  Future<Result<List<PhongHopModel>>> getDanhSachPhongHop(
    String id,
    String from,
    String to,
    bool isTTDH,
  );

  Future<Result<bool>> huyOrDuyetPhongHop(
    String hopId,
    bool isDuyet,
    String lyDo,
  );

  Future<Result<bool>> thayDoiPhongHop(
    bool bitTTDH,
    String lichHopId,
    String phongHopId,
    String tenPhong,
  );

  Future<Result<bool>> duyetOrHuyDuyetThietBi(
    bool isDuyet,
    String lichHopId,
    String lyDo,
    String thietBiId,
  );

  Future<Result<bool>> duyetOrHuyDuyetKyThuat(
    String hopId,
    bool isDuyet,
    String lyDo,
  );

  Future<Result<bool>> chonPhongHopMetting(
    TaoLichHopRequest taoLichHopRequest,
  );

  Future<Result<String>> checkLichHopTrung(
    String? scheduleId,
    String donViId,
    String userId,
    String timeFrom,
    String timeTo,
    String dateFrom,
    String dateTo,
  );

  Future<Result<List<CanBoModel>>> moiHop(
    String lichHopId,
    bool IsMultipe,
    bool isSendMail,
    List<MoiThamGiaHopRequest> body,
  );

  Future<Result<bool>> themPhienHop(
    String lichHopId,
    List<TaoPhienHopRequest> phienHops,
  );

  Future<Result<DuyetLichModel>> huyAndDuyetLichHop(
    String lichHopId,
    bool isDuyet,
    String lyDo,
  );

  Future<Result<bool>> cuCanBoDiThay(CuCanBoDiThayRequest cuCanBoDiThayRequest);

  Future<Result<bool>> xacNhanThamGiaHop(
    String lichHopId,
    bool isThamGia,
  );

  Future<Result<bool>> xacNhanHoacHuyKetLuanHop(
    String lichHopId,
    bool isDuyet,
    String noiDung,
  );

  Future<Result<bool>> createKetLuanHop(
    String scheduleId,
    String reportStatusId,
    String reportTemplateId,
    String content,
    List<File> files,
  );

  Future<Result<bool>> guiDuyetKetLuanHop(
    String meetId,
  );

  Future<Result<bool>> thuHoiKetLuanHop(
    String meetId,
  );

  Future<Result<bool>> deleteFileHop(
    String id,
  );

  Future<Result<ListStatusModel>> listStatusRoom();

  Future<Result<bool>> capNhatTrangThai(
    CapNhatTrangThaiRequest capNhatTrangThaiRequest,
  );

  Future<Result<bool>> themMoiVote(
    ThemMoiVoteRequest themMoiVoteRequest,
  );

  Future<Result<DanhSachLichHopModel>> getLichCanKLCH(
    DanhSachLichHopRequest request,
  );

  Future<Result<bool>> xoaBieuQuyet(
    String bieuQuyetId,
    String canboId,
  );

  Future<Result<ChiTietBieuQuyetModel>> chiTietBieuQuyet(
    String id,
  );

  Future<Result<bool>> suaBieuQuyet(
    SuaBieuQuyetRequest suaBieuQuyetRequest,
  );

  Future<Result<List<FileUploadModel>>> uploadMultiFile(
      {required List<File> path});

  Future<Result<DanhSachCanBoBieuQuyetModel>> danhSachCanBoBieuQuyet(
    String luaChonId,
    String lichHopId,
    String bieuQuyetId,
  );

  Future<Result<List<ThongKeLinhVucModel>>> getLichHopTheoLinhVuc(
    String dateFrom,
    String dateTo,
  );
}
