class ApiConstants {
  static const LOGIN = '/api/auth/login';
  static const int DEFAULT_PAGE_SIZE = 10;
  static const int DEFAULT_PAGE_SIZE_QLNV = 5;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const GET_FUNCTION_OF_CURRENT =
      '/api/Function/get-tree-function-of-currentuser';
  static const String POST_DANH_SACH_LICH_HOP =
      '/vpdt/api/MeetingSchedule/calendar-list';
  static const String POST_DANH_SACH_THONG_KE =
      '/vpdt/api/Statistic/calendar-list-by-statistic';
  static const String GET_DASH_BOARD_LH =
      '/vpdt/api/MeetingSchedule/count-in-dashboard';
  static const String GET_LIST_TOKEN = '/market/coin-list';
  static const String GET_PRICE_TOKEN_BY_SYMBOL = '/market/coin-price/';
  static const String GET_PHAM_VI = '/common/auth/list-pham-vi';
  static const String CHUYEN_PHAM_VI = '/common/auth/chuyen-pham-vi';
  static const String GET_LUNAR_DATE = '/api/LunarDate/getLunarDate';
  static const String GET_TINH_HUONG_KHAN_CAP =
      '/api/DashBoardHome/tinh-huong-khan-cap?';
  static const String GET_DASHBOARD_WIDGET =
      '/api/Widget/get-dashboard-widget-config?';
  static const String GET_DASHBOARD_VB_DEN =
      '/qlvb/api/danh-muc/dashboard-van-ban-den';
  static const String GET_VB_DI_SO_LUONG = '/qlvb/api/van-ban-di/so-luong?';
  static const String GET_BIRTHDAY =
      '/appdieuhanh/api/CmsCard/lay-danhsach-chucmung';
  static const String GET_INFO = '/api/CanBo';
  static const String GET_TINH_HUYEN_XA = '/api/DanhMuc/tinh-thanh';
  static const String GET_TINH_HUYEN_XA_CHILD = '/api/DanhMuc/tinh-thanh';
  static const String LIST_LICH_LV = '/vpdt/api/Schedules/danh-sach-lich';
  static const String DANH_SACH_CONG_VIEC =
      '/qlvb/api/qlnv/cong-viec/danhsachcongvieccanhan';
  static const DASH_BOARD_VBDEN = '/qlvb/api/danh-muc/dashboard-van-ban-den';
  static const DASH_BOARD_VBDi = '/qlvb/api/van-ban-di/so-luong';
  static const DANH_SACH_VB_DEN = '/qlvb/api/vanban/getdanhsachvanban';
  static const DANH_SACH_VB_DI = '/qlvb/api/van-ban-di/search';
  static const String GET_DANH_SACH_VAN_BAN =
      '/qlvb/api/vanban/getdanhsachvanban';
  static const String GET_DANH_SACH_VAN_BAN_SEARCH =
      '/qlvb/api/van-ban-di/search';
  static const String TONG_HOP_NHIEM_VU =
      '/qlvb/api/qlnv/nhiem-vu/get-tong-hop-nhiem-vu?';
  static const String NHIEM_VU_GET_ALL = '/qlvb/api/qlnv/nhiem-vu/get-all';
  static const TINH_HINH_XU_LY_TRANG_CHU =
      '/pakn/api/IocApi/thong-ke-tinh-hinh-xu-ly-trang-chu?';
  static const DANH_SACH_PAKN = '/pakn/api/IocApi/danh-sach-pakn?';
  static const NGUOI_DANG_THEO_DOI =
      '/vpdt/api/UserFollow/danh-sach-nguoi-theo-doi';
  static const TODO_LIST_CURRENT_USER = '/api/TodoList/get-current-user';
  static const TODO_LIST_UPDATE = '/api/TodoList/update';
  static const TODO_LIST_CREATE = '/api/TodoList/create';
  static const SEARCH_NEW = '/api/NewsNetViews/search_news?';
  static const DANH_SACH_LICH_LAM_VIEC = '/vpdt/api/Schedules/danh-sach-lich';
  static const CANLENDAR_LIST_MEETING =
      '/vpdt/api/MeetingSchedule/calendar-list';
  static const SU_KIEN_TRONG_NGAY = '/api/DashBoardHome/su-kien-trong-ngay?';
  static const SINH_NHAT_DASHBOARD = '/api/DashBoardHome/sinh-nhat?';
  static const EDIT_PERSON_INFORMATION = '/api/CanBo/add-or-update';
  static const UPLOAD_FILE = '/api/CanBo/upload';
  static const UPLOAD_FILE_COMMON = '/qlvb/api/Common/UploadMultiFile';
  static const UPDATE_Y_KIEN_XU_LY =
      '/qlvb/api/qlvb/van-ban-den/y-kien-xu-ly/update-y-kien';
  static const CHO_Y_KIEN = '/qlvb/api/xin-y-kien/cho-y-kien';
  static const TRA_LOI_Y_KIEN_VAN_BAN_DEN =
      '/qlvb/api/qlvb/van-ban-den/y-kien-xu-ly/tra-loi-xin-y-kien';

