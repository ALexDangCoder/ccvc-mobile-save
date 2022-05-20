import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

class DashBoardItemTatCaChuDeModel {
  int sourceId;
  String sourceTitle;
  int total;

  DashBoardItemTatCaChuDeModel({
    required this.sourceId,
    required this.sourceTitle,
    required this.total,
  });
}

class ItemInfomationModel {
  final String image;
  final Color color;
  final String title;
  final String index;

  const ItemInfomationModel({
    required this.image,
    required this.color,
    required this.title,
    required this.index,
  });
}

class DashBoardModel {
  List<ItemInfomationModel>listItemDashBoard;
  DashBoardModel({required this.listItemDashBoard});
}

List<String> listIconDashBoard = [
  ImageAssets.icTongTin,
  ImageAssets.icBaoChi,
  ImageAssets.icMangXaHoi,
  ImageAssets.icForum,
  ImageAssets.icBlog,
  ImageAssets.icNguonKhac,
];
List<Color> listColorsItemDashBoard = [
  color39CEAD,
  colorF763A0,
  color2F80ED,
  colorFF9F43,
  textColorBlog,
  colorF57168,
];

