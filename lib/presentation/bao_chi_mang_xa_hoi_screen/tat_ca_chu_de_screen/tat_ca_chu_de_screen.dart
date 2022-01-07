import 'dart:ui';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'hot_new.dart';
import 'item_list_new.dart';
import 'item_table_topic.dart';
import 'item_infomation.dart';

class TatCaChuDeScreen extends StatefulWidget {
  const TatCaChuDeScreen({Key? key}) : super(key: key);

  @override
  State<TatCaChuDeScreen> createState() => _TatCaChuDeScreenState();
}

class _TatCaChuDeScreenState extends State<TatCaChuDeScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  children: const [
                    ItemInfomation(ImageAssets.icTongTin, textColorTongTin,
                        'Tổng tin', '2032'),
                    ItemInfomation(ImageAssets.icBaoChi, textColorBaoChi,
                        'Báo chí', '2032'),
                    ItemInfomation(ImageAssets.icMangXaHoi, textColorMangXaHoi,
                        'Mạng xã hội', '2032'),
                    ItemInfomation(
                        ImageAssets.icForum, textColorForum, 'Forum', '2032'),
                    ItemInfomation(
                        ImageAssets.icBlog, textColorBlog, 'Blog', '2032'),
                    ItemInfomation(ImageAssets.icNguonKhac, textColorNguonKhac,
                        'Nguồn khác', '2032'),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      ItemTableTopic('Tin tổng hợp', '11295'),
                      ItemTableTopic("Các địa phoning", '11295'),
                      ItemTableTopic('Uỷ ban nhân dân tỉnh', '11295'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Tin nổi bật",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF3D5586)),
                ),
                const SizedBox(
                  height: 16,
                ),
                const HotNews(
                    'https://recmiennam.com/wp-content/uploads/2018/01/phong-canh-thien-nhien-dep-1.jpg',
                    'Bản tin tiêu dùng ngày 27/12: Loại gà ăn thực đơn “hạng sang” được săn lùng trong dịp Tết',
                    '5/11/2021  9:10:03 PM',
                    'Ngưng hoạt động gần 3 tháng do dịch, lãnh đạo nhà máy Chang Shin Việt Nam (huyện Vĩnh Cửu ...'),
                ListView.builder(
                  // controller: _scrollController,
                  itemCount: 10,
                  shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const ItemListNews(
                        'https://recmiennam.com/wp-content/uploads/2018/01/phong-canh-thien-nhien-dep-1.jpg',
                        'Những cuộc thương lượng thưởng Tết',
                        "5/11/2021  9:10:03 PM");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
