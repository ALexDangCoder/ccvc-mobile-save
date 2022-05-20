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
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    thamGiaCubit.getTree();
    baoCaoCubit.callApi(
      DateTime.now().toStringWithListFormat,
      DateTime.now().toStringWithListFormat,
    );
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
                            cubit: thamGiaCubit,
                            listSelectNode: snapshot.data ?? [],
                            onChange: (value) {
                              thamGiaCubit.addPeopleThamGia(
                                value.map((e) => e.value).toList(),
                              );
                            },
                            onSearch: (
                              String startDate,
                              String endDate,
                              List<String> donViID,
                            ) {
                              baoCaoCubit.callApi(
                                startDate,
                                endDate,
                                listDonVi: donViID,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    title: S.current.tim_kiem,
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
          color: colorF9FAFF,
        ),
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', S.current.something_went_wrong),
          stream: baoCaoCubit.stateStream,
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
                          height: 550,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color05OpacityDBDFEF),
                            boxShadow: [
                              BoxShadow(
                                color: color6566E9.withOpacity(0.05),
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
                                    title:
                                        S.current.tinh_trang_thuc_hien_yknd,
                                    chartData: listDataChart,
                                    onTap: (int value) {},
                                  );
                                },
                              ),
                              Container(height: 20),
                              StreamBuilder<DashBroadItemYKNDModel>(
                                stream: baoCaoCubit.listChartDashBoard,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ??
                                      DashBroadItemYKNDModel();
                                  return Row(
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Expanded(
                                        child: BoxStatusVanBan(
                                          value: data.trongHan ?? 0,
                                          onTap: () {},
                                          color: color5A8DEE,
                                          statusName: S.current.trong_han,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: BoxStatusVanBan(
                                          value: data.quaHan ?? 0,
                                          onTap: () {},
                                          color: colorEA5455,
                                          statusName: S.current.den_han,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
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
                            border: Border.all(color: color05OpacityDBDFEF),
                            boxShadow: [
                              BoxShadow(
                                color: color6566E9.withOpacity(0.05),
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
                              ChartLinhVucXuLyWidget(
                                cubit: baoCaoCubit,
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
                          height: 450,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color05OpacityDBDFEF),
                            boxShadow: [
                              BoxShadow(
                                color: color6566E9.withOpacity(0.05),
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
                              ChartSoLuongByMonthWidget(cubit: baoCaoCubit),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color05OpacityDBDFEF),
                            boxShadow: [
                              BoxShadow(
                                color: color6566E9.withOpacity(0.05),
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
                              ChartDonViXuLyWidget(
                                cubit: baoCaoCubit,
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
          color: color3D5586,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
