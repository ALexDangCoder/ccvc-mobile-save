class ApiConstants {
  static const int DEFAULT_PAGE_SIZE = 10;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const DIEM_DANH_CA_NHAN_THONG_KE =
      '/ddth/api/DDDiemDanhCaNhan/ThongKe';
  static const DIEM_DANH_CA_NHAN_BANG_DIEM_DANH =
      '/ddth/api/DDDiemDanhCaNhan/BangDiemDanh';
  static const POST_FILE = '/ddth/api/Files/UploadFile';
  static const GET_ALL_FILE = '/ddth/api/Files/GetListFileForEntity';
  static const DANH_SACH_BIEN_SO_XE = '/ddth/api/SYSBienSoXe/GetList';
  static const GET_FILE = '/ddth/api/Files';
  static const XOA_BIEN_XO_XE = '/ddth/api/SYSBienSoXe/Delete/{id}';
  static const DANG_KY_THONG_TIN_XE_MOI = '/ddth/api/SYSBienSoXe/Create';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-images-found.816e59fa.png';
}
