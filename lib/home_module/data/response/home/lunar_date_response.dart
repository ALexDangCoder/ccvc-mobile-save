import '/home_module/domain/model/home/date_model.dart';

class LunarDateResponse {
  bool? isSuccessed;
  String? message;
  ResultObj? resultObj;

  LunarDateResponse.fromJson(Map<String, dynamic> json) {
    isSuccessed = json['isSuccessed'];
    message = json['message'];
    resultObj = json['resultObj'] != null
        ? ResultObj.fromJson(json['resultObj'])
        : null;
  }
}

class ResultObj {
  String? date;
  String? dateMore;
  String? lunarDate;
  List<String>? lunarDateArray;
  String? currentDate;

  ResultObj({
    this.date,
    this.dateMore,
    this.lunarDate,
    this.lunarDateArray,
    this.currentDate,
  });

  ResultObj.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateMore = json['dateMore'];
    lunarDate = json['lunarDate'];
    lunarDateArray = json['lunarDateArray'].cast<String>();
    currentDate = json['currentDate'];
  }

  DateModel toDomain() => DateModel(
        dateMore: dateMore ?? '',
        lunarDate:
            lunarDateArray?.isNotEmpty ?? false ? lunarDateArray![0] : '',
      );
}
