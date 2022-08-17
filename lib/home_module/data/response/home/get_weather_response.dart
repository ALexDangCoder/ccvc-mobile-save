import 'package:ccvc_mobile/home_module/domain/model/home/weather_model.dart';

class WeatherResponse {
  bool? isSuccessed;
  String? message;
  ResultObj? resultObj;

  WeatherResponse({this.isSuccessed, this.message, this.resultObj});

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    isSuccessed = json['isSuccessed'];
    message = json['message'];
    resultObj = json['resultObj'] != null
        ? ResultObj?.fromJson(json['resultObj'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccessed'] = isSuccessed;
    data['message'] = message;
    data['resultObj'] = resultObj!.toJson();
    return data;
  }

  WeatherModel get toModel => WeatherModel(
        isSuccessed: isSuccessed,
        message: message,
        resultObj: resultObj,
      );
}

class AddressInfo {
  String? address;
  String? code;

  AddressInfo({this.address, this.code});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['code'] = code;
    return data;
  }
}

class Current {
  String? dt;
  int? sunrise;
  int? sunset;
  Temp? temp;
  FeelsLike? feelslike;
  int? pressure;
  int? humidity;
  double? dewpoint;
  double? windspeed;
  int? winddeg;
  List<Weather?>? weather;
  int? clouds;
  int? pop;
  double? uvi;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelslike,
    this.pressure,
    this.humidity,
    this.dewpoint,
    this.windspeed,
    this.winddeg,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
  });

  Current.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? Temp?.fromJson(json['temp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp!.toJson();
    return data;
  }
}

class Daily {
  String? dt;
  int? sunrise;
  int? sunset;
  Temp? temp;
  FeelsLike? feelslike;
  int? pressure;
  int? humidity;
  double? dewpoint;
  double? windspeed;
  int? winddeg;
  List<Weather?>? weather;
  int? clouds;
  int? pop;
  double? uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelslike,
    this.pressure,
    this.humidity,
    this.dewpoint,
    this.windspeed,
    this.winddeg,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'] != null ? Temp?.fromJson(json['temp']) : null;
    feelslike = json['feels_like'] != null
        ? FeelsLike?.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewpoint = json['dew_point'];
    windspeed = json['wind_speed'];
    winddeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['temp'] = temp!.toJson();
    data['feels_like'] = feelslike!.toJson();
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewpoint;
    data['wind_speed'] = windspeed;
    data['wind_deg'] = winddeg;
    data['weather'] =
        weather != null ? weather!.map((v) => v?.toJson()).toList() : null;
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['uvi'] = uvi;
    return data;
  }
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class ResultObj {
  Current? current;
  List<Daily?>? daily;
  AddressInfo? addressInfo;

  ResultObj({this.current, this.daily, this.addressInfo});

  ResultObj.fromJson(Map<String, dynamic> json) {
    current =
        json['current'] != null ? Current?.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current!.toJson();
    return data;
  }
}

class Temp {
  double? min;
  double? max;
  double? day;
  double? night;
  double? eve;
  double? morn;

  Temp({this.min, this.max, this.day, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'] as double;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['day'] = day;

    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}
