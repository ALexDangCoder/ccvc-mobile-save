import 'package:ccvc_mobile/home_module/data/response/home/get_weather_response.dart';

class WeatherModel {
  bool? isSuccessed;
  String? message;
  ResultObj? resultObj;

  WeatherModel({this.isSuccessed, this.message, this.resultObj});

  WeatherModel.empty();
}
