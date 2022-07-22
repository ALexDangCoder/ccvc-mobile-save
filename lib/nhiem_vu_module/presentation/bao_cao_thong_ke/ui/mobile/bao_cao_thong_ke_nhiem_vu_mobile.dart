import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/chart_circle.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/chart_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/date_time_filter_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/item_collapse.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/table_view_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/tree_view.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/widget_dropdown_filter.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/widget_fliter_ca_nhan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
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
  late ThemDonViCubit _themDonViCubit;

  @override
  void initState() {
    _themDonViCubit = ThemDonViCubit();
    cubit = BaoCaoThongKeCubit();
    cubit.initTimeRange();
    cubit.getAppID();
    cubit.getTree();
    cubit.getDataTheoDonVi();
    cubit.textDonViXuLyFilter.listen((value) {
      if (cubit.donViId.isNotEmpty) {
        cubit.getCaNhanXuLy();
      }
    });
    cubit.showContent();
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
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        stream: cubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () {
          //todo get api
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: () {
                cubit.isShowCaNhan.add(false);
                cubit.isShowDonVi.add(false);
              },
              child: Column(
                children: [
                  DateTimeFilterWidget(
                    startDate: DateTime.parse(cubit.ngayDauTien),
                    endDate: DateTime.parse(cubit.ngayKetThuc),
                    onChangeStarDate: (String time) {
                      cubit.ngayDauTien = time;
                    },
                    onChangeEndDate: (String time) {
                      cubit.ngayKetThuc = time;
                    },
                  ),
                  WidgetDropdownFilter(
                    cubit: cubit,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        //todo api
                      },
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
                                        color:
                                            AppTheme.getInstance().titleColor(),
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
                                                ChartData(
                                                    'title', 11, Colors.red),
                                                ChartData(
                                                    'title', 11, Colors.black),
                                                ChartData(
                                                    'title', 111, Colors.red)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 1, Colors.red),
                                                ChartData(
                                                    'title', 11, Colors.black),
                                                ChartData(
                                                    'title', 2, Colors.red)
                                              ]
                                            ],
                                            listStatusData: [
                                              ChartData(
                                                  'title', 11, Colors.black),
                                              ChartData(
                                                  'title', 111, Colors.red)
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
                                        color:
                                            AppTheme.getInstance().titleColor(),
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
                                              ChartData(
                                                  'title', 11, Colors.red),
                                              ChartData(
                                                  'title', 11, Colors.black),
                                              ChartData(
                                                  'title', 111, Colors.red),
                                              ChartData('title', 1, Colors.red),
                                              ChartData(
                                                  'title', 11, Colors.black),
                                              ChartData('title', 2, Colors.red),
                                            ],
                                            listChartNote: [
                                              ChartData(
                                                  'title', 11, Colors.red),
                                              ChartData(
                                                  'title', 11, Colors.black),
                                              ChartData(
                                                  'title', 111, Colors.red),
                                              ChartData(
                                                  'title', 111, Colors.red),
                                              ChartData(
                                                  'title', 11, Colors.black),
                                              ChartData(
                                                  'title', 111, Colors.red)
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
                                        color:
                                            AppTheme.getInstance().titleColor(),
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
                                                ChartData(
                                                    'title', 11, choXuLyColor),
                                                ChartData('title', 1,
                                                    chuaThucHienColor),
                                                ChartData('title', 3,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 4, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 3, choXuLyColor),
                                                ChartData('title', 5,
                                                    chuaThucHienColor),
                                                ChartData('title', 6,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 4, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 1, choXuLyColor),
                                                ChartData('title', 5,
                                                    chuaThucHienColor),
                                                ChartData('title', 7,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 8, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 3, choXuLyColor),
                                                ChartData('title', 5,
                                                    chuaThucHienColor),
                                                ChartData('title', 2,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 10, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 7, choXuLyColor),
                                                ChartData('title', 5,
                                                    chuaThucHienColor),
                                                ChartData('title', 4,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 3, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 12, choXuLyColor),
                                                ChartData('title', 20,
                                                    chuaThucHienColor),
                                                ChartData('title', 21,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 2, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 3, choXuLyColor),
                                                ChartData('title', 4,
                                                    chuaThucHienColor),
                                                ChartData('title', 10,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 14, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 14, choXuLyColor),
                                                ChartData('title', 2,
                                                    chuaThucHienColor),
                                                ChartData('title', 5,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 0, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 11, choXuLyColor),
                                                ChartData('title', 11,
                                                    chuaThucHienColor),
                                                ChartData('title', 20,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 10, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 1, choXuLyColor),
                                                ChartData('title', 9,
                                                    chuaThucHienColor),
                                                ChartData('title', 22,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 10, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 3, choXuLyColor),
                                                ChartData('title', 5,
                                                    chuaThucHienColor),
                                                ChartData('title', 2,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 1, daXuLyColor)
                                              ],
                                              [
                                                ChartData(
                                                    'title', 15, choXuLyColor),
                                                ChartData('title', 23,
                                                    chuaThucHienColor),
                                                ChartData('title', 1,
                                                    dangThucHienColor),
                                                ChartData(
                                                    'title', 0, daXuLyColor)
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
                                        color:
                                            AppTheme.getInstance().titleColor(),
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
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180,
              right: 16,
              left: 16,
              child: StreamBuilder<bool>(
                stream: cubit.isShowDonVi,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? StreamBuilder<List<Node<DonViModel>>>(
                          stream: cubit.getTreeDonVi,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <Node<DonViModel>>[];
                            if (data.isNotEmpty) {
                              return Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: colorNumberCellQLVB,
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ),
                                  border: Border.all(
                                    color: borderItemCalender,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 6,
                                    bottom: 19,
                                    top: 16,
                                  ),
                                  keyboardDismissBehavior: isMobile()
                                      ? ScrollViewKeyboardDismissBehavior.onDrag
                                      : ScrollViewKeyboardDismissBehavior
                                          .manual,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return TreeViewWidgetNhiemVu(
                                      selectOnly: true,
                                      themDonViCubit: _themDonViCubit,
                                      node: data[index],
                                      onSelect: (value) {
                                        cubit.onChangeDonVi(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
            Positioned(
              top: 180,
              right: 16,
              left: 16,
              child: StreamBuilder<bool>(
                stream: cubit.isShowCaNhan,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? WidgetFilterCaNhanXuLy(
                          cubit: cubit,
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
