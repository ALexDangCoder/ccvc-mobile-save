class ApiConstants {
  static const int LONG_PAGE_SIZE = 25;
  static const int MAX_PAGE_SIZE = 35;
  static const int MIN_PAGE_SIZE = 1;
  static const int PAGE_BEGIN = 1;
  static const TOPIC_HDSD = '/api/FAQs/get-all-topic?';
  static const TODO_LIST_CURRENT_USER = '/api/TodoList/get-current-user';
  static const TODO_LIST_UPDATE = '/api/TodoList/update';
  static const TODO_LIST_CREATE = '/api/TodoList/create';
  static const LIST_NGUOI_THUC_HIEN = '/api/CanBo/search';
  static const GET_DANH_SACH_HDSD = '/api/FAQs/get-danh-sach';
  static const GET_DETAIL_HUONG_DAN_SU_DUNG = '/api/FAQs/get-by-id';
  static const GET_LICH_AM_DUONG = '/LichAm/Mobile';
  static const GET_LIST_DANH_BA_CA_NHAN = '/api/danhbadientu/all';
  static const POST_DANH_BA_CA_NHAN = '/api/danhbadientu';
  static const TREE_DANH_BA = '/api/DonVi/all';
  static const DELETE_DANH_BA_CA_NHAN = '/api/danhbadientu/{id}?';
  static const SEARCH_LIST_DANH_BA_CA_NHAN = '/api/danhbadientu/all';
  static const GET_LIST_DANH_BA_TO_CHUC = '/api/CanBo/search';
  static const PACTH = '/api/CanBo/upload';
  static const GET_TRA_CUU_VAN_BAN_PHAP_LUAT = '/api/VbPhapLuat/search';
  static const NHOM_CV_MOI = '/api/TodoListGroup/get-current-user';
  static const GAN_CONG_VIEC_CHO_TOI = '/api/TodoList/get-by-performer';
  static const XOA_CONG_VIEC = '/api/TodoList/delete';
  static const TAO_NHOM_CONG_VIEC_MOI = '/api/TodoListGroup/create';
  static const SUA_TEN_NHOM_CONG_VIEC_MOI = '/api/TodoListGroup/update';
  static const XOA_NHOM_CONG_VIEC_MOI = '/api/TodoListGroup/delete';
  static const TRANSLATE_DOCUMENT = '/appdieuhanh/api/Common/dich_van_ban';
  static const POST_FILE = '/api/common/uploadfile';
  static const TRANSLATE_FILE = '/api/Common/dich_tai_lieu';
  static const CHUYEN_VB_SANG_GIONG_NOI =
      '/api/TichHop/chuyen-vanban-sang-giongnoi';
  static const POST_FILE_DSCV = '/api/CmsCard/upload-file';
  static const CONG_VIEC_GAN_CHO_NGUOI_KHAC = '/api/TodoList/get-by-give-other';
  static const GET_ALL_CONG_VIEC_WITH_FILTER = '/api/TodoList/get-all';
  static const GET_COUNT_TODO = '/api/TodoList/get-count-todo';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-image-found.816e59fa.png';
}
