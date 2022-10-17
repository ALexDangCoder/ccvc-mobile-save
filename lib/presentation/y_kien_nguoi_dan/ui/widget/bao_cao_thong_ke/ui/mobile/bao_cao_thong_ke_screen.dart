import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/bloc/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/status_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_don_vi_xu_ly.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_linh_vu_xu_ly.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_so_luong_by_month.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/search_bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaoCaoThongKeScreen extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const BaoCaoThongKeScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _BaoCaoThongKeScreenState createState() => _BaoCaoThongKeScreenState();
}

class _BaoCaoThongKeScreenState extends State<BaoCaoThongKeScreen> {
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
              IconButton(
                onPressed: () {
                  showBottomSheetCustom(
                    context,
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
                  );
                },
                icon: SvgPicture.asset(ImageAssets.ic_search_calendar),
              ),
              GestureDetector(
                onTap: () {
                  DrawerSlide.navigatorSlide(
                    context: context,
                    screen: YKienNguoiDanMenu(
                      cubit: widget.cubit,
                    ),
                  );
                },
                child: SvgPicture.asset(ImageAssets.icMenuCalender),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          baoCaoCubit.callApi(
            startDate,
            endDate,
          );
        },
        error: AppException(S.current.error, S.current.something_went_wrong),
        stream: baoCaoCubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {
            await baoCaoCubit.callApi(
              startDate,
              endDate,
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 14,
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<List<ChartData>>(
                        stream: baoCaoCubit.streamDashBoardBaoCaoYKND,
                        builder: (context, snapshot) {
                          final listDataChart = snapshot.data ?? [];
                          return PieChart(
                            title: S.current.pakn_theo_nguon,
                            chartData: listDataChart,
                            onTap: (int value) {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                textviewTitle(S.current.linh_vuc_xu_ly),
                ChartLinhVucXuLyWidget(
                  cubit: baoCaoCubit,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                textviewTitle(S.current.don_vi_xu_ly),
                ChartDonViXuLyWidget(
                  cubit: baoCaoCubit,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                textviewTitle(S.current.so_luong_yknd),
                ChartSoLuongByMonthWidget(cubit: baoCaoCubit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textviewTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(
        title,
        style: textNormalCustom(
          color: textTitle,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
