import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

extension StringHandle on String {
  String handleString() {
    final String result =
        '${substring(0, 7)}...${substring(length - 10, length)}';
    return result;
  }

  String get removeSpace => trim().replaceAll(' +', ' ');

  String get removeSpaceHtml => trim().replaceAll('&nbsp;', '');
}

extension StringMoneyFormat on String {
  String formatMoney(double money) {
    final String result = formatValue.format(money);
    return result;
  }
}

extension VietNameseParse on String {
  String get textToCode => split(' ').join('_').toUpperCase().vietNameseParse();

  String vietNameseParse() {
    var result = this;

    const _vietnamese = 'aAeEoOuUiIdDyY';
    final _vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
    ];

    for (var i = 0; i < _vietnamese.length; ++i) {
      result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
    }
    return result;
  }
}

extension FormatAddressConfirm on String {
  String formatAddressWalletConfirm() {
    final String result = '${substring(0, 10)}...${substring(
      length - 9,
      length,
    )}';
    return result;
  }

  String changeToNewPatternDate(String oldPattern, String newPattern) {
    try {
      return DateFormat(newPattern).format(DateFormat(oldPattern).parse(this));
    } catch (_) {
      return '';
    }
  }

  String get getTime {
    final DateTime date = DateTime.parse(this);

    if (date.minute < 10 && date.hour < 10) {
      return '0${date.hour}:0${date.minute}';
    }

    if (date.hour < 10) {
      return '0${date.hour}:${date.minute}';
    }
    if (date.minute < 10) {
      return '${date.hour}:0${date.minute}';
    }
    return '${date.hour}:${date.minute}';
  }

  String formatTimeWithJm(String pattern) {
    try {
      return DateFormat.jm('en').format(DateFormat(pattern).parse(this));
    } catch (_) {
      return '';
    }
  }

  DateTime getOnlyDate(String dateString) {
    final date = dateString.convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_RECEIVE,
    );
    return DateTime(date.year, date.month, date.day);
  }

  bool checkBeforeAfterDate({
    required DateTime compareDate,
    bool checkBefore = true,
  }) {
    try {
      final DateTime currentDate = getOnlyDate(this);
      final compareDateOnlyDate = DateTime(
        compareDate.year,
        compareDate.month,
        compareDate.day,
      );
      final compareValue = currentDate.compareTo(compareDateOnlyDate);
      if ((compareValue == -1 && checkBefore) ||
          (compareValue == 1 && !checkBefore)) {
        return true;
      }
    } catch (_) {}
    return false;
  }

  DateTime convertStringToDate({String formatPattern = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(formatPattern).parse(this);
    } catch (_) {
      return DateTime.now();
    }
  }

  TimerData? getTimeData({TimerData? timeReturnParseFail}) {
    if (isEmpty) {
      return timeReturnParseFail;
    }
    try {
      final List<String> timeSplit = split(':');
      final int hour = int.parse(timeSplit.first);
      final int minute = int.parse(timeSplit.last);
      return TimerData(hour: hour, minutes: minute);
    } catch (e) {
      return timeReturnParseFail;
    }
  }
}

extension StringParse on String {
  String parseHtml() {
    final document = parse(this);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }

  bool get isExensionOfFile {
    final document = this;
    final int startOfSubString = document.lastIndexOf('/');

    final subString = document.substring(startOfSubString + 1, document.length);
    return subString.contains('.');
  }

  String convertNameFile() {
    final document = this;

    final parts = document.split('/');

    final lastName = parts.last;

    final partsNameFile = lastName.split('.');

    if (partsNameFile[0].length > 30) {
      partsNameFile[0] = '${partsNameFile[0].substring(0, 10)}... ';
    }
    final fileName = '${partsNameFile[0]}.${partsNameFile[1]}';

    return fileName;
  }

  String get nameOfFile {
    var fileName = '';
    if (isNotEmpty) {
      final document = this;

      final parts = document.split('/');

      final lastName = parts.last;

      final partsNameFile = lastName.split('.');
      if (partsNameFile.isNotEmpty) {
        if (partsNameFile[0].length > 30) {
          partsNameFile[0] = '${partsNameFile[0].substring(0, 20)}... ';
        }
        fileName = '${partsNameFile.first}.${partsNameFile[1]}';
      }
    }
    return fileName;
  }

  int stringToInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return 0;
    }
  }

  int? dayToIdLichLap() {
    switch (this) {
      case 'Thứ Hai':
        return 1;
      case 'Thứ Ba':
        return 2;
      case 'Thứ Tư':
        return 3;
      case 'Thứ Năm':
        return 4;
      case 'Thứ Sáu':
        return 5;
      case 'Thứ Bảy':
        return 6;
      case 'Chủ nhât':
        return 7;
    }
  }

  String formatTime() {
    /// format 8:00 to 08:00
    try {
      String h = split(':').first;
      final hour = int.parse(split(':').first);
      if (hour <= 9) {
        h = '0$hour';
      }
      return '$h:${split(':').last}';
    } catch (e) {
      return this;
    }
  }
}

