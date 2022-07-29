// ignore_for_file: non_constant_identifier_names

import 'dart:core';

enum AppMode { MAC_DINH, XANH, HONG, VANG }
enum DeviceType { MOBILE, TABLET }
enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

enum AuthMode { LOGIN, REGISTER }

enum AuthType { ACCOUNT, PHONE }

enum AppBackGround {
  XUAN,
  HA,
  THU,
  DONG,
  TET_NGUYEN_DAN,
  LE_TINH_NHAN,
  NGAY_QUOC_TE_PHU_NU,
  GIO_TO_HUNG_VUONG,
  NGAY_QUOC_TE_LAO_DONG,
  NGAY_QUOC_TE_THIEU_NHI,
  NGAY_QUOC_KHANH,
  TET_TRUNG_THU,
  NGAY_PHU_NU_VIET_NAM,
  NGAY_LE_GIANG_SINH,
  NGAY_HALLOWEEN,
  NGAY_NHA_GIAO_VIET_NAM
}

enum SelectKey {
  CA_NHAN,
  DON_VI,
  DA_XU_LY,
  HOM_NAY,
  TUAN_NAY,
  THANG_NAY,
  NAM_NAY,
  TUY_CHON,
  CHO_XU_LY_VB_DEN,
  CHO_XU_LY_VB_DI,
  CHO_CHO_Y_KIEN_VB_DEN,
  CHO_XU_LY,
  DANG_XU_LY,
  CHO_TIEP_NHAN,
  LICH_HOP_CUA_TOI,
  LICH_DUOC_MOI,
  LICH_HOP_DUOC_MOI,
  LICH_HOP_CAN_DUYET,
  LICH_DUYET_PHONG,
  LICH_HOP_DUYET_THIET_BI,
  LICH_HOP_DUYET_YEU_CAU_CHUAN_BI,
  CHO_TRINH_KY_VB_DI,
  CHO_VAO_SO,
  CHO_TRINH_KY,
  CHO_CAP_SO,
  CHO_BAN_HANH,
  CHO_PHAN_XU_LY,
  DANG_THUC_HIEN,
  DANH_SACH_CONG_VIEC,
  CHO_DUYET_XU_LY,
  CHO_DUYET_TIEP_NHAN
}
enum DocumentStatus {
  DEN_HAN,
  QUA_HAN,
  CHO_TIEP_NHAN,
  HOAN_THANH,
  CHO_XAC_NHAN,
  THAM_GIA,
  CHO_PHAN_XU_LY,
  HOA_TOC,
  KHAN,
  BINH_THUONG,
  THUONG_KHAN,
  CHUA_THUC_HIEN,
  DANG_THUC_HIEN,
  DA_THUC_HIEN
}
enum PageTransitionType {
  FADE,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  RIGHT_TO_LEFT_WITH_FADE,
}

enum PickerType { MEDIA_FILE, IMAGE_FILE, DOCUMENT, ALL, DOCUMENT_IMG }

extension GetTypeByName on PickerType {
  List<String> get fileType {
    switch (this) {
      case PickerType.MEDIA_FILE:
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF'
        ];
      case PickerType.IMAGE_FILE:
        return ['JPG', 'PNG', 'GIF', 'JPEG'];
      case PickerType.DOCUMENT:
        return ['DOC', 'DOCX', 'PDF', 'XLS', 'XLSX'];
      case PickerType.ALL:
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF',
          'JPG',
          'PNG',
          'GIF',
          'JPEG',
          'DOC',
          'DOCX',
          'PDF',
          'XLS',
          'XLSX'
        ];
      case PickerType.DOCUMENT_IMG:
        return [
          'jpg',
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'png',
          'heic',
        ];
    }
  }
}

const int BYTE_TO_MB = 1000000;
const String DEVICE_ID = '';
const String DEVICE_ANDROID = 'ANDROID';
const String DEVICE_IOS = 'IOS';
const String CAP_NHAT_TINH_HINH_THUC_HIEN = 'CAP_NHAT_TINH_HINH_THUC_HIEN';
const String TRA_LAI = 'TRA_LAI';
const String THU_HOI = 'THU_HOI';
const String LIEN_THONG = 'LIEN_THONG';

