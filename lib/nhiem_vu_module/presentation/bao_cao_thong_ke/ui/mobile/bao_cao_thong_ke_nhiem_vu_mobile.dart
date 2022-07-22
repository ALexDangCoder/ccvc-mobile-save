import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/chart_circle.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/chart_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/item_collapse.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/table_view_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/widget_dropdown_filter.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoCaoThongKeNhiemVuMobile extends StatefulWidget {
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit nhiemVuCubit;

  const BaoCaoThongKeNhiemVuMobile(
      {Key? key, required this.danhSachCubit, required this.nhiemVuCubit})
      : super(key: key);

  @override
  _BaoCaoThongKeNhiemVuMobileState createState() =>
      _BaoCaoThongKeNhiemVuMobileState();
}

class _BaoCaoThongKeNhiemVuMobileState
    extends State<BaoCaoThongKeNhiemVuMobile> {
  late BaoCaoThongKeCubit cubit;

  @override
  void initState() {
    cubit = BaoCaoThongKeCubit();
    cubit.getAppID();
    cubit.getDataTheoDonVi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgTabletColor,
      appBar: BaseAppBar(
        title: S.current.bao_cao_thong_ke,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: NhiemVuMenuMobile(
                  cubit: widget.nhiemVuCubit,
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: Column(
        children: [
          FilterDateTimeWidget(
            context: context,
            initStartDate: DateTime.parse(widget.danhSachCubit.ngayDauTien),
            //todo data
            onChooseDateFilter: (startDate, endDate) {
              widget.danhSachCubit.ngayDauTien = startDate.formatApi;
              widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
              widget.danhSachCubit.callApiDashBroash(true);
            },
          ),
          WidgetDropdownFilter(
            cubit: cubit,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: backgroundColorApp,
                    padding: const EdgeInsets.all(16.0),
                    child: ItemCollapse(
                      title: [
                        Expanded(
                          child: Text(
                            S.current.nhiem_vu_don_vi_xu_ly,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().titleColor(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      child: StreamBuilder<bool>(
                        initialData: true, //todo
                        // stream: widget.cubit.checkDataChart,
                        builder: (context, snapshot) {
                          final isCheck = snapshot.data ?? false;
                          return isCheck
                              ? ChartWidget(
                                  listData: [
                                    [
                                      ChartData('title', 11, Colors.red),
                                      ChartData('title', 11, Colors.black),
                                      ChartData('title', 111, Colors.red)
                                    ],
                                    [
                                      ChartData('title', 1, Colors.red),
                                      ChartData('title', 11, Colors.black),
                                      ChartData('title', 2, Colors.red)
                                    ]
                                  ],
                                  listStatusData: [
                                    ChartData('title', 11, Colors.black),
                                    ChartData('title', 111, Colors.red)
                                  ],
                                  listTitle: [
                                    //todo data
                                    'fuck',
                                    'fuck',
                                  ],
                                  cubit: cubit,
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  spaceH6,
                  Container(
                    color: backgroundColorApp,
                    padding: const EdgeInsets.all(16.0),
                    child: ItemCollapse(
                      title: [
                        Expanded(
                          child: Text(
                            S.current.nhiem_vu_theo_tinh_trang_xu_ly,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().titleColor(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      child: StreamBuilder<bool>(
                        initialData: true, //todo
                        // stream: widget.cubit.checkDataChart,
                        builder: (context, snapshot) {
                          final isCheck = snapshot.data ?? false;
                          return isCheck
                              ? ChartCircleWidget(
                                  chartData: [
                                    ChartData('title', 11, Colors.red),
                                    ChartData('title', 11, Colors.black),
                                    ChartData('title', 111, Colors.red),
                                    ChartData('title', 1, Colors.red),
                                    ChartData('title', 11, Colors.black),
                                    ChartData('title', 2, Colors.red),
                                  ],
                                  listChartNote: [
                                    ChartData('title', 11, Colors.red),
                                    ChartData('title', 11, Colors.black),
                                    ChartData('title', 111, Colors.red),
                                    ChartData('title', 111, Colors.red),
                                    ChartData('title', 11, Colors.black),
                                    ChartData('title', 111, Colors.red)
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  spaceH6,
                  Container(
                    color: backgroundColorApp,
                    padding: const EdgeInsets.all(16.0),
                    child: ItemCollapse(
                      title: [
                        Expanded(
                          child: Text(
                            S.current.bieu_do_12_thang,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().titleColor(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      child: StreamBuilder<bool>(
                        initialData: true, //todo
                        // stream: widget.cubit.checkDataChart,
                        builder: (context, snapshot) {
                          final isCheck = snapshot.data ?? false;
                          return isCheck
                              ? ChartWidget(
                                  titleFlex: 2,
                                  listData: [
                                    [
                                      ChartData('title', 11, choXuLyColor),
                                      ChartData('title', 1, chuaThucHienColor),
                                      ChartData('title', 3, dangThucHienColor),
                                      ChartData('title', 4, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 3, choXuLyColor),
                                      ChartData('title', 5, chuaThucHienColor),
                                      ChartData('title', 6, dangThucHienColor),
                                      ChartData('title', 4, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 1, choXuLyColor),
                                      ChartData('title', 5, chuaThucHienColor),
                                      ChartData('title', 7, dangThucHienColor),
                                      ChartData('title', 8, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 3, choXuLyColor),
                                      ChartData('title', 5, chuaThucHienColor),
                                      ChartData('title', 2, dangThucHienColor),
                                      ChartData('title', 10, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 7, choXuLyColor),
                                      ChartData('title', 5, chuaThucHienColor),
                                      ChartData('title', 4, dangThucHienColor),
                                      ChartData('title', 3, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 12, choXuLyColor),
                                      ChartData('title', 20, chuaThucHienColor),
                                      ChartData('title', 21, dangThucHienColor),
                                      ChartData('title', 2, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 3, choXuLyColor),
                                      ChartData('title', 4, chuaThucHienColor),
                                      ChartData('title', 10, dangThucHienColor),
                                      ChartData('title', 14, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 14, choXuLyColor),
                                      ChartData('title', 2, chuaThucHienColor),
                                      ChartData('title', 5, dangThucHienColor),
                                      ChartData('title', 0, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 11, choXuLyColor),
                                      ChartData('title', 11, chuaThucHienColor),
                                      ChartData('title', 20, dangThucHienColor),
                                      ChartData('title', 10, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 1, choXuLyColor),
                                      ChartData('title', 9, chuaThucHienColor),
                                      ChartData('title', 22, dangThucHienColor),
                                      ChartData('title', 10, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 3, choXuLyColor),
                                      ChartData('title', 5, chuaThucHienColor),
                                      ChartData('title', 2, dangThucHienColor),
                                      ChartData('title', 1, daXuLyColor)
                                    ],
                                    [
                                      ChartData('title', 15, choXuLyColor),
                                      ChartData('title', 23, chuaThucHienColor),
                                      ChartData('title', 1, dangThucHienColor),
                                      ChartData('title', 0, daXuLyColor)
                                    ],
                                  ],
                                  listStatusData: [
                                    ChartData(
                                      S.current.cho_phan_xu_ly,
                                      0,
                                      choXuLyColor,
                                    ),
                                    ChartData(
                                      S.current.chua_thuc_hien,
                                      0,
                                      chuaThucHienColor,
                                    ),
                                    ChartData(
                                      S.current.dang_thuc_hien,
                                      0,
                                      dangThucHienColor,
                                    ),
                                    ChartData(
                                      S.current.da_thuc_hien,
                                      0,
                                      daXuLyColor,
                                    ),
                                  ],
                                  listTitle: [
                                    //todo data
                                    'Tháng 12',
                                    'Tháng 11',
                                    'Tháng 10',
                                    'Tháng 9',
                                    'Tháng 8',
                                    'Tháng 7',
                                    'Tháng 6',
                                    'Tháng 5',
                                    'Tháng 4',
                                    'Tháng 3',
                                    'Tháng 2',
                                    'Tháng 1',
                                  ],
                                  cubit: cubit,
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  spaceH6,
                  Container(
                    color: backgroundColorApp,
                    padding: const EdgeInsets.all(16.0),
                    child: ItemCollapse(
                      title: [
                        Expanded(
                          child: Text(
                            S.current.bang_nhiem_vu_theo_don_vi_xu_ly,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().titleColor(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        child: StreamBuilder<List<NhiemVuDonVi>>(
                          stream: cubit.listBangThongKe,
                          builder: (context, snapshot) {
                            return TableViewNhiemVu(
                              list: snapshot.data ?? [],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
