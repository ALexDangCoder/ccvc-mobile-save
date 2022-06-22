import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

class ChuDeModel {
  String? id;
  String? title;
  String? link;
  String? avartar;
  String? url;
  String? addressId;
  String? publishedTime;
  String? contents;

  ChuDeModel({
    this.id,
    this.title,
    this.link,
    this.avartar,
    this.url,
    this.addressId,
    this.publishedTime,
    this.contents,
  });
  String get formatTimePublished{
  try{

  return DateTime.parse(
  publishedTime ??
  '',
  ).formatApiSSAM;
  }catch(e){
    return '';
  }
}
}

class ListChuDeModel {
  List<ChuDeModel>? getlistChuDe;
  int? totalPages;
  int? totalItems;

  ListChuDeModel({this.getlistChuDe, this.totalPages, this.totalItems});
}
