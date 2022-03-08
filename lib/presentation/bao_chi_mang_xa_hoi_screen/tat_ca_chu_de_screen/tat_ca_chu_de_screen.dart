import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/hot_new.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/item_infomation.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/item_list_new.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/item_table_topic.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TatCaChuDeScreen extends StatefulWidget {
  const TatCaChuDeScreen({Key? key}) : super(key: key);

  @override
  State<TatCaChuDeScreen> createState() => _TatCaChuDeScreenState();
}

class _TatCaChuDeScreenState extends State<TatCaChuDeScreen> {
  ScrollController _scrollController = ScrollController();
  BaoChiMangXaHoiBloc baoChiMangXaHoiBloc = BaoChiMangXaHoiBloc();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
    baoChiMangXaHoiBloc.getListTatCaCuDe(
      baoChiMangXaHoiBloc.startDate,
      baoChiMangXaHoiBloc.endDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 130,
                    ),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 2.3,
                      children: const [
                        ItemInfomation(
                          image: ImageAssets.icTongTin,
                          color: textColorTongTin,
                          title: 'Tổng tin',
                          index: '2032',
                        ),
                        ItemInfomation(
                          image: ImageAssets.icBaoChi,
                          color: textColorBaoChi,
                          title: 'Báo chí',
                          index: '2032',
                        ),
                        ItemInfomation(
                          image: ImageAssets.icMangXaHoi,
                          color: textColorMangXaHoi,
                          title: 'Mạng xã hội',
                          index: '2032',
                        ),
                        ItemInfomation(
                          image: ImageAssets.icForum,
                          color: textColorForum,
                          title: 'Forum',
                          index: '2032',
                        ),
                        ItemInfomation(
                          image: ImageAssets.icBlog,
                          color: textColorBlog,
                          title: 'Blog',
                          index: '2032',
                        ),
                        ItemInfomation(
                          image: ImageAssets.icNguonKhac,
                          color: textColorNguonKhac,
                          title: 'Nguồn khác',
                          index: '2032',
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          ItemTableTopic('Tin tổng hợp', '11295'),
                          ItemTableTopic('Các địa phoning', '11295'),
                          ItemTableTopic(
                            'Uỷ ban nhân dân tỉnh',
                            '11295',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Tin nổi bật',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const HotNews(
                      'https://recmiennam.com/wp-content/uploads/2018/01/phong-canh-thien-nhien-dep-1.jpg',
                      'Bản tin tiêu dùng ngày 27/12: Loại gà ăn thực đơn “hạng sang” được săn lùng trong dịp Tết',
                      '5/11/2021  9:10:03 PM',
                      'Ngưng hoạt động gần 3 tháng do dịch, lãnh đạo '
                          'nhà máy Chang '
                          'Shin Việt Nam (huyện Vĩnh Cửu ...',
                    ),
                    const SizedBox(
                      height: 16,
                      child: Divider(
                        color: lineColor,
                        height: 1,
                      ),
                    ),
                    StreamBuilder<List<ChuDeModel>>(
                      stream: baoChiMangXaHoiBloc.listYKienNguoiDan,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return ListView.builder(
                          // controller: _scrollController,
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ItemListNews(
                                  data[index].avartar ?? '',
                                  data[index].title ?? '',
                                  DateTime.parse(
                                    data[index].publishedTime ?? '',
                                  ).formatApiSS,
                                ),
                                const SizedBox(
                                  height: 16,
                                  child: Divider(
                                    color: lineColor,
                                    height: 1,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            TableCalendarWidget(
              onChange: (DateTime startDate, DateTime endDate) {
                baoChiMangXaHoiBloc.startDate = startDate.formatApiStartDay;
                baoChiMangXaHoiBloc.endDate = endDate.formatApiEndDay;
              },
              onSearch: (value) {
                baoChiMangXaHoiBloc.getListTatCaCuDe(
                  baoChiMangXaHoiBloc.startDate,
                  baoChiMangXaHoiBloc.endDate,
                );
              },
              onChangeRange:
                  (DateTime? start, DateTime? end, DateTime? focusedDay) {},
            ),
          ],
        ),
      ),
    );
  }
}
