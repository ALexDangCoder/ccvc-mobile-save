class ApiConstants {
  static const String GET_PHAM_VI = '/common/auth/list-pham-vi';
  static const String GET_LUNAR_DATE = '/api/LunarDate/getLunarDate';
  static const String GET_TIN_BUON = '/api/DashBoardHome/tin-buon';
  static const String GET_DASHBOARD_WIDGET =
      '/api/Widget/get-dashboard-widget-config?';
  static const String GET_DASHBOARD_VB_DEN =
      '/qlvb/api/danh-muc/dashboard-van-ban-den';
  static const String GET_VB_DI_SO_LUONG = '/qlvb/api/van-ban-di/so-luong';

  static const String DANH_SACH_CONG_VIEC =
      '/qlvb/api/qlnv/cong-viec/danhsachcongvieccanhan';

  static const String GET_DANH_SACH_VAN_BAN =
      '/qlvb/api/vanban/getdanhsachvanban';
  static const String GET_DANH_SACH_VAN_BAN_SEARCH =
      '/qlvb/api/van-ban-di/search';
  static const String TONG_HOP_NHIEM_VU =
      '/qlvb/api/qlnv/ccvc/tong-hop-nhiem-vu';
  static const String NHIEM_VU_GET_ALL = '/qlvb/api/qlnv/ccvc/ds-nhiem-vu';
  static const TINH_HINH_XU_LY_TRANG_CHU =
      '/pakn/api/IocApi/thong-ke-tinh-hinh-xu-ly-trang-chu?';
  static const DANH_SACH_PAKN = '/pakn/api/IocApi/danh-sach-pakn?';

  //
  static const TODO_LIST_CURRENT_USER = '/api/TodoList/get-current-user';
  static const TODO_LIST_UPDATE = '/api/TodoList/update';
  static const TODO_LIST_CREATE = '/api/TodoList/create';
  static const SEARCH_NEW = '/api/NewsNetViews/search_news?';
  static const DANH_SACH_LICH_LAM_VIEC = '/vpdt/api/Schedules/danh-sach-lich';
  static const CANLENDAR_LIST_MEETING =
      '/vpdt/api/MeetingSchedule/calendar-list';
  static const SU_KIEN_TRONG_NGAY = '/api/DashBoardHome/su-kien-trong-ngay';
  static const SINH_NHAT_DASHBOARD = '/api/DashBoardHome/sinh-nhat';
  static const GUI_LOI_CHUC = '/api/CmsCard/tao-loichuc-thiep';
  static const GET_LIST_THONG_TIN_THIEP =
      '/api/CmsCard/lay-danhsach-thongtin-thiep';
  static const DOASHBOARD_TINH_HINH_XU_LY_PAKN =
      '/pakn/api/Dashboard/tinh-hinh-xu-ly-pakn';
  static const DOASHBOARD_TINH_HINH_XU_LY_PAKN_CA_NHAN =
      '/pakn/api/dashboard-mpi/tinh-hinh-xu-ly';
  static const TINH_HINH_XU_LY_VAN_BAN =
      '/qlvb/api/ccvc/tinh-hinh-xu-ly-van-ban';
  static const GET_LIST_CAN_BO = '/api/CanBo/search';
  static const GET_WEATHER = '/appdieuhanh/api/AreaWeather/getweatherbycode';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-images-found.816e59fa.png';
}
