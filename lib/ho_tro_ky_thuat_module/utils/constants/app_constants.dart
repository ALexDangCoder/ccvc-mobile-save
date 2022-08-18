const FOLDER = 0;
const REPORT = 1;
const String SUCCESS = 'success';
enum AppMode { LIGHT, DARK }
enum DeviceType { MOBILE, TABLET }
enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

const String dtFormatUpperCase = 'DD/MM/YYYY';
const String dtLowCase = 'dd/mm/yyyy';

const _dtFormat7 = 'dd/MM/yyyy | HH:mm:ss';
const _dtFormat9 = 'yyyy/MM//dd HH:mm:ss.ss';
const _dtFormat10 = 'yyyy-MM-dd HH:mm:ss.ss';
const _dtFormat8 = 'dd/MM/yyyy';


class DateTimeFormat {
  static const DATE_BE_RESPONSE_FORMAT = _dtFormat7;
  static const DATE_SELECT_TEXT_FIELD = _dtFormat9;
  static const DATE_ISO_86 = _dtFormat10;
  static const DATE_TIME_FORMAT_8 = _dtFormat8;
}

const String successCode = '200';
const String QUYEN_TRUONG_PHONG = 'quyen-truong-phong';
const String QUYEN_HO_TRO = 'quyen-xu-ly-ho-tro';
