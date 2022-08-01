import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

Future<bool> getHttp() async {

  final options = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  final Dio dio = Dio(options);
  try {
    final response = await dio.get('https://www.google.com');
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
