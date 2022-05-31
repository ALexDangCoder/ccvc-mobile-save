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
  DANG_THUC_HIEN
}
enum PageTransitionType {
  FADE,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  RIGHT_TO_LEFT_WITH_FADE,
}

const String DEVICE_ID = '';
const String DEVICE_ANDROID = 'ANDROID';
const String DEVICE_IOS = 'IOS';
const String CAP_NHAT_TINH_HINH_THUC_HIEN = 'CAP_NHAT_TINH_HINH_THUC_HIEN';
const String TRA_LAI = 'TRA_LAI';
const String THU_HOI = 'THU_HOI';
const String LIEN_THONG = 'LIEN_THONG';

const String HOAN_THANH = 'HOAN_THANH';

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

const String CHO_TRINH_KY_STRING = 'CHO_TRINH_KY';
const String CHO_XU_LY_STRING = 'CHO_XU_LY';
const String DA_XU_LY_STRING = 'DA_XU_LY';

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
const HOUR_MINUTE_FORMAT = 'Hm';


const String DO_MAIN_DOWLOAD_FILE = 'http://api-qlvb-nv.dongnai.edsolabs.vn';
const String DO_MAIN_LICH_AM_DUONG = 'https://api-and-uat.chinhquyendientu.vn';
const String AVATAR_DEFAULT =
    'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png';

class DateTimeFormat {
  static const DEFAULT_FORMAT = _dtFormat1;
  static const HOUR_FORMAT = _dtFormat2;
  static const CREATE_FORMAT = _dtFormat3;
  static const DOB_FORMAT = _dtFormat4;
  static const CREATE_BLOG_FORMAT = _dtFormat5;
  static const DATE_MM_DD_YYYY = _dtFormat6;
  static const DATE_BE_RESPONSE_FORMAT = _dtFormat7;
  static const DATE_DD_MM_YYYY = _dtFormat8;
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
}

class DocumentState {
  static const String CHO_XU_LY = 'CHO_XU_LY';
  static const String DANG_XU_LY = 'DANG_XU_LY';
  static const String DA_XU_LY = 'DA_XU_LY';
  static const String CHO_VAO_SO = 'CHO_VAO_SO';
  static const String CHO_TRINH_KY = 'CHO_TRINH_KY';
  static const String CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';
  static const String DEN_HAN = 'DEN_HAN';
  static const String QUA_HAN = 'QUA_HAN';
  static const String TRONG_HAN = 'TRONG_HAN';
  static const String BINH_THUONG = 'BinhThuong';
  static const String KHAN = 'Khan';
  static const String THUONG_KHAN = 'ThuongKhan';
  static const String HOA_TOC = 'HoaToc';
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
  static String dateBackEnd = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS';
  static String dateTimeBackEnd = 'yyyy-MM-dd\'T\'HH:mm:ss';
  static String dateSecondBackEnd = 'yyyy-MM-dd\'T\'HH:mm:ss.SS';
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
}

