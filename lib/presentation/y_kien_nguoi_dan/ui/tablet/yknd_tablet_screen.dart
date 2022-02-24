import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/nguoi_dan_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/ui/tablet/danh_sach_yknd_tablet.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y__kien_nguoi_dan_item.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/menu_y_kien_nguoi_dan_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/row_indicator_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/y__kien_nguoi_dan_item_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuYKIenNguoiDanTablet(
                    cubit: cubit,
                  ),
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuUnFocus),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChooseTimeScreen(
              today: DateTime.now(),
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
            Container(
              color: bgQLVBTablet,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PieChart(
                                isSubjectInfo: false,
                                title: S.current.tinh_hinh_y_kien_nguoi_dan,
                                chartData: cubit.chartPhanLoaiYKND,
                                onTap: (int value) {},
                              ),
                              RowIndicatorSmallTablet(
                                chartData: cubit.chartPhanLoaiYKND,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PieChart(
                                isSubjectInfo: false,
                                title: S.current.phan_loai_yknd,
                                chartData: cubit.chartYKienNduoiDan,
                                onTap: (int value) {},
                              ),
                              RowIndicatorTablet(
                                chartData: cubit.chartYKienNduoiDan,
                              ),
                              Container(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: BoxStatusVanBan(
                                  value:
                                      cubit.dashboardModel.soLuongTrongHan ?? 0,
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
                                      cubit.dashboardModel.soLuongDenHan ?? 0,
                                  onTap: () {},
                                  color: statusCalenderRed,
                                  statusName: S.current.den_han,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: BoxStatusVanBan(
                                  value:
                                      cubit.dashboardModel.soLuongQuaHan ?? 0,
                                  onTap: () {},
                                  color: textColorForum,
                                  statusName: S.current.qua_han,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BoxStatusVanBan(
                                        value: cubit.dashboardModel
                                                .soLuongTrongHan ??
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
                                        value: cubit
                                                .dashboardModel.soLuongQuaHan ??
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
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.danh_sach_y_kien_nguoi_Dan,
                        style: textNormalCustom(
                          color: textTitle,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      buttonChitiet(S.current.xem_danh_sah_chi_tiet, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DanhSachYKNDTablet(),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.listYKienNguoiDan.length < 3
                        ? cubit.listYKienNguoiDan.length
                        : 3,
                    itemBuilder: (context, index) {
                      return YKienNguoiDanCellTablet(
                        onTap: () {},
                        title: cubit.listYKienNguoiDan[index].ngheNghiep ?? '',
                        dateTime:
                            cubit.listYKienNguoiDan[index].ngayThang ?? '',
                        userName: cubit.listYKienNguoiDan[index].ten ?? '',
                        stausColor: cubit.listYKienNguoiDan[index].statusData
                            .getText()
                            .color,
                        status: cubit.listYKienNguoiDan[index].statusData
                            .getText()
                            .text,
                        userImage:
                            'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
