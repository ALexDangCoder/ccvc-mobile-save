enum AppMode { LIGHT, DARK }
enum DeviceType { MOBILE, TABLET }
enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

enum MenuType { FEED, NOTIFICATIONS, POLICY, LOGOUT }

enum AuthMode { LOGIN, REGISTER }

enum AuthType { ACCOUNT, PHONE }

enum SelectKey {
  CA_NHAN,
  DON_VI,
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
  DANG_THUC_HIEN
}
enum PageTransitionType {
  FADE,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  RIGHT_TO_LEFT_WITH_FADE,
}


enum PickerType { MEDIA_FILE, IMAGE_FILE, DOCUMENT, ALL,DOCUMENT_IMG }

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
const String HOAN_THANH = 'HOAN_THANH';
const String DEN_HAN = 'DEN_HAN';
const String QUA_HAN = 'QUA_HAN';
const String CHO_TIEP_NHAN = 'CHO_TIEP_NHAN';
const String CHO_XAC_NHAN = 'CHO_XAC_NHAN';
const String THAM_GIA = 'THAM_GIA';
const String CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';
const String CHUA_THUC_HIEN = 'CHUA_THUC_HIEN';
const String DA_HOAN_THANH = 'DA_HOAN_THANH';
const String TRA_LAI_VPCP = 'TRA_LAI_VPCP';
const String DANG_THUC_HIEN = 'DANG_THUC_HIEN';

const String CALENDAR_TYPE_DAY = 'Day';
const String CALENDAR_TYPE_MONTH = 'Month';
const String CALENDAR_TYPE_YEAR = 'Year';
const String ERASE_WALLET = 'earse_wallet';
const String SUCCESS = 'success';
const String FAIL = 'fail';

const String STATUS_TRANSACTION_FAIL = '0';
const String STATUS_TRANSACTION_SUCCESS = '1';
const double kHeightKeyBoard = 160;
const String TRANSACTION_TOKEN = '0';
const String TRANSACTION_NFT = '1';

const EN_CODE = 'en';
const VI_CODE = 'vi';
const VI_LANG = 'vn';

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const VN_PHONE = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';

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
}

class DocumentState {
  static const String CHO_XU_LY = 'CHO_XU_LY';
  static const String DANG_XU_LY = 'DANG_XU_LY';
  static const String DA_XU_LY = 'DA_XU_LY';
  static const String CHO_VAO_SO = 'CHO_VAO_SO';
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
  static String dateTime = 'dd/MM/yyyy HH:mm:ss';
  static String dateTimeFormat = 'yyyy/MM/dd';
  static String dateBackEnd = "yyyy-MM-dd'T'HH:mm:ss.SSS";
  static String dateTimeBackEnd = "yyyy-MM-dd'T'HH:mm:ss";
  static String dateSecondBackEnd = "yyyy-MM-dd'T'HH:mm:ss.SS";
}

class NhiemVuLowerCase {
  static const String THU_HOI = 'thu-hoi';
  static const String CHO_PHAN_XU_LY = 'cho-phan-xu-ly';
  static const String CHUA_THUC_HIEN = 'chua-thuc-hien';
  static const String DANG_THUC_HIEN = 'dang-thuc-hien';
  static const String DA_HOAN_THANH = 'da-hoan-thanh';
  static const String TRA_LAI = 'tra-lai';
  static const String QUA_HAN = 'qua-han';
  static const String DEN_HAN = 'den-han';
  static const String TRONG_HAN = 'trong-han';
  static const String NHIEM_VU_DON_VI = 'nhiem-vu-don-vi';
  static const String NHIEM_VU_CP_CPCP = 'nhiem-vu-cp/vpcp';
  static const String NHIEM_VU_UBND_TINH = 'nhiem-vu-ubnd-tinh';
}