  static const LICH_LAM_VIEC_DASHBOARD =
      '/vpdt/api/Schedules/count-in-dashboard';
  static const LICH_LAM_VIEC_DASHBOARD_RIGHT =
      '/vpdt/api/Schedules/dashboard-schedule';
  static const GET_TREE_DON_VI = '/common/DonVi/get-tree';
  static const SEARCH_CAN_BO = '/vpdt/api/CanBo/search';
  static const OFFICERS_JOIN = '/vpdt/api/CanBoThamGia/can-bo-tham-gia-tree';
  static const CONFIRM_OFFICER = '/vpdt/api/CanBoThamGia/confirm-lich';
  static const OFFICER_JOIN = '/vpdt/api/CanBo/search';
  static const CATEGORY_LIST = '/vpdt/api/Category/list';
  static const SCHEDULE_FIELD = '/vpdt/api/ScheduleField/list';
  static const CONFIG_SYSTEM = '/vpdt/api/ConfigSystem/list';
  static const DANH_SACH_CAN_BO_LICH_HOP =
      '/vpdt/api/MeetingSchedule/danh-sach-can-bo-lich-hop';
  static const DANH_SACH_PHIEN_HOP =
      '/vpdt/api/meetingsection/get-list-phien-hop';
  static const EVENT_CALENDAR_LICH_HOP =
      '/vpdt/api/MeetingSchedule/calendar-day-of-month';
  static const EVENT_CALENDAR_LICH_LV = '/vpdt/api/Schedules/Ngay-co-lich';
  static const CHUONG_TRINH_HOP =
      '/vpdt/api/MeetingSchedule/danh-sach-can-bo-lich-hop';
  static const CHI_TIET_VAN_BAN_DI = '/qlvb/api/van-ban-di/{id}';
  static const Y_KIEN_VAN_BAN_DI =
      '/qlvb/api/van-ban-di/y-kien-van-ban-di/{id}';
  static const CHI_TIET_LICH_LAM_VIEC = '/vpdt/api/Schedules/{id}?';

  static const THEM_PHIEN_HOP_CHI_TIET = '/vpdt/api/meetingsection/them-moi';
  static const HUY_AND_DUYET_LICH_HOP =
      '/vpdt/api/MeetingSchedule/duyet-lich-hop';
  static const CU_CAN_BO_DI_THAY =
      '/vpdt/api/MeetingSchedule/cu-can-bo-di-thay';
  static const TRANG_THAI = '/vpdt/api/ReportStatus/list';

  static const THEM_PHIEN_NhIEM_VU = '/qlvb/api/qlnv/nhiem-vu/them-by-lich-hop';

  static const EDIT_CHUONG_TRINH_HOP = '/vpdt/api/MeetingSection/edit';
  static const XOA_CHUONG_TRINH_HOP = '/vpdt/api/MeetingSection/xoa-phien-hop';
  static const GET_DANH_SACH_NTG_CHUONG_TRINH_HOP =
      '/vpdt/api/MeetingSchedule/danh-sach-can-bo-bieu-quyet';
  static const PHAN_CONG_THU_KY = '/vpdt/api/MeetingSchedule/assign-secretary';

  static const TAO_BIEU_QUYET = '/vpdt/api/MeetingSection/create-phat-bieu';

  static const DUYET_PHAT_BIEU = '/vpdt/api/MeetingSection/duyet-phat-bieu';

  static const DIEM_DANH = '/vpdt/api/MeetingSchedule/check-in-meeting';

  static const HUY_DIEM_DANH = '/vpdt/api/MeetingSchedule/check-out-meeting';

