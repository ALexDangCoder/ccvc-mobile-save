class ApiConstants {
  static const int DEFAULT_PAGE_SIZE = 10;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const String DANH_SACH_SU_CO = '/htkt/api/Task/get-all';
  static const String GET_TONG_DAI = '/htkt/api/CmsSupporters/get-sysconfig';

  static const String GET_SUPPORT_DETAIL = '/htkt//api/Task/get-by-id';
  static const LIST_THANH_VIEN_BAO_CAO = '/common/users/ingroup';
  static const String GET_CATEGORY = '/htkt/api/Category/get-tree';
  static const String GET_CHART_SU_CO = '/htkt/api/Task/thong-ke-khu-vuc';
  static const String GET_NGUOI_XU_LY = '/htkt/api/Task/get-infor-user';
  static const String DELETE_TASK = '/htkt/api/Task/delete-task';
  static const String ADD_TASK = '/htkt/api/Task/add-task';
  static const String EDIT_TASK = '/htkt/api/Task/edit-task';
  static const String POST_UPDATE_TASK_PROCESSING =
      '/htkt/api/TaskProcessing/edit-task-processing';
  static const String COMMENT_TASK_PROCESSING =
      '/htkt/api/TaskProcessing/danh-gia';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-images-found.816e59fa.png';
}
