class ApiConstants {
  static const String DEFAULT_VALUE_GUID_ID =
      '00000000-0000-0000-0000-000000000000';

  ///entityName call api
  static const String KHUON_MAT_DEO_KINH = 'KhuonMatDeoKinh';
  static const String KHUON_MAT_KHONG_DEO_KINH = 'KhuonMatKhongDeoKinh';
  static const String ANH_KHUON_MAT = 'AnhKhuonMat';
  static const String BIEN_SO_XE_ENTITY = 'BienSoXe';

  ///fileTypeUpload call api
  static const String NHIN_CHINH_DIEN = 'anh_nhin_chinh_dien';
  static const String NHIN_CHINH_SANG_TRAI = 'anh_nhin_sang_trai';
  static const String NHIN_CHINH_SANG_PHAI = 'anh_nhin_sang_phai';
  static const String NHIN_TU_TREN_XUONG = 'anh_nhin_tu_tren_xuong';
  static const String NHIN_TU_DUOI_LEN = 'anh_nhin_tu_duoi_len';
  static const String BIEN_SO_XE_TYPE = 'anh_bien_so_xe';

  static const int DEFAULT_PAGE_SIZE = 10;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;
  static const DIEM_DANH_CA_NHAN_THONG_KE =
      '/ddth/api/DDDiemDanhCaNhan/ThongKe';
  static const DIEM_DANH_CA_NHAN_BANG_DIEM_DANH =
      '/ddth/api/DDDiemDanhCaNhan/BangDiemDanh';
  static const POST_FILE = '/ddth/api/Files/UploadFile';
  static const POST_FILE_KHUON_MAT = '/ddth/api/Files/UploadMotFile';
  static const GET_ALL_FILE = '/ddth/api/SYSKhuonMat/GetDetail/{id}';
  static const DANH_SACH_BIEN_SO_XE = '/ddth/api/SYSBienSoXe/GetList';
  static const GET_FILE = '/ddth/api/Files';
  static const XOA_BIEN_XO_XE = '/ddth/api/SYSBienSoXe/Delete/{id}';
  static const DANG_KY_THONG_TIN_XE_MOI = '/ddth/api/SYSBienSoXe/Create';
  static const CAP_NHAT_THONG_TIN_XE_MOI = '/ddth/api/SYSBienSoXe/Update';
  static const DELETE_IMAGE = '/ddth/api/SYSKhuonMat/Delete';
  static const HIEN_THI_ANH = '/ddth/api/Files/HienThiFile';
  static const CREATE_IMAGE = '/ddth/api/SYSKhuonMat/Create';
  static const CHECK_AI_KHUON_MAT = '/ddth/api/SYSKhuonMat/CheckImage';
  static const XOA_ANH_AI = '/api/SYSKhuonMat/XoaAnhAI';
}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-images-found.816e59fa.png';
}
