class ApiConstants {
  static const int DEFAULT_PAGE_SIZE = 10;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const DASH_BOARD_TINH_HINH_XU_LY =
      '/pakn/api/IocApi/thong-ke-tinh-hinh-xu-ly-pakn';
  static const DASH_BOARD_PHAN_LOAI =
      '/pakn/api/IocApi/thong-ke-tinh-hinh-theo-nguon';
  static const THONG_TIN_Y_KIEN_NGUOI_DAN =
      '/pakn/api/IocApi/thong-ke-pakn-theo-trang-thai';
  static const DANH_SACH_Y_KIEN_NGUOI_DAN = '/pakn/api/IocApi/danh-sach-pakn?';
  static const CHI_TIET_Y_KIEN_NGUOI_DAN = '/pakn/api/Tasks/chi-tiet-kien-nghi';
  static const SEARCH_Y_KIEN_NGUOI_DAN = '/pakn/api/IocApi/danh-sach-pakn?';
  static const GET_DANH_SACH_Y_KIEN_PAKN =
      '/pakn/api/TaskYKien/danh-sach-ykien';
  static const BAO_CAO_YKND = '/pakn/api/Dashboard/statistics-by-top';
  static const DASH_BOARD_BAO_CAO_YKND =
      '/pakn/api/Dashboard/statistics-by-status';
  static const BAO_CAO_LINH_VUC_KHAC =
      '/pakn/api/Dashboard/statistics-by-field';
  static const SO_LUONG_BY_MONTH = '/pakn/api/Dashboard/statistics-by-month';
  static const TIEN_TRINH_XU_LY = '/pakn/api/KienNghi/TienTrinhXulyPAKN';
  static const DON_VI_XU_LY = '/pakn/api/Dashboard/statistics-by-unit';
  static const KET_QUA_XU_LY = '/pakn/api/Tasks/ds-van-ban-di-theo-phan-cap';
}
