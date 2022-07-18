const FOLDER = 0;
const REPORT = 1;
const String SUCCESS = 'success';
enum AppMode { LIGHT, DARK }
enum DeviceType { MOBILE, TABLET }
enum ServerType { DEV, QA, STAGING, PRODUCT }

enum LoadingType { REFRESH, LOAD_MORE }

enum CompleteType { SUCCESS, ERROR }

const _dtFormat7 = 'dd/MM/yyyy | HH:mm:ss';
const _dtFormat9 = 'yyyy/MM//dd HH:mm:ss.ss';
const _dtFormat10 = 'yyyy-MM-dd HH:mm:ss.ss';
const _dtFormat8 = 'dd/MM/yyyy';

class DateTimeFormat {
  static const DATE_BE_RESPONSE_FORMAT = _dtFormat7;
  static const DATE_FORMAT_TEXT_FIELD = _dtFormat8;
  static const DATE_SELECT_TEXT_FIELD = _dtFormat9;
  static const DATE_ISO_86 = _dtFormat10;

}
