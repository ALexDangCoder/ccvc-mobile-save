
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';

class BaoChiMangXaHoiResponse {
  int? pageIndex;
  int? totalPages;
  int? totalItems;
  List<PageData>? pageData;
  bool? hasPreviousPage;
  bool? hasNextPage;

  BaoChiMangXaHoiResponse(
      {this.pageIndex,
      this.totalPages,
      this.totalItems,
      this.pageData,
      this.hasPreviousPage,
      this.hasNextPage});

  BaoChiMangXaHoiResponse.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    if (json['pageData'] != null) {
      pageData = <PageData>[];
      json['pageData'].forEach((v) {
        pageData!.add(PageData.fromJson(v));
      });
    }
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }
  List<PressNetWorkModel> toDomain() {
    pageData?.sort((a, b) {
      var aDate = DateTime.parse(a.publishedTime ?? DateTime.now().toString())
          .millisecondsSinceEpoch;
      var bDate = DateTime.parse(b.publishedTime ?? DateTime.now().toString())
          .millisecondsSinceEpoch;
      return aDate.compareTo(bDate);
    });
    return pageData?.map((e) => e.toDomain()).toList() ?? [];
  }
}

class PageData {
  String? id;
  String? title;
  String? link;
  String? avartar;
  String? url;
  String? addressId;
  String? syncDate;
  String? imageSources;
  String? contents;
  int? sourceId;
  String? publishedTime;
  String? domain;
  String? newsId;

  int? likeCount;
  int? commentCount;
  int? shareCount;
  String? topics;
  int? reachCount;
  int? replyCount;
  int? viewCount;

  PageData({
    this.id,
    this.title,
    this.link,
    this.avartar,
    this.url,
    this.addressId,
    this.syncDate,
    this.imageSources,
    this.contents,
    this.sourceId,
    this.publishedTime,
    this.domain,
    this.newsId,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.topics,
    this.reachCount,
    this.replyCount,
    this.viewCount,
  });

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    avartar = json['avartar'];
    url = json['url'];
    addressId = json['addressId'];
    syncDate = json['syncDate'];
    imageSources = json['imageSources'];
    contents = json['contents'];
    sourceId = json['sourceId'];
    publishedTime = json['publishedTime'];
    domain = json['domain'];
    newsId = json['newsId'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    shareCount = json['shareCount'];
    topics = json['topics'];
    reachCount = json['reachCount'];
    replyCount = json['replyCount'];
    viewCount = json['viewCount'];
  }
  PressNetWorkModel toDomain() => PressNetWorkModel(
        avatar: avartar ?? '',
        title: title ?? '',
        publishedTime: publishedTime ?? DateTime.now().toString(),
        url: url ?? '',
        domain: domain ?? '',
      );
}
