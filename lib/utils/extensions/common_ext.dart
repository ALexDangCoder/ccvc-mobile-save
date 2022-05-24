import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dowload_file.dart';

Future<void> launchURL(String url) async {
  if (await canLaunch(url)) {
    await canLaunch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> handleSaveFile({required String url, required String name}) async {
  final status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }
  await saveFile(
    name,
    url,
  )
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
    case 1:
      return 'Đến hạn';
    case 2:
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
    case 1:
      return daXuLyColor;
    case 2:
      return statusCalenderRed;
    case 3:
      return choXuLyColor;
    default:
      return titleColor;
  }
}

Color getColorFromPriorityCode(String code) {
  switch (code) {
    case "BinhThuong":
      return daXuLyColor;
    case "Khan":
      return choVaoSoColor;
    case "ThuongKhan":
      return thuongKhanColor;
    case "HoaToc":
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
  if (code == CHO_XU_LY) return [CHO_XU_LY, CHO_PHAN_XU_LY];
  return [code];
}

List<int>? statusSearchDocumentOutCode(String code) {
  if (code == 'DA_XU_LY') return [];
  if (code == 'CHO_TRINH_KY') return [1];
  if (code == 'CHO_XU_LY') return [2];
  return null;
}