extension CheckValidate on String {
  String? checkEmail() {
    final isCheck = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}")
        .hasMatch(this);
    if (isCheck) {
      return null;
    } else {
      return S.current.dinh_dang_email;
    }
  }

  String? checkKyTuVietNam() {
    final isCheck = !RegExp(
            r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ|À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ|è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ|'
            r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ|ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ|Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ|'
            r"ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ|Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ|ì|í|ị|ỉ|ĩ|Ì|Í|Ị|Ỉ|Ĩ|đ|Đ|ỳ|ý|ỵ|ỷ|ỹ|Ỳ|Ý|Ỵ|Ỷ|Ỹ")
        .hasMatch(this);
    if (isCheck) {
      return null;
    } else {
      return S.current.nhap_sai_dinh_dang;
    }
  }

  String? checkEmailBoolean({String? errMessage}) {
    final isCheck = RegExp(
      REGEX_EMAIL,
    ).hasMatch(this);
    if (isCheck) {
      if ((indexOf('@')) > 64 || (length - indexOf('.') - 1) > 254) {
        return errMessage ?? S.current.nhap_sai_dinh_dang;
      } else {
        return null;
      }
    } else {
      return errMessage ?? S.current.nhap_sai_dinh_dang;
    }
  }

  String? validateEmail({String? errMessage}) {
    final isCheck = RegExp(
      REGEX_EMAIL,
    ).hasMatch(this);
    if (isCheck) {
      if ((indexOf('@')) > 64 || (length - indexOf('@') - 1) > 254) {
        return errMessage ?? S.current.nhap_sai_dinh_dang;
      } else {
        return null;
      }
    } else {
      return errMessage ?? S.current.nhap_sai_dinh_dang;
    }
  }

  String? checkEmailBoolean2(String text) {

    final isCheck = RegExp(
      REGEX_EMAIL,
    ).hasMatch(trim());
    if (isCheck) {
      if ((indexOf('@')) > 64 || (length - indexOf('.') - 1) > 254) {
        return '${S.current.sai_dinh_dang_truong} $text';
      } else {
        return null;
      }
    } else {
      return '${S.current.sai_dinh_dang_truong} $text!';
    }
  }

  String? checkPassWordChangePass(String name) {
    final isCheck = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,32}$')
        .hasMatch(this);
    if (isCheck) {
      return null;
    } else {
      return '${S.current.sai_dinh_dang_truong} $name';
    }
  }

  bool? checkSdtDinhDangTruong() {
    final isCheckSdt = RegExp(PHONE_REGEX).hasMatch(this);
    if (isCheckSdt) {
      return true;
    } else {
      return false;
    }
  }

  bool? checkEmailBooleanDinhDangTruong() {
    final isCheck = RegExp(
      r'^[a-zA-Z0-9]+([\.{1}][a-zA-Z0-9]+)?@[a-zA-Z0-9]+(\.[a-zA-Z]{2,})?(\.[a-zA-Z]{2,})$',
    ).hasMatch(this);
    if (isCheck) {
      if ((indexOf('@')) > 64 || (length - indexOf('.') - 1) > 254) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  String? checkSdt() {
    final isCheckSdt = RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(this);
    if (isCheckSdt) {
      return null;
    } else {
      return S.current.dinh_dang_sdt;
    }
  }

  String? checkSdtRequire({String? messageError}) {
    final isCheckSdt = RegExp(PHONE_REGEX).hasMatch(this);
    if (isCheckSdt) {
      return null;
    } else {
      return messageError ?? S.current.nhap_sai_dinh_dang;
    }
  }

  String? checkSdtRequire2(String text) {
    final isCheckSdt = RegExp(PHONE_REGEX_NO_LENGTH).hasMatch(this);
    if (isCheckSdt) {
      return null;
    } else {
      return '${S.current.sai_dinh_dang_truong}' ' $text!';
    }
  }

  String? checkSdtRequire3(String text) {
    final isCheckSdt = RegExp(PHONE_REGEX).hasMatch(this);
    if (isCheckSdt) {
      return null;
    } else {
      return '${S.current.sai_dinh_dang_truong}' ' $text!';
    }
  }

  String? validateCopyPaste() {
    final isCheck = RegExp('[^0-9]').hasMatch(this);
    if (isCheck) {
      return null;
    } else {
      return S.current.nhap_sai_dinh_dang;
    }
  }

  String? checkNull({String? showText}) {
    if (trim().isEmpty) {
      return showText ?? S.current.khong_duoc_de_trong;
    }
    return null;
  }

  String? validatorTitle() {
    if (trim().isEmpty) {
      return S.current.ban_phai_nhap_truong_tieu_de;
    }
    return null;
  }

  String? validatorLocation() {
    if (trim().isEmpty) {
      return S.current.location_warning;
    }
    return null;
  }

  String? checkTruongNull(String name,{bool?isCheckLength=false,bool?isTruongBatBuoc}) {
    if (trim().isEmpty) {
      return '${isTruongBatBuoc==true?S.current.truong_bat_buoc:S.current.ban_phai_nhap_truong} $name';
    }
    if(length>20&&isCheckLength==true){
      return S.current.nhap_toi_da_20_ky_tu;
    }
    return null;
  }

  String? pleaseEnter(String name) {
    if (trim().isEmpty) {
      return '${S.current.please_enter} ${name.toLowerCase()}';
    }
    return null;
  }

  String? pleaseChoose(String name) {
    if (trim().isEmpty) {
      return '${S.current.please_choose} $name';
    }
    return null;
  }

  String? checkNulls() {
    if (trim().isEmpty) {
      return S.current.nhap_sai_dinh_dang;
    }
    return null;
  }

  String? checkRegex() {
    final isCheckSdt = RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(this);
    if (isCheckSdt) {
      return null;
    } else {
      return S.current.dinh_dang_sdt;
    }
  }

  String? checkInt() {
    final result = checkNull();
    if (result != null) {
      return result;
    }
    try {
      int.parse(this);
    } catch (e) {
      return S.current.check_so_luong;
    }
  }

  String svgToTheme() {
    final url = split('.').first;
    switch (APP_THEME) {
      case AppMode.MAC_DINH:
        return this;
      case AppMode.XANH:
        return '${url}_xanh.svg';
      case AppMode.HONG:
        return '${url}_hong.svg';
      case AppMode.VANG:
        return '${url}_vang.svg';
    }
  }
}
