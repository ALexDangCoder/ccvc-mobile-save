import 'dart:async';
import 'dart:io';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

Future<bool> getHttp() async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
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
    if (await getHttp()) {
      return true;
    } else {
      return false;
    }
  }
}
