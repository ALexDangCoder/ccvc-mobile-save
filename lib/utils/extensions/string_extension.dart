import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

extension StringHandle on String {
  String handleString() {
    final String result =
        '${substring(0, 7)}...${substring(length - 10, length)}';
    return result;
  }
}

extension StringMoneyFormat on String {
  String formatMoney(double money) {
    final String result = formatValue.format(money);
    return result;
  }
}

extension VietNameseParse on String {
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

  DateTime convertStringToDate() {
    return DateFormat('yyyy-MM-dd').parse(this);
  }
}

extension StringParse on String {
  String parseHtml() {
    final document = parse(this);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
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

  String? checkEmailBoolean() {
    final isCheck = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}")
        .hasMatch(this);
    if (isCheck) {
      if (this.indexOf('@') >= 64) {
        return S.current.nhap_sai_dinh_dang;
      } else {
        return null;
      }
    } else {
      return S.current.nhap_sai_dinh_dang;
    }
  }

  String? checkPassWordChangePass() {
    final isCheck =
        RegExp(r"^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,32}$")
            .hasMatch(this);
    if (isCheck) {
      return null;
    } else {
      return S.current.nhap_sai_dinh_dang;
    }
  }

  String? checkEmailBoolean() {
    final isCheck = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}")
        .hasMatch(this);
    if (isCheck) {
      if (indexOf('@') >= 64) {
        return S.current.nhap_sai_dinh_dang;
      } else {
        return null;
      }
    } else {
      return S.current.nhap_sai_dinh_dang;
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

  String? checkNull() {
    if (trim().isEmpty) {
      return S.current.khong_duoc_de_trong;
    }
    return null;
  }

  String? checkTruongNull(String name) {
    if (trim().isEmpty) {
      return '${S.current.ban_phai_nhap_truong + name}';
    }
    return null;
  }

  String? checkNulls() {
    if (trim().isEmpty) {
      return S.current.nhap_sai_dinh_dang;
    }
    return null;
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
}