const String HOAN_THANH = 'HOAN_THANH';
const String NGUOI_GIAO_ID = 'NguoiGiaoId';
const String DON_VI_THEO_DOI = 'DonViTheoDoi';
const String NGUOI_THEO_DOI = 'NguoiTheoDoi';
const String LIEN_QUAN = 'lienquan';
const String KHAC = 'khac';
const String CHO_TIEP_NHAN = 'CHO_TIEP_NHAN';
const String CHO_XAC_NHAN = 'CHO_XAC_NHAN';
const String THAM_GIA = 'THAM_GIA';
const String QUA_HAN_STRING = 'QUA_HAN';

const String CALENDAR_TYPE_DAY = 'Day';
const String CALENDAR_TYPE_MONTH = 'Month';
const String CALENDAR_TYPE_YEAR = 'Year';
const String ERASE_WALLET = 'earse_wallet';
const String SUCCESS = 'success';
const String FAIL = 'fail';

const double kHeightKeyBoard = 160;
const String TRANSACTION_TOKEN = '0';
const String TRANSACTION_NFT = '1';

const EN_CODE = 'en';
const VI_CODE = 'vi';
const VI_LANG = 'vn';
const EN_US_CODE = 'en_US';
DateTime MAXIMUM_DATE = DateTime(2099, 12, 30);
DateTime MINIMUM_DATE = DateTime(1900);

const int MAXIMUM_YEAR = 2099;
const int MINIMUM_YEAR = 1900;
const EMAIL_REGEX =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const VN_PHONE = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';
const PHONE_REGEX = r'^0+([0-9]{9})$';

//2021-06-18 04:24:27
const _dtFormat1 = 'yyyy-MM-dd HH:mm:ss';
const _dtFormat2 = 'hh:mm a';
const _dtFormat3 = 'dd/MM hh:mm a';
const _dtFormat4 = 'yyyy-MM-dd';
const _dtFormat5 = 'MMM dd, yyyy';
const _dtFormat6 = 'MM/dd/yyyy HH:mm:ss';
const _dtFormat7 = 'dd/MM/yyyy | HH:mm:ss';
const _dtFormat8 = 'd/MM/yyyy';
const _dtFormat9 = 'dd/MM/yyyy HH:mm';
const _dtFormat10 = 'dd/MM/yyyy';
const _dtFormat11 = 'dd-MM-yyyy';
const _dtFormat12 = 'yyyy-MM-ddTHH:mm:ss';
const _dtFormat13 = 'dd/MM/yyyy HH:mm';
const _dtFormat14 = 'yyyy-MM-dd HH:mm:ss.ms';
const _dtFormat15 = 'yyyy-MM-dd HH:mm';
const HOUR_MINUTE_FORMAT = 'Hm';
const _dtFormat16 = 'yyyy-MM-ddT00:00:00';
const _dtFormat17 = 'yyyy-MM-ddT23:59:00';
const _dtFormat18 = 'MM/dd/yyyy HH:mm';
const _dtFormat19 = 'yyyy-MM-ddTHH:mm:ss';
const _dtFormat20 = 'yyyy/MM/dd HH:mm:ss';
const _dtFormat21 = 'yyyy-MM-ddTHH:mm';
const _dtFormat22 = 'yyyy/MM/dd HH:mm';
const _dtFormat23 = 'HH:mm dd/MM/yyyy ';
const _dtFormat24 = 'HH:mm';
const _dtFormat25 = 'HH:mm:ss';
const _dtFormat26 = 'yyyy/MM/dd 00:00:00';
const _dtFormat27 = 'yyyy-MM-dd 00:00:00';
const _dtFormat28 = 'yyyy/MM/dd 23:59:59';
const _dtFormat29 = 'dd-MM';
const START_TIME = '8:00';
const END_TIME = '18:00';
const INIT_TIME_PICK = 'hh:mm';
const INIT_DATE_PICK = 'DD/MM/YYYY';

///Number format
const NUMBER_FORMAT_POINT = '###,###';

const String DO_MAIN_DOWLOAD_FILE = 'http://api-qlvb-nv.dongnai.edsolabs.vn';
const String DO_MAIN_LICH_AM_DUONG = 'https://api-and-uat.chinhquyendientu.vn';
const String AVATAR_DEFAULT =
    'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png';