  static const THU_HOI_HOP = '/vpdt/api/MeetingSchedule/thu-hoi';

  static const XOA_LICH_LAM_VIEC = '/vpdt/api/Schedules/delete-schedule';

  static const POST_DANH_SACH_LICH_LAM_VIEC =
      '/vpdt/api/Schedules/danh-sach-lich';
  static const TAO_MOI_BAN_GHI = '/vpdt/api/ScheduleOpinion/create';
  static const CANCEL_TIET_LICH_LAM_VIEC = '/vpdt/api/Schedules/change-status';
  static const SCHEDULE_REPORT_LIST = '/vpdt/api/ScheduleReport/list';
  static const DELETE_SCHEDULE_REPORT = '/vpdt/api/ScheduleReport/delete';
  static const SCHEDULE_OPINION_LIST = '/vpdt/api/ScheduleOpinion/list';
  static const UPDATE_SCHEDULE_REPORT = '/vpdt/api/ScheduleReport/update';
  static const REPORT_STATUS_LIST = '/vpdt/api/ReportStatus/list';
  static const DELETE_DETAIL_CELENDER_MEET = '/vpdt/api/MeetingSchedule';

  static const CANCEL_DETAIL_CELENDER_MEET =
      '/vpdt/api/MeetingSchedule/cancel?';
  static const MENU_LICH_HOP =
      '/vpdt/api/MeetingSchedule/count-lich-hop-don-vi';
  static const STATISTIC_BY_MONTH = '/vpdt/api/Statistic/statistic-by-month';
  static const DASHBOARD_THONG_KE = '/vpdt/api/Statistic/statistics';
  static const CO_CAU_LICH_HOP =
      '/vpdt/api/Statistic/statistic-by-type-of-calendar';
  static const STATUS_LIST_KET_LUAN_HOP = '/vpdt/api/ReportStatus/list';
  static const MENU_LICH_LV = '/vpdt/api/Schedules/count-lich-don-vi';
  static const TO_CHUC_BOI_DON_VI =
      '/vpdt/api/Statistic/statistic-by-processing-unit';
  static const TI_LE_THAM_GIA =
      '/vpdt/api/Statistic/statistic-for-processing-unit-by-rate';
  static const SUA_LICH_HOP = '/vpdt/api/MeetingSchedule/edit-meeting';

  static const DANH_SACH_LOAI_NHIEM_VU = '/qlvb/api/qlnv/loai-nhiem-vu/getall';

  static const TAO_LICH_LAM_VIEC = '/vpdt/api/Schedules';
  static const THU_HOI_LICH_LAM_VIEC =
      '/vpdt/api/ScheduleCoperative/change-status-multi';
  static const CAN_BO_THU_HOI_LICH = ' /CanBoThamGia/can-bo-tham-gia-hop-tree';
  static const CHECK_TRUNG_LICH_LICH_LAM_VIEC =
      '/vpdt/api/Schedules/Check-trung-lich';
  static const TAO_BAO_KET_QUA = '/vpdt/api/ScheduleReport/create';
  static const SUA_BAO_CAO_KET_QUA = '/vpdt/api/ScheduleReport/update';

  static const DETAIL_MEETING_SCHEDULE = '/vpdt/api/MeetingSchedule/detail';
  static const MEETING_ROOM_DANH_SACH_PHONG_HOP =
      '/vpdt/api/MeetingRoom/danh-sach-phong-hop';
  static const MEETING_ROOM_DANH_SACH_THIET_BI =
      '/vpdt/api/MeetingRoom/danh-sach-thiet-bi';
  static const TONG_PHIEN_HOP = '/vpdt/api/MeetingSection/get-total-phien-hop';
  static const SELECT_PHIEN_HOP = '/vpdt/api/ScheduleOpinion/list';
  static const THEM_Y_KIEN_HOP = '/vpdt/api/ScheduleOpinion/create';
  static const THEM_BIEU_QUYET_HOP = '/vpdt/api/BieuQuyet/them-moi-bieuquyet';
  static const MOI_HOP = '/vpdt/api/MeetingSchedule/moi-hop';

  static const SUA_KET_LUAN = '/vpdt/api/ScheduleReport/update-meet-report';
  static const CHON_MAU_BIEN_BAN = '/vpdt/api/ReportTemplate/list';

