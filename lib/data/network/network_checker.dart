import 'dart:async';

import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';



Future<bool> getHttp() async {

  const int _receiveTimeout = 3000;
  const int _connectTimeout = 5000;

  final options = BaseOptions(
    connectTimeout: _connectTimeout,
    receiveTimeout: _receiveTimeout,
  );
  final Dio dio = Dio(options);
  try {
    final response = await dio.get(ApiConstants.DOMAIN_GOOGLE);
    if(response.redirects.isNotEmpty){
      return false;
    } else {
      return true;
    }
  } catch (e) {
    return false;
  }
}

class CheckerNetwork {
  static Future<bool> checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
       if(await getHttp()){
        return true;
       } else {
         return false;
       }
    }
    return false;
  }
}