const String BASE_URL_MEETING = 'https://emeeting.vn/';
const String ENTITY_THU_MOI_HOP = 'ThuMoiHop';
const String ENTITY_TAI_LIEU_HOP = 'TaiLieuHop';
const String ID_PHIEN_HOP = '00000000-0000-0000-0000-000000000000';
const String TIME = '00:00:00';
const String PRIMARY = 'primary';
const String INIT_TIME = '00:00';
const int DA_THAM_GIA = 1;

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
  static const DATE_MM_DD_YYYY = _dtFormat6;
  static const DATE_BE_RESPONSE_FORMAT = _dtFormat7;
  static const DATE_DD_MM_YYYY = _dtFormat8;
  static const DATE_DD_MM_HM = _dtFormat9;
  static const DAY_MONTH_YEAR = _dtFormat10;
  static const DAY_MONTH_YEAR_BETWEEN = _dtFormat11;
  static const DATE_TIME_RECEIVE = _dtFormat12;
  static const DATE_TIME_PICKER = _dtFormat13;
  static const DATE_TIME_PUT = _dtFormat14;
  static const DATE_TIME_PUT_EDIT = _dtFormat15;
  static const DATE_TIME_BE_API_START = _dtFormat16;
  static const DATE_TIME_BE_API_END = _dtFormat17;
  static const DATE_TIME_HM = _dtFormat18;
  static const DATE_TIME_HHT = _dtFormat19;
  static const DATE_TIME_20 = _dtFormat20;
  static const DATE_TIME_21 = _dtFormat21;
  static const DATE_TIME_22 = _dtFormat22;
  static const DATE_TIME_23 = _dtFormat23;
  static const DATE_TIME_24 = _dtFormat24;
  static const DATE_TIME_25 = _dtFormat25;
  static const DATE_TIME_26 = _dtFormat26;
  static const DATE_TIME_27 = _dtFormat27;
  static const DATE_TIME_28 = _dtFormat28;
  static const DATE_TIME_29 = _dtFormat29;
}

class ThongBaoTypeConstant {
  static const String LICH_HOP_MOI = 'LichHopMoi';
  static const String TIN_NHAN_MOI = 'TinNhanMoi';
}

class WidgetTypeConstant {
  static const String TINH_HINH_XU_LY_VAN_BAN = 'TinhHinhXuLyVanBan';
  static const String VAN_BAN = 'VanBanWidGet';
  static const String TONG_HOP_NHIEM_VU = 'TongHopNhiemVu';
  static const String Y_KIEN_NGUOI_DAN = 'YKienNguoiDanTongHop';
  static const String LICH_LAM_VIEC = 'BoxLichLamViec';
  static const String LICH_HOP = 'BoxLichHop';
  static const String BAO_CHI = 'BaoChi';
  static const String DANH_SANH_CONG_VIEC = 'BoxTodoList';
  static const String SU_KIEN_TRONG_NGAY = 'SuKienTrongNgay';
  static const String SINH_NHAT = 'SinhNhat';
  static const String TINH_HINH_XU_LY_Y_KIEN = 'TinhHinhXuLyYKienNguoiDan';
  static const String NHIEM_VU = 'NhienVuWidGet';
  static const String HANH_CHINH_CONG = 'HanhChinhCong';
  static const String LICH_LAM_VIEC_LICH_HOP = 'BoxLichVaHop';
  static const String TONG_HOP_HCC = 'TongHopHCC';
  static const String TIN_BUON = 'TinBuon';
  static const String TINH_HINH_XU_LY_HO_SO_CA_NHAN = 'TinhHinhXuLyHoSoCaNhan';
  static const String DANH_SACH_DICH_VU_CONG = 'DanhSachDichVuCong';
  static const String TiNH_HINH_XU_LY_HO_SO_DON_VI = 'TinhHinhXuLyHoSoDonVi';
  static const String TiNH_HINH_PAKN_CA_NHAN = 'TinhHinhXuLyPAKNCaNhan';
  static const String TiNH_HINH_PAKN_DON_VI = 'PhanAnhKienNghiDonVi';
  static const String DANH_SACH_PAKN = 'YKienNguoiDanTongHop';
}

class DocumentState {
  static const String CHO_XU_LY = 'CHO_XU_LY';
  static const String DANG_XU_LY = 'DANG_XU_LY';
  static const String DA_XU_LY = 'DA_XU_LY';
  static const String CHO_VAO_SO = 'CHO_VAO_SO';
  static const String CHO_TRINH_KY = 'CHO_TRINH_KY';
  static const String CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';
  static const String CHO_CAP_SO = 'CHO_CAP_SO';
  static const String CHO_BAN_HANH = 'CHO_BAN_HANH';
  static const String DEN_HAN = 'DEN_HAN';
  static const String QUA_HAN = 'QUA_HAN';
  static const String TRONG_HAN = 'TRONG_HAN';
  static const String BINH_THUONG = 'BinhThuong';
  static const String KHAN = 'Khan';
  static const String THUONG_KHAN = 'ThuongKhan';
  static const String HOA_TOC = 'HoaToc';
  static const String BINH_THUONG_UPPER = 'BINH_THUONG';
  static const String KHAN_UPPER = 'KHAN';
  static const String THUONG_KHAN_UPPER = 'THUONG_KHAN';
  static const String HOA_TOC_UPPER = 'HOA_TOC';
}