  static const SO_LUONG_PHAT_BIEU =
      '/vpdt/api/MeetingSection/so-luong-phat-bieu';
  static const DANH_SACH_PHAT_BIEU_LICH_HOP =
      '/vpdt/api/MeetingSection/danh-sach-phat-bieu';
  static const DANH_SACH_BIEU_QUYET_LICH_HOP =
      '/vpdt/api/BieuQuyet/get-thongtin-bieuquyet';
  static const DANH_SACH_LICH_HOP_TPTG =
      '/vpdt/api/MeetingSchedule/danh-sach-can-bo-lich-hop';
  static const ADD_FILE_TAI_LIEU_TAO_LICH_HOP =
      '/vpdt/api/Files/add-file-with-meeting';
  static const SEND_EMAIL_KL_HOP =
      '/vpdt/api/ScheduleReport/send-email-bao-cao';
  static const DASH_BOARD_TAT_CA_CHU_DE = '/api/NewsNetViews/dashboard';
  static const GET_LIST_TAT_CA_CHU_DE = '/api/NewsNetViews/search_news';
  static const CHI_TIET_VAN_BAN_DEN = '/qlvb/api/VanBan/ChiTietVanBanDen';
  static const HOI_BAO_VAN_BAN_DEN = '/qlvb/api/vanban/van-ban-di-response';
  static const CREATE_METTING = '/vpdt/api/MeetingSchedule/create-meeting';

