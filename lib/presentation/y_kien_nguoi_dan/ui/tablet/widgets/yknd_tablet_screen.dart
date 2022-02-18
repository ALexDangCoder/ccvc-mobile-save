import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class YKNDScreenTablet extends StatefulWidget {
  const YKNDScreenTablet({Key? key}) : super(key: key);

  @override
  _YKNDScreenTabletState createState() => _YKNDScreenTabletState();
}

class _YKNDScreenTabletState extends State<YKNDScreenTablet>
    with SingleTickerProviderStateMixin {
  YKienNguoiDanCubitt cubit = YKienNguoiDanCubitt();
  OutgoingDocumentCubit outgoingDocumentCubit = OutgoingDocumentCubit();
  IncomingDocumentCubit incomingDocumentCubit = IncomingDocumentCubit();
  late TabController controller;

  late ScrollController scrollController;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    super.initState();
    outgoingDocumentCubit.callAPi();
    incomingDocumentCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: const YKienNguoiDanMenu(),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.ic_mennu_ykien,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ChooseTimeScreen(
                today: DateTime.now(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 88,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.list.length,
                    itemBuilder: (context, index) {
                      return CustomItemCalenderWork(
                        image: cubit.img[index],
                        typeName: cubit.list[index].typeName,
                        numberOfCalendars: cubit.list[index].numberOfCalendars,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  color: bgQLVBTablet,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColor.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PieChart(
                                title: S.current.tinh_hinh_y_kien_nguoi_dan,
                                chartData: cubit.chartPhanLoaiYKND,
                                onTap: (int value) {},
                              ),
                              Container(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: BoxStatusVanBan(
                                      value: cubit
                                              .dashboardModel.soLuongTrongHan ??
                                          0,
                                      onTap: () {},
                                      color: numberOfCalenders,
                                      statusName: S.current.trong_han,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: BoxStatusVanBan(
                                      value:
                                          cubit.dashboardModel.soLuongQuaHan ??
                                              0,
                                      onTap: () {},
                                      color: statusCalenderRed,
                                      statusName: S.current.qua_han,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: BoxStatusVanBan(
                                      value: cubit.dashboardModel
                                              .soLuongThuongKhan ??
                                          0,
                                      onTap: () {},
                                      color: textColorForum,
                                      statusName: S.current.thuong_khan,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              PieChart(
                                title: S.current.phan_loai_nguon_yknd,
                                chartData: cubit.chartYKienNduoiDan,
                                onTap: (int value) {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: bgQLVBTablet,
                  height: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