class SelectKeyPath {
  static const KEY_DASH_BOARD_TONG_HOP_NV = 'KEY_DASHBOARD_TONGHOPNV_TYPE';
  static const KEY_DASHBOARDVB = 'KEY_DASHBOARDVB';
  static const KEY_DASHBOARDNV_TIME = 'KEY_DASHBOARDNV_TIME';
  static const KEY_DASHBOARD_TONGHOPNV_TYPE = 'KEY_DASHBOARD_TONGHOPNV_TYPE';

  static const KEY_DASHBOARD_NHIEM_VU_TYPE = 'KEY_DASHBOARD_NHIEM_VU_TYPE';
  static const KEY_DASHBOARD_NHIEM_VU_TIME = 'KEY_DASHBOARD_NHIEM_VU_TIME';
}

class NhiemVuStatus {
  static const TONG_SO_NHIEM_VU = 'TONG_NHIEM_VU';
  static const HOAN_THANH_NHIEM_VU = 'NHIEM_VU_HOAN_THANH';
  static const NHIEM_VU_DANG_THUC_HIEN = 'NHIEM_VU_DANG_THUC_HIEN';
  static const HOAN_THANH_QUA_HAN = 'HOAN_THANH_QUA_HAN';
  static const DANG_THUC_HIEN_TRONG_HAN = 'DANG_THUC_HIEN_TRONG_HAN';
  static const DANG_THUC_HIEN_QUA_HAN = 'DANG_THUC_HIEN_QUA_HAN';
}

class DateFormatApp {
  static String date = 'dd/MM/yyyy';
  static String dateNormal = 'dd/mm/yyyy';
  static String dateUpperCase = 'DD/MM/YYYY';
  static String dateApp = 'dd/MM/YYYY';
  static String dateTime = 'dd/MM/yyyy HH:mm:ss';
  static String dateTimeFormat = 'yyyy/MM/dd';
  static String dateBackEnd = "yyyy-MM-dd'T'HH:mm:ss.SSS";
  static String dateTimeBackEnd = "yyyy-MM-dd'T'HH:mm:ss";
  static String dateSecondBackEnd = "yyyy-MM-dd'T'HH:mm:ss.SS";
  static String timeFormat = 'Hm';
  static String monthDayFormat = 'MM/dd/yyyy HH:mm';
  static String pickDateFormat = 'dd/MM/yyyy HH:mm';
  static String pickDateSearchFormat = 'yyyy-MM-dd';
}

class StatusYKND {
  static const String CHUA_THUC_HIEN_YKND = '1';
  static const String DA_HOAN_THANH_YKND = '8';
  static const String DANG_THUC_HIEN_YKND =
      '2,3,4,5,6,7,9,12,13,14,15,16,18,20,21,22';
  static const String QUA_HAN_YKND = '3';
  static const String DEN_HAN_YKND = '2';
  static const String TRONG_HAN_YKND = '1';
}

class MenuItemConst {
  static const HOP = 'hop';
  static const QUAN_LY_NHIEM_VU = 'quanlynhiemvu';
  static const HANH_CHINH_CONG = 'hanh-chinh-cong';
  static const Y_KIEN_NGUOI_DAN = 'y-kien-nguoi-dan';
  static const QUAN_LY_VA_BAN = 'quan-ly-van-ban';
  static const BAO_CHI_MANG_XA_HOI = 'bao-chi-mang-xa-hoi';
  static const KET_NOI = 'ket-noi';
  static const TIEN_ICH = 'tien-ich';
  static const TUONG_TAC_NOI_BO = 'tuong-tac-noi-bo';
  static const LICH_LAM_VIEC = 'lichlamviec';
  static const BAO_CAO = 'bao-cao';
  static const DIEM_DANH = 'dashboard';
  static const HO_TRO_KY_THUAT = 'ho_tro_ky_thuat';
}

class StatusCodeConst {
  static int STATUS_CONTINUE = 100;
  static int STATUS_SWITCHING_PROTOCOLS = 101;
  static int STATUS_PROCESSING = 102;

