class ApiConstants {
  static const int DEFAULT_PAGE_SIZE = 10;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const LIST_REPORT = '/htcs/api/Folder/list';
  static const LIST_REPORT_SHARE_TO_ME = '/htcs/api/Folder/share-to-me';
  static const LIST_GROUP_BAO_CAO = '/common/Group/search';
  static const LIST_THANH_VIEN_BAO_CAO = '/common/users/ingroup';
  static const GET_APP_ID = '/api/App/search';
  static const GET_FOLDER_ID = '/htcs/api/Folder/get-root';
  static const POST_LIKE_REPORT = '/htcs/api/Report/like-many';
  static const PUT_DISLIKE_REPORT = '/htcs/api/Report/disable-like-many';
  static const GET_LIST_REPORT_FAVORITE = '/htcs/api/Report/like-list';
  static const GET_LIST_TREE_REPORT = '/htcs/api/Folder/tree';
  static const CREATE_NEW_USER = '/htcs/api/User/create';
  static const SHARE_REPORT = '/htcs/api/User/share-many';
  static const GET_DS_NGOAI_HE_THONG_DUOC_TRUY_CAP = '/htcs/api/User/list';
  static const REPORT_DETAIL = '/htcs/api/Report';
  static const GET_USER_PAGING = '/api/users/get-paging';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-images-found.816e59fa.png';
}