  static const CHON_PHONG_HOP_METTING = '/vpdt/MeetingSchedule/chon-phong-hop';
  static const THEM_PHIEN_HOP = '/api/LogAction/add-log';
  static const THONG_TIN_GUI_NHAN = '/qlvb/api/VanBan/lich-su-gui-nhan/{id}?';
  static const THEO_DOI_VAN_BAN_DA_BAN_HANH =
      '/qlvb/api/van-ban-di/{myId}/lich-su-theo-doi-van-ban';
  static const XEM_KET_LUAN_HOP = '/vpdt/api/ScheduleReport/xem-ket-luan';
  static const LICH_SU_VAN_BAN_DEN = '/qlvb/api/vanban/lich-su-by-type';
  static const LIST_PERMISSION = '/api/auth/list-permission';
  static const GET_DANH_SACH_Y_KIEN =
      '/qlvb/api/qlvb/van-ban-den/y-kien-xu-ly/danh-sach-y-kien';
  static const GET_LICH_SU_XIN_Y_KIEN =
      '/qlvb/api/qlvb/van-ban-den/y-kien-xu-ly/lich-su-xin-y-kien';
  static const BAO_CAO_THONG_KE = '/api/NewsNetViews/dashboard_statistical';
  static const MENU_BCMXH = '/api/NewsNetViews/menu-items?';
  static const Tin_TUC_THOI_SU = '/api/NewsNetViews/tin_tuc_thoi_su?';
  static const BAI_VIET_THEO_DOI = '/api/NewsNetViews/get_bai_viet_theo_doi?';
  static const LICH_SU_THU_HOI_VAN_BAN_DI =
      '/qlvb/api/van-ban-di/{id}/xem-lich-su-thu-hoi';
  static const LICH_SU_TRA_LAI_VAN_BAN_DI =
      '/qlvb/api/van-ban-di/{id}/xem-lich-su-tra-lai';
  static const LICH_SU_KY_DUYET_VAN_BAN_DI =
      '/qlvb/api/van-ban-di/{id}/xem-lich-su-luong-xu-ly';
  static const LICH_SU_HUY_DUYET_VAN_BAN_DI =
      '/qlvb/api/van-ban-di/{id}/xem-lich-su-huy-duyet';
  static const LICH_SU_CAP_NHAT_VAN_BAN_DI =
      '/qlvb/api/van-ban-di/{id}/xem-lich-su-cap-nhat';
  static const LUONG_XU_LY_VAB_BAN_DI =
      '/qlvb/api/van-ban-di/{id}/xem-luong-xu-ly';
  static const LUONG_XU_LY_VAN_BAN_DEN = '/qlvb/api/vanban/getluongxuly';
  static const SEARCH_TIN_TUC = '/api/NewsNetViews/search_news?';
  static const DASH_BOARD_TINH_HINH_XU_LY =
      '/pakn/api/IocApi/thong-ke-tinh-hinh-xu-ly-pakn';
  static const DASH_BOARD_PHAN_LOAI =
      '/pakn/api/IocApi/thong-ke-tinh-hinh-theo-nguon';
  static const THONG_TIN_Y_KIEN_NGUOI_DAN =
      '/pakn/api/IocApi/thong-ke-pakn-theo-trang-thai';
  static const DANH_SACH_Y_KIEN_NGUOI_DAN = '/pakn/api/IocApi/danh-sach-pakn?';
  static const CHI_TIET_Y_KIEN_NGUOI_DAN = '/pakn/api/Tasks/chi-tiet-kien-nghi';
  static const THONG_TIN_XU_LY_PAKN = '/pakn/api/Tasks/chi-tiet-kien-nghi';
  static const SEARCH_Y_KIEN_NGUOI_DAN = '/pakn/api/IocApi/danh-sach-pakn?';
  static const GET_LIST_WIDGET = '/api/Widget/get-list-widget?';
  static const GET_DANH_SACH_Y_KIEN_PAKN =
      '/pakn/api/TaskYKien/danh-sach-ykien';
  static const BAO_CAO_YKND = '/pakn/api/Dashboard/statistics-by-top';
  static const DASH_BOARD_BAO_CAO_YKND =
      '/pakn/api/Dashboard/statistics-by-status';
  static const RESET_LIST_WIDGET = '/api/Widget/reset-dashboard-widget';
  static const UPDATE_LIST_WIDGET =
      '/api/Widget/update-dashboard-widget-config';
  static const BAO_CAO_LINH_VUC_KHAC =
      '/pakn/api/Dashboard/statistics-by-field';
  static const DON_VI_XU_LY = '/pakn/api/Dashboard/statistics-by-unit';
  static const SO_LUONG_BY_MONTH = '/pakn/api/Dashboard/statistics-by-month';
  static const TONG_QUAN_BAO_CAO_BCMXH = '/api/NewsNetViews/tong_quan';
  static const TIN_TONG_HOP_BAO_CAO_BCMXH =
      '/api/NewsNetViews/dashboard_statistical';
  static const BAO_CAO_THEO_NGUON_BCMXH =
      '/api/NewsNetViews/thong_ke_theo_ty_le_nguon';
  static const BAO_CAO_THEO_SAC_THAI =
      '/api/NewsNetViews/thong_ke_theo_ty_le_sac_thai';
  static const BAO_CAO_THEO_THOI_GIAN =
      '/api/NewsNetViews/thong_ke_theo_thoi_gian';
  static const BAO_CAO_THEO_NGUON_LINE_CHART =
      '/api/NewsNetViews/thong_ke_theo_nguon';
  static const BAO_CAO_THEO_SAC_THAI_LINE_CHART =
      '/api/NewsNetViews/thong_ke_theo_sac_thai';
  static const THEO_DOI_BAI_VIET = '/api/NewsNetViews/theo_doi';
  static const CHANGE_PASS = '/api/auth/change-pass';
  static const FORGOT_PASSWORD = '/api/auth/forgot-password';
  static const THEM_Y_KIEN = '/vpdt/api/ScheduleOpinion/create';
  static const TIEN_TRINH_XU_LY = '/pakn/api/KienNghi/TienTrinhXulyPAKN';
  static const KET_QUA_XU_LY = '/pakn/api/Tasks/ds-van-ban-di-theo-phan-cap';
  static const GET_NOTIFY_APP_CODES = '/api/Notification/appcodes';
  static const SETTING_NOTIFY = '/api/Notification/setting';
  static const GET_THONG_BAO_QUAN_TRONG = '/api/Notification/notifi-impotant';
  static const GET_HOC_PHAN = '/api/Notification/list';
  static const READ_ALL = '/api/Notification/read-all';
  static const DELETE_NOTIFY = '/api/Notification/delete';
  static const TINH_SELECT = '/vpdt/api/Country/province-list';
  static const HUYEN_SELECT = '/vpdt/api/Country/disytrict-list';
  static const XA_SELECT = '/vpdt/api/Country/wards-list';
  static const DAT_NUOC_SELECT = '/vpdt/api/Country/country-list';
  static const POST_Y_KIEN_XU_LY = '/pakn/api/TaskYKien/XinYKien';
  static const POST_CHO_Y_KIEN_XU_LY = '/PAKN/api/TaskYKien/ChoYKien';
  static const GET_PAKN_TIEP_NHAN_VAN_BAN_DI =
      '/PAKN/api/Tasks/danh-sach-theo-van-ban-di';
  static const GET_PAKN_XU_LY_VAN_BAN =
      '/pakn/api/TaskYKien/danh-sach-kien-nghi-y-kien';
  static const DOWNLOAD_FILE = '/api/Common/DownloadFile';
  static const GET_LOCATION_ADDRESS = '/pakn/api/location';
  static const GET_DANH_SACH_PAKN = '/pakn/api/IocApi/danh-sach-pakn';
  static const CREATE_DEVICE = '/api/DeviceNotification/create-device';
  static const UPDATE_DEVICE = '/api/DeviceNotification/update-device';
  static const DS_DON_VI_CON_PHONG =
      '/vpdt/api/DonVi/danh-sach-don-vi-cha-co-phong-hop';
  static const DS_PHONG_HOP = '/vpdt/api/PhongHop/lay-theo-don-vi';
  static const DUYET_HOAC_HUYDUYET_PHONG_HOP =
      '/vpdt/api/MeetingSchedule/duyet-phong-hop';
  static const DUYET_HOAC_HUYDUYET_THIET_BI =
      '/vpdt/api/MeetingSchedule/duyet-thiet-bi';
  static const CHON_PHONG_HOP = '/vpdt/api/CanBoThamGia/thay-doi-phong';
  static const DUYET_HOAC_HUYDUYET_KY_THUAT =
      '/vpdt/api/CanBoThamGia/duyet-ky-thuat';
  static const DOASHBOARD_TINH_HINH_XU_LY_PAKN =
      '/pakn/api/Dashboard/tinh-hinh-xu-ly-pakn';
  static const DASHBOARD_PAKN_TIEP_NHAN_XU_LY =
      '/pakn/api/dashboard-mpi/tinh-hinh-xu-ly';
  static const DANH_SACH_PAKN_FILTER = '/pakn/api/dashboard-mpi/danh-sach-pakn';
  static const CHECK_LICH_HOP_TRUNG =
      '/vpdt/api/MeetingSchedule/check-lich-hop-trung';
  static const CONFIRM_HOP = '/vpdt/api/CanBoThamGia/confirm-hop';
  static const CONFIRM_OR_CANCEL_KET_LUAN_HOP =
      '/vpdt/api/ScheduleReport/duyet-bao-cao';
  static const CREATE_KET_LUAN_HOP =
      '/vpdt/api/ScheduleReport/create-meet-report';
  static const GUI_DUYET_KET_LUAN_HOP =
      '/vpdt/api/ScheduleReport/register-meet-report';
  static const THU_HOI_KET_LUAN_HOP =
      '/vpdt/api/ScheduleReport/reject-meet-report';
  static const REFRESH_TOKEN = '/common/auth/refresh-token';
  static const DELETE_FILE = '/vpdt/api/Files/delete-file-with-meeting';
  static const LIST_STATUS_ROOM = '/vpdt/api/ReportStatus/list-status-room';
  static const GET_LIST_USER_IN_UNIT = '/htcs/api/users/get-paging';
  static const SUA_TRANG_THAI = '/vpdt/api/MeetingRoom/update-trang-thai';
  static const THEM_MOI_VOTE = '/vpdt/api/BieuQuyet/them-moi-votes';
  static const GET_LICH_CAN_KLCH =
      '/vpdt/api/MeetingSchedule/danh-sach-lich-can-kl-hop';
  static const CHI_TIET_BIEU_QUYET = '/vpdt/api/BieuQuyet/{id}';
  static const SUA_BIEU_QUYET = '/vpdt/api/BieuQuyet/sua-bieu-quyet';
  static const XOA_BIEU_QUYET = '/vpdt/api/BieuQuyet/xoa-bieu-quyet';
  static const DANH_SACH_CAN_BO_BIEU_QUYET =
      '/vpdt/api/BieuQuyet/get-danh-sach-canbo-bieuquyet';
  static const BAO_CAO_THONG_KE_VAN_BAN_DON_VI = '/qlvb/api/ioc/thong-ke-van-ban-don-vi-duoc-chon';
  static const GET_LICH_HOP_THEO_LINH_VUC = '/vpdt/api/ViewDashboardSchedule/thong-ke-linh-vuc';

}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-image-found.816e59fa.png';
}
