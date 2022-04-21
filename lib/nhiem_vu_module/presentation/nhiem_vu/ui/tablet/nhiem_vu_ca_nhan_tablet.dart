import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/danh_sach_cong_viec_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/danh_sach_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NhiemVuCaNhanTablet extends StatefulWidget {
  final NhiemVuCubit cubit;
  final bool isCheck;

  const NhiemVuCaNhanTablet({
    Key? key,
    required this.cubit,
    required this.isCheck,
  }) : super(key: key);

  @override
  _NhiemVuCaNhanTabletState createState() => _NhiemVuCaNhanTabletState();
}

class _NhiemVuCaNhanTabletState extends State<NhiemVuCaNhanTablet> {
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  DanhSachCubit danhSachCubit = DanhSachCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    danhSachCubit.callApi(true);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: backgroundColorApp,
                child: ChooseTimeScreen(
                  baseChooseTimeCubit: chooseTimeCubit,
                  today: DateTime.now(),
                  onSubmit: (value) {},
                  onChangTime: () {
                    danhSachCubit.ngayDauTien = chooseTimeCubit.startDate;
                    danhSachCubit.ngayKetThuc = chooseTimeCubit.endDate;
                    danhSachCubit.callApiDashBroash(true);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    color: bgQLVBTablet,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        right: 30.0,
                        left: 30.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: StreamBuilder<List<ChartData>>(
                              stream: danhSachCubit.statusNhiemVuCaNhanSuject,
                              initialData: danhSachCubit.chartDataNhiemVuCaNhan,
                              builder: (context, snapshot) {
                                final data = snapshot.data ??
                                    widget.cubit.chartDataNhiemVu;
                                return BieuDoNhiemVuTablet(
                                  title: S.current.nhiem_vu,
                                  chartData: data,
                                  isCheck: true,
                                  cubit: danhSachCubit,
                                  onTap: (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DanhSachNhiemVuTablet(
                                          isCheck: widget.isCheck,
                                          ngayBatDau: danhSachCubit.ngayDauTien,
                                          ngayKetThuc:
                                              danhSachCubit.ngayKetThuc,
                                          mangTrangThai:
                                              value.trangThaiBieuDoNhiemVu(),
                                        ),
                                      ),
                                    );
                                  }, onTapStatusBox: (value ) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DanhSachNhiemVuTablet(
                                            isCheck: widget.isCheck,
                                            ngayBatDau: danhSachCubit.ngayDauTien,
                                            ngayKetThuc:
                                            danhSachCubit.ngayKetThuc,
                                            mangTrangThai:[],
                                            trangThaiHanXuLy: value,
                                          ),
                                    ),
                                  );
                                },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder<List<ChartData>>(
                              stream: danhSachCubit.statusCongViecCaNhanSuject,
                              initialData:
                                  danhSachCubit.chartDataCongViecCaNhan,
                              builder: (context, snapshot) {
                                final data = snapshot.data ??
                                    widget.cubit.chartDataNhiemVu;
                                return BieuDoNhiemVuTablet(
                                  title: S.current.cong_viec,
                                  isCheck: false,
                                  cubit: danhSachCubit,
                                  chartData: data,
                                  onTap: (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DanhSachCongViecTablet(
                                          isCheck: widget.isCheck,
                                          ngayBatDau: danhSachCubit.ngayDauTien,
                                          ngayKetThuc:
                                              danhSachCubit.ngayKetThuc,
                                          mangTrangThai: [value], trangThaiHanXuLy: null,
                                        ),
                                      ),
                                    );
                                  }, onTapStatusBox: (value ) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DanhSachCongViecTablet(
                                            isCheck: widget.isCheck,
                                            ngayBatDau: danhSachCubit.ngayDauTien,
                                            ngayKetThuc:
                                            danhSachCubit.ngayKetThuc,
                                            mangTrangThai: [], trangThaiHanXuLy: value,
                                          ),
                                    ),
                                  );
                                },
                                );
                              },
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
            ),
          ];
        },
        body: StickyHeader(
          overlapHeaders: true,
          header: Container(
            color: bgQLVBTablet,
            height: 50,
            child: TabBar(
              unselectedLabelStyle: titleAppbar(fontSize: 16),
              unselectedLabelColor: AqiColor,
              labelColor: textDefault,
              labelStyle: titleText(fontSize: 16),
              indicatorColor: textDefault,
              tabs: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(S.current.danh_sach_nhiem_vu),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(S.current.danh_sach_cong_viec),
                ),
              ],
            ),
          ),
          content: TabBarView(
            children: [
              StreamBuilder<List<PageData>>(
                stream: danhSachCubit.dataSubject,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  if (data.isNotEmpty) {
                    return ListDanhSachNhiemVu(
                      titleButton: S.current.xem_danh_sach,
                      list: data,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DanhSachNhiemVuTablet(
                              isCheck: widget.isCheck,
                              ngayBatDau: danhSachCubit.ngayDauTien,
                              ngayKetThuc: danhSachCubit.ngayKetThuc,
                              mangTrangThai: [],
                            ),
                          ),
                        );
                      },
                      isCheck: widget.isCheck,
                    );
                  }
                  return SizedBox(
                    child: Text(
                      S.current.khong_co_du_lieu,
                      style: titleAppbar(fontSize: 16.0),
                    ),
                  );
                },
              ),
              StreamBuilder<List<PageDatas>>(
                stream: danhSachCubit.dataSubjects,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  if (data.isNotEmpty) {
                    return ListDanhSachCongViec(
                      titleButton: S.current.xem_danh_sach,
                      list: data,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DanhSachCongViecTablet(
                              isCheck: widget.isCheck,
                              ngayBatDau: danhSachCubit.ngayDauTien,
                              ngayKetThuc: danhSachCubit.ngayKetThuc,
                              mangTrangThai: [],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox(
                    child: Text(
                      S.current.khong_co_du_lieu,
                      style: titleAppbar(fontSize: 16.0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
