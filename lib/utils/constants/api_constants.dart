class ApiConstants {
  static const LOGIN = '/api/auth/login';
  static const int DEFAULT_PAGE_SIZE = 45;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const String POST_DANH_SACH_LICH_HOP =
      '/vpdt/api/MeetingSchedule/calendar-list';
  static const String GET_DASH_BOARD_LH =
      '/vpdt/api/MeetingSchedule/count-in-dashboard';
  static const String GET_LIST_TOKEN = '/market/coin-list';
  static const String GET_PRICE_TOKEN_BY_SYMBOL = '/market/coin-price/';
  static const String GET_PHAM_VI = '/common/auth/list-pham-vi';
  static const String GET_LUNAR_DATE = '/api/LunarDate/getLunarDate';
  static const String GET_TINH_HUONG_KHAN_CAP =
      '/api/DashBoardHome/tinh-huong-khan-cap?';
  static const String GET_DASHBOARD_WIDGET =
      '/api/Widget/get-dashboard-widget-config?';
  static const String GET_DASHBOARD_VB_DEN =
      '/qlvb/api/danh-muc/dashboard-van-ban-den';
  static const String GET_VB_DI_SO_LUONG = '/qlvb/api/van-ban-di/so-luong?';
  static const String GET_INFO = '/api/CanBo';
  static const String GET_TINH_HUYEN_XA = '/api/DanhMuc/tinh-thanh';
  static const String GET_TINH_HUYEN_XA_CHILD = '/api/DanhMuc/tinh-thanh';
  static const String LIST_LICH_LV = '/vpdt/api/Schedules/danh-sach-lich';

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

  static const LICH_LAM_VIEC_DASHBOARD =
      '/vpdt/api/Schedules/count-in-dashboard';
  static const LICH_LAM_VIEC_DASHBOARD_RIGHT =
      '/vpdt/api/Schedules/dashboard-schedule';
  static const GET_TREE_DON_VI = '/common/DonVi/get-tree?';
  static const SEARCH_CAN_BO = '/vpdt/api/CanBo/search';
  static const CATEGORY_LIST = '/vpdt/api/Category/list';
  static const SCHEDULE_FIELD = '/vpdt/api/ScheduleField/list';
  static const DANH_SACH_CAN_BO_LICH_HOP =
      '/vpdt/api/MeetingSchedule/danh-sach-can-bo-lich-hop';
  static const CHI_TIET_VAN_BAN_DI = '/qlvb/api/van-ban-di/{id}?';
  static const CHI_TIET_LICH_LAM_VIEC = '/vpdt/api/Schedules/{id}?';

  static const TRANG_THAI = '/vpdt/api/ReportStatus/list';

  static const XOA_LICH_LAM_VIEC =
      '/vpdt/api/Schedules/delete-schedule?scheduleId={id}&only=true&isLichLap=true&?';

  static const POST_DANH_SACH_LICH_LAM_VIEC =
      '/vpdt/api/Schedules/danh-sach-lich';
  static const POST_THEM_Y_KIEN_HOP =
      '/vpdt/api/ScheduleOpinion/create';
  static const TAO_MOI_BAN_GHI = '/vpdt/api/ScheduleOpinion/create';

  static const CANCEL_TIET_LICH_LAM_VIEC =
      '/vpdt/api/Schedules/change-status?scheduleId={id}&statusId=8&isMulti=false';
  static const SCHEDULE_REPORT_LIST = '/vpdt/api/ScheduleReport/list';
  static const DELETE_SCHEDULE_REPORT = '/vpdt/api/ScheduleReport/delete';
  static const SCHEDULE_OPINION_LIST = '/vpdt/api/ScheduleOpinion/list';
  static const UPDATE_SCHEDULE_REPORT = '/vpdt/api/ScheduleReport/update';
  static const REPORT_STATUS_LIST = '/vpdt/api/ReportStatus/list';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-image-found.816e59fa.png';
}
