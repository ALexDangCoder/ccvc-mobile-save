class ApiConstants {
  static const DANHSACHNHIEMVU = '/qlvb/api/qlnv/ccvc/ds-nhiem-vu';
  static const DANHSACHCONGVIEC =
      '/qlvb/api/qlnv/cong-viec/danhsachcongvieccanhan';
  static const POST_Y_KIEN_XU_LY_NHIEM_VU = '/qlvb/api/qlnv/y-kien-xu-ly/them';
  static const String DOWNLOAD_FILE = '/qlvb/api/Common/DownloadFile';
  static const GETDASHBROASHNHIEMVU =
      '/qlvb/api/qlnv/nhiem-vu/dem-loai-nhiem-vu/donvi';
  static const GETDASHBROASHCONGVIEC =
      '/qlvb/api/qlnv/cong-viec/dem-loai-cong-viec-don-vi';
  static const GETDASHBROASHNHIEMVUCANHAN =
      '/qlvb/api/qlnv/nhiem-vu/dem-loai-nhiem-vu/canhan';
  static const GETDASHBROASHCONGVIECCANHAN =
      '/qlvb/api/qlnv/cong-viec/dem-loai-cong-viec';
  static const int DEFAULT_PAGE_SIZE = 10;
  static const int PAGE_BEGIN = 1;
  static const int NOT_SAVED_ID = -1;
  static const int TIME_OUT = 30;

  static const GET_CHI_TIET_NHIEM_VU = '/qlvb/api/qlnv/nhiem-vu/get';
  static const GET_LICH_SU_PHAN_XU_LY_NHIEM_VU =
      '/qlvb/api/qlnv/phan-xu-ly/getbynhiemvu';
  static const GET_Y_KIEN_XU_LY = '/qlvb/api/qlnv/y-kien-xu-ly/{id}?';
  static const GET_DANH_SACH_CONG_VIEC_CHI_TIET_NHIEM_VU =
      '/qlvb/api/qlnv/cong-viec/dsbynhiemvu';

  static const GET_LICH_SU_GIAO_VIEC =
      '/qlvb/api/qlnv/cong-viec/lichsugiaoviec';
  static const GET_LICH_SU_TDTT =
      '/qlvb/api/qlnv/cong-viec/lichsuthaydoitrangthai';

  static const GET_LICH_SU_TRA_LAI_NHIEM_VU =
      '/qlvb/api/qlnv/nhiem-vu/lich-su-tra-lai/{id}?';
  static const GET_LICH_SU_TINH_HINH_THUC_HIEN =
      '/qlvb/api/qlnv/nhiem-vu/tinh-hinh-thuc-hien/{id}?';
  static const GET_LICH_SU_THU_HOI_NHIEM_VU =
      '/qlvb/api/qlnv/thu-hoi/lich-su-thu-hoi';
  static const GET_LICH_SU_DON_DOC_NHIEM_VU =
      '/qlvb/api/qlnv/nhiem-vu/lich-su-don-doc';
  static const GET_CHI_TIET_CONG_VIEC = '/qlvb/api/qlnv/cong-viec/chitiet';
  static const GET_VAN_BAN_LIEN_QUAN_NHIEM_VU =
      '/qlvb/api/qlnv/van-ban-lien-quan/{id}?';
  static const GET_LUONG_XU_LY_NHIEM_VU = '/qlvb/api/qlnv/nhiem-vu/luong-xu-ly';
  static const String UPLOAD_FILE = '/qlvb/api/Common/UploadMultiFile';
  static const POST_BIEU_DO_THEO_DON_VI = '/qlvb/api/qlnv/ccvc/bieu-do-don-vi';
  static const GET_NHIEM_VU_THEO_DON_VI = '/qlvb/api/qlnv/get-tinh-hinh-thuc-hien-theo-don-vi';



}

class ImageConstants {
  static const String noImageFound =
      'https://ccvc-uat.chinhquyendientu.vn/img/no-images-found.816e59fa.png';
}
