import 'dart:async';
import 'dart:io';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

Future<bool> getHttp() async {
  try {
    final http.Response response = await http
        .get(Uri.parse(ApiConstants.DOMAIN_GOOGLE))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == StatusCodeConst.STATUS_OK) {
      return true;
    } else {
      return false;
    }
  } on TimeoutException {
    return false;
  } on SocketException {
    return false;
  }
}

class CheckerNetwork {
  static Future<bool> checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (await getHttp()) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
