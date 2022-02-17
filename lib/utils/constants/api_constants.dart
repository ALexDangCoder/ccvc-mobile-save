class BaseUrlConstants {

  static const baseURLCCVC = 'https://api-ccvc-uat.chinhquyendientu.vn';
  static const baseUrlGateway =
      'https://api-gateway-ccvc-uat.chinhquyendientu.vn';
  static const baseUrlCommon =
      'https://api-common-ccvc-uat.chinhquyendientu.vn';

}

class ApiConstants {
  static const LOGIN = '/api/auth/login';
  static const int DEFAULT_PAGE_SIZE = 45;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;

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

  static const String GET_INFO = 'api/CanBo';

}