  static int STATUS_OK = 200;
  static int STATUS_CREATED = 201;
  static int STATUS_ACCEPTED = 202;
  static int STATUS_NON_AUTHORITATIVE_INFO = 203;
  static int STATUS_NO_CONTENT = 204;
  static int STATUS_RESET_CONTENT = 205;
  static int STATUS_PARTIAL_CONTENT = 206;
  static int STATUS_MULTI_STATUS = 207;
  static int STATUS_ALREADY_REPORTED = 208;

  static int STATUS_MULTIPLE_CHOICES = 300;
  static int STATUS_MOVED_PERMANENTLY = 301;
  static int STATUS_FOUND = 302;
  static int STATUS_SEE_OTHER = 303;
  static int STATUS_NOT_MODIFIED = 304;
  static int STATUS_USE_PROXY = 305;

  static int STATUS_BAD_REQUEST = 400;
  static int STATUS_UNAUTHORIZED = 401;
  static int STATUS_FORBIDDEN = 403;
  static int STATUS_NOT_FOUND = 404;
  static int STATUS_METHOD_NOT_ALLOWED = 405;
  static int STATUS_NOT_ACCEPTABLE = 406;
  static int STATUS_REQUEST_TIMEOUT = 408;
  static int STATUS_CONFLICT = 409;
  static int STATUS_GONE = 410;

  static int STATUS_INTERNAL_SERVER_ERROR = 500;
  static int STATUS_NOT_IMPLEMENTED = 501;
  static int STATUS_BAD_GATEWAY = 502;
  static int STATUS_SERVICE_UNAVAILABLE = 503;
  static int STATUS_GATEWAY_TIMEOUT = 504;
  static int STATUS_HTTP_VERSION_NOT_SUPPORTED = 505;
}

class PermissionConst {
  static String VB_DEN_VAO_SO_VAN_BAN_BANG_TAY = 'quan-ly-loai-so-van-ban';
}

class StatusOfficersConst {
  static const int STATUS_CHO_XAC_NHAN = 0;
  static const int STATUS_THAM_GIA = 1;
  static const int STATUS_TU_CHOI = 2;
  static const int STATUS_THU_HOI = 4;
  static const int STATUS_DEFAULT = -1;
}

class EnumScheduleStatus {
  // Nháp
  static const int Draft = 1;

  // Chờ duyệt
  static const int Registered = 2;

  // Đã duyệt
  static const int Approved = 3;

  // Từ chối duyệt
  static const int Rejected = 4;

  //Thu hồi
  static const int Revoked = 5;

  // Xóa
  static const int Deleted = 6;

  //Done
  static const int Done = 7;

  //Hủy
  static const int Cancel = 8;
}

class MaxSizeFile {
  static const MAX_SIZE_30MB = 30000000;
  static const MAX_SIZE_20MB = 20000000.0;
}

class TypeTaskYKien {
  static const int XinYKien = 1;
  static const int ChoYKien = 2;
}

class FileExtensions {
  static const String DOC = 'doc';
  static const String DOCX = 'docx';
  static const String PDF = 'pdf';
  static const String PNG = 'png';
  static const String JPEG = 'jpeg';
  static const String JPG = 'jpg';
  static const String XLSX = 'xlsx';
  static const String PPTX = 'pptx';
}
class PermissionAppTxt{
  static const QUYEN_CU_CAN_BO = 'quyen-cu-can-bo';
  static const LANH_DAO_CO_QUAN = 'lanh-dao-co-quan';
  static const QUYEN_CU_CAN_BO_DI_THAY = 'quyen-cu-can-can-bo-di-thay';
  static const QUYEN_DUYET_PHONG = 'quyen-duyet-phong';
  static const QUYEN_DUYET_THIET_BI = 'quyen-duyet-thiet-bi';
  static const DUYET_KY_THUAT_TTDH = 'duyet-ky-thuat-ttdh';
  static const DUYET_KY_THUAT = 'duyet-ky-thuat';
  static const YEU_CAU_CHUAN_BI = 'yeu-cau-chuan-bi';
  static const QUYEN_DUYET_KET_LUAN_HOP = 'quyen-duyet-ket-luan-hop';
}
class ListDayOffWeek{
  static const CN = 'CN';
  static const T2 = 'T2';
  static const T3 = 'T3';
  static const T4 = 'T4';
  static const T5 = 'T5';
  static const T6 = 'T6';
  static const T7 = 'T7';
}
