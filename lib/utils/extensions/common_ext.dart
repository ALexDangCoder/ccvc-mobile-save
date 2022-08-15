import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dowload_file.dart';

Future<void> launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> handleSaveFile({
  required String url,
  required String name,
  Map<String, dynamic>? query,
}) async {
  final status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }
  await saveFile(fileName: name, url: url, query: query)
      .then(
        (value) => MessageConfig.show(
          title: S.current.tai_file_thanh_cong,
        ),
      )
      .onError(
        (error, stackTrace) => MessageConfig.show(
          title: S.current.tai_file_that_bai,
          messState: MessState.error,
        ),
      );
}

void updateLocale() {
  Get.updateLocale(
    Locale.fromSubtags(languageCode: PrefsService.getLanguage()),
  );
}

String getNameFromStatus(int statusCode) {
  switch (statusCode) {
    case 0:
      return 'Đã hoàn thành';
    case 2:
      return 'Đến hạn';
    case 1:
      return 'Quá hạn';
    case 3:
      return 'Trong hạn';
    case 4:
      return 'Không có hạn';
    case 6:
      return 'Trả lại';
    default:
      return '';
  }
}

Color getColorFromStatus(int statusCode) {
  switch (statusCode) {
    case 2:
      return choVaoSoColor;
    case 1:
      return statusCalenderRed;
    case 3:
      return choXuLyColor;
    default:
      return titleColor;
  }
}

Color getColorFromPriorityCode(String code) {
  switch (code) {
    case DocumentState.BINH_THUONG:
      return daXuLyColor;
    case DocumentState.KHAN:
      return choVaoSoColor;
    case DocumentState.THUONG_KHAN:
      return thuongKhanColor;
    case DocumentState.HOA_TOC:
      return statusCalenderRed;
    default:
      return titleColor;
  }
}

Color getColorFromPriorityCodeUpperCase(String code) {
  switch (code) {
    case DocumentState.BINH_THUONG_UPPER:
      return daXuLyColor;
    case DocumentState.KHAN_UPPER:
      return choVaoSoColor;
    case DocumentState.THUONG_KHAN_UPPER:
      return thuongKhanColor;
    case DocumentState.HOA_TOC_UPPER:
      return statusCalenderRed;
    default:
      return titleColor;
  }
}

String getCodeFromTitlePieChart(String title) {
  return title.split(' ').join('_').toUpperCase().vietNameseParse();
}

List<String> statusSearchDocumentInCode(String code) {
  if (code == '') return [];
  if (code == DocumentState.CHO_XU_LY) {
    return [DocumentState.CHO_XU_LY, DocumentState.CHO_PHAN_XU_LY];
  }
  return [code];
}

List<int>? statusSearchDocumentOutCode(String code) {
  if (code == DocumentState.DA_XU_LY) return [];
  if (code == DocumentState.CHO_TRINH_KY) return [1];
  if (code == DocumentState.CHO_XU_LY) return [2];
  if (code == DocumentState.CHO_CAP_SO) return [5];
  if (code == DocumentState.CHO_BAN_HANH) return [6];
  return null;
}

int? statusSearchDocumentInSubCode(String code) {
  if (code == DocumentState.QUA_HAN) return 1;
  if (code == DocumentState.DEN_HAN) return 2;
  if (code == DocumentState.TRONG_HAN) return 3;
  return null;
}
