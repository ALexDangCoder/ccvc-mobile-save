import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/menu_y_kien_nguoi_dan_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/bloc/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_don_vi_xu_ly.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_linh_vu_xu_ly.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_so_luong_by_month.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/search_bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaoCaoThongKeTablet extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const BaoCaoThongKeTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _BaoCaoThongKeTabletState createState() => _BaoCaoThongKeTabletState();
}

class _BaoCaoThongKeTabletState extends State<BaoCaoThongKeTablet> {
  BaoCaoThongKeYKNDCubit baoCaoCubit = BaoCaoThongKeYKNDCubit();
  ThanhPhanThamGiaCubit thamGiaCubit = ThanhPhanThamGiaCubit();
  ThemDonViCubit themDonViCubit = ThemDonViCubit();
  String startDate = '';
  String endDate = '';
  List<String> listDonViID = [];
  List<Node<DonViModel>> _listNode = [];

  @override
  void initState() {
    super.initState();
    thamGiaCubit.getTree(getAll: false);
    final DateTime now = DateTime.now();
    final DateTime preOneMonth = DateTime(now.year, now.month, now.day - 30);
    startDate = preOneMonth.toStringWithListFormat;
    endDate = DateTime.now().toStringWithListFormat;
    baoCaoCubit.callApi(
      startDate,
      endDate,
    );
    _handleDateSearch();
  }

  void _handleDateSearch() {
    eventBus.on<DateSearchEvent>().listen((event) {
      startDate = event.startDate;
      endDate = event.endDate;
      baoCaoCubit.callApi(
        startDate,
        endDate,
        listDonVi: listDonViID,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDiaLogTablet(
                    context,
                    isBottomShow: false,
                    child: StreamBuilder<List<DonViModel>>(
                      stream: thamGiaCubit.listPeopleThamGia,
                      builder: (context, snapshot) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: SearchBaoCaoThongKeWidget(
                            themDonViCubit: themDonViCubit,
                            cubit: thamGiaCubit,
                            listSelectNode: snapshot.data ?? [],
                            onChange: (value) {
                              thamGiaCubit.addPeopleThamGia(
                                value.map((e) => e.value).toList(),
                              );
                            },
                            onSearch: (
                              List<String> donViID,
                            ) {
                              listDonViID = donViID;
                            },
                            startDate: startDate,
                            endDate: endDate,
                            listNode: _listNode,
                          ),
                        );
                      },
                    ),
                    title: S.current.tim_kiem,
                    funcBtnOk: () {},
                  );
                },
                child: SvgPicture.asset(ImageAssets.ic_kinh_to),
              ),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  DrawerSlide.navigatorSlide(
                    context: context,
                    screen: MenuYKIenNguoiDanTablet(
                      cubit: widget.cubit,
                    ),
                  );
                },
                child: SvgPicture.asset(ImageAssets.icMenuCalender),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: const BoxDecoration(
          color: bgQLVBTablet,
        ),
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {
            baoCaoCubit.callApi(
              startDate,
              endDate,
            );
          },
          error: AppException('1', S.current.something_went_wrong),
          stream: baoCaoCubit.stateStream,
          child: RefreshIndicator(
            onRefresh: () async {
              await baoCaoCubit.callApi(
                startDate,
                endDate,
              );
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        height: 88,
                        child: StreamBuilder<List<YKienNguoiDanDashBroadItem>>(
                          initialData: baoCaoCubit.listInitDataBaoCao,
                          stream: baoCaoCubit.listBaoCaoYKND,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return CustomItemCalenderWork(
                                  image: data[index].img ?? '',
                                  typeName: data[index].typeName ?? '',
                                  numberOfCalendars:
                                      data[index].numberOfCalendars ?? 0,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            height: 420,
                            padding: const EdgeInsets.only(
                              left: 24,
                              top: 4,
                              right: 24,
                              bottom: 24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: cellColorborder),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowContainerColor.withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<List<ChartData>>(
                                  stream: baoCaoCubit.streamDashBoardBaoCaoYKND,
                                  builder: (context, snapshot) {
                                    final listDataChart = snapshot.data ?? [];
                                    return PieChart(
                                      crossAxisCount: 1,
                                      flex: 2,
                                      colorTitle: textTitle,
                                      title: S.current.y_kien_nguoi_dan,
                                      chartData: listDataChart,
                                      onTap: (int value) {},
                                      isVectical: false,
                                    );
                                  },
                                ),
                                StreamBuilder<DashBroadItemYKNDModel>(
                                  stream: baoCaoCubit.listChartDashBoard,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ??
                                        DashBroadItemYKNDModel();
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: boxStatus(
                                            value: data.trongHan ?? 0,
                                            color: colorEA5455,
                                            status: S.current.trong_han,
                                          ),
                                        ),
                                        Expanded(
                                          child: boxStatus(
                                            value: data.denHan ?? 0,
                                            color: yellowColor,
                                            status: S.current.den_han,
                                          ),
                                        ),
                                        Expanded(
                                          child: boxStatus(
                                            value: data.quaHan ?? 0,
                                            color: color02C5DD,
                                            status: S.current.qua_han,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: cellColorborder),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowContainerColor.withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textviewTitle(S.current.linh_vuc_xu_ly),
                                spaceH24,
                                SizedBox(
                                  height: 326,
                                  child: ChartLinhVucXuLyWidget(
                                    cubit: baoCaoCubit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            height: 385,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: cellColorborder),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowContainerColor.withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textviewTitle(S.current.don_vi_xu_ly),
                                spaceH10,
                                SizedBox(
                                  height: 294,
                                  child: SingleChildScrollView(
                                    child: ChartDonViXuLyWidget(
                                      cubit: baoCaoCubit,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Container(
                            height: 385,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: cellColorborder),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowContainerColor.withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textviewTitle(S.current.so_luong_yknd),
                                spaceH10,
                                ChartSoLuongByMonthWidget(cubit: baoCaoCubit),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textviewTitle(String title) {
    return Text(
      title,
      style: textNormalCustom(
        color: textTitle,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  Widget boxStatus(
      {required int value, required String status, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38,
          color: color,
          child: Center(
            child: Text(
              value.toString(),
              style: textNormalCustom(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        spaceH20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            spaceW12,
            Text(
              '$status($value)',
              style: textNormalCustom(
                color: color667793,
                fontSize: 16,
              ),
            ),
          ],
        )
      ],
    );
  }
}
