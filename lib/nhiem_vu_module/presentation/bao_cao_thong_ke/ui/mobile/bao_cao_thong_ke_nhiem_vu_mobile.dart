import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chart_data.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/chart_circle.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/chart_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/item_collapse.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/widget_dropdown_filter.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/table_view_nhiem_vu.dart';
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
                                      ChartDataModel('title', 11, Colors.red),
                                      ChartDataModel('title', 11, Colors.black),
                                      ChartDataModel('title', 111, Colors.red)
                                    ],
                                    [
                                      ChartDataModel('title', 1, Colors.red),
                                      ChartDataModel('title', 11, Colors.black),
                                      ChartDataModel('title', 2, Colors.red)
                                    ]
                                  ],
                                  listStatusData: [
                                    ChartDataModel('title', 11, Colors.black),
                                    ChartDataModel('title', 111, Colors.red)
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
                                    ChartDataModel('title', 11, Colors.red),
                                    ChartDataModel('title', 11, Colors.black),
                                    ChartDataModel('title', 111, Colors.red),
                                    ChartDataModel('title', 111, Colors.red),
                                    ChartDataModel('title', 11, Colors.black),
                                    ChartDataModel('title', 111, Colors.red)
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
                                  titleFlex: 1,
                                  chartFlex: 5,
                                  listData: [
                                    [
                                      ChartDataModel('title', 11, Colors.red),
                                      ChartDataModel('title', 11, Colors.black),
                                      ChartDataModel('title', 111, Colors.red)
                                    ],
                                    [
                                      ChartDataModel('title', 1, Colors.red),
                                      ChartDataModel('title', 11, Colors.black),
                                      ChartDataModel('title', 2, Colors.red)
                                    ]
                                  ],
                                  listStatusData: [
                                    ChartDataModel('title', 11, Colors.black),
                                    ChartDataModel('title', 111, Colors.red)
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
                            S.current.nhiem_vu_don_vi_xu_ly,
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
                          left: 16,
                          top: 16,
                          bottom: 16,
                          right: 16,
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
