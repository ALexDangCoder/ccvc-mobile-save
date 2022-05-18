import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/bieu_do_nhiem_vu_ca_nhan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/danh_sach_cong_viec_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/danh_sach_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NhiemVuCaNhanTablet extends StatefulWidget {
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit nhiemVuCubit;
  final bool isCheck;

  const NhiemVuCaNhanTablet({
    Key? key,
    required this.nhiemVuCubit,
    required this.isCheck,
    required this.danhSachCubit,
  }) : super(key: key);

  @override
  _NhiemVuCaNhanTabletState createState() => _NhiemVuCaNhanTabletState();
}

class _NhiemVuCaNhanTabletState extends State<NhiemVuCaNhanTablet> {
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  late Function(int page) callBack;
  // DanhSachCubit danhSachCubit = DanhSachCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   widget.danhSachCubit.callApi(true);
    callBack = (page) {
      widget.danhSachCubit.postDanhSachNhiemVu(
        index: page,
        isNhiemVuCaNhan: widget.isCheck,
        isSortByHanXuLy: true,
        mangTrangThai: [widget.danhSachCubit.mangTrangThai],
        ngayTaoNhiemVu: {
          'FromDate': widget.danhSachCubit.ngayDauTien,
          'ToDate': widget.danhSachCubit.ngayKetThuc
        },
        size: widget.danhSachCubit.pageSize,
        keySearch: widget.danhSachCubit.keySearch,
        trangThaiHanXuLy: widget.danhSachCubit.trangThaiHanXuLy,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
    body:  ComplexLoadMore(
        childrenView: [
          Row(
            children: [
              Expanded(
                flex:3,
                child: FilterDateTimeWidget(
                  context: context,
                  isMobile: false,
                  onChooseDateFilter: (startDate, endDate) {
                    widget.danhSachCubit.ngayDauTien = startDate.formatApi;
                    widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
                    widget.danhSachCubit.callApiDashBroash(true);
                  },
                ),
              ),
              Expanded(flex:2,child: Text("data"))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0,right: 30.0,left: 30.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: backgroundColorApp
              ),
              child: ExpandOnlyWidget(
                isPadingIcon: true,
                initExpand: true,
                header: Container(
                   color: Colors.transparent,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16.0),
                        child: Text(
                          S.current.tong_hop_tinh_hinh_xu_ly_nhiem_vu,
                          style: textNormalCustom(color: titleColor, fontSize: 16.0.textScale(space: 4)),
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 16.0),
                      child:
                      StreamBuilder<List<ChartData>>(
                        stream: widget.danhSachCubit.statusNhiemVuCaNhanSuject,
                        initialData: widget.danhSachCubit.chartDataNhiemVuCaNhan,
                        builder: (context, snapshot) {
                          final data = snapshot.data ??
                              widget.danhSachCubit.chartDataNhiemVu;
                          return BieuDoNhiemVuCaNhan(
                            title: S.current.nhiem_vu,
                            chartData: data,
                            cubit: widget.danhSachCubit,
                            ontap: (value) {
                              widget.danhSachCubit.mangTrangThai = value;
                              widget.danhSachCubit.trangThaiHanXuLy = null;
                              setState(() {
                                callBack;
                              });
                            },
                            onTapStatusBox: (value_status_box) {
                              widget.danhSachCubit.mangTrangThai = '';
                              widget.danhSachCubit.trangThaiHanXuLy =
                                  value_status_box;
                              setState(() {
                                callBack;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        callApi: (page) {
          widget.danhSachCubit.postDanhSachNhiemVu(
            index: page,
            isNhiemVuCaNhan: widget.isCheck,
            isSortByHanXuLy: true,
            mangTrangThai: [widget.danhSachCubit.mangTrangThai],
            ngayTaoNhiemVu: {
              'FromDate': widget.danhSachCubit.ngayDauTien,
              'ToDate': widget.danhSachCubit.ngayKetThuc
            },
            size: widget.danhSachCubit.pageSize,
            keySearch: widget.danhSachCubit.keySearch,
            trangThaiHanXuLy: widget.danhSachCubit.trangThaiHanXuLy,
          );
        },
        isListView: true,
        cubit: widget.danhSachCubit,
        viewItem: (value, index) {
          try {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: NhiemVuItemMobile(
                data: value as PageData,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChiTietNhiemVuPhoneScreen(
                        id: value.id ?? '',
                        isCheck: widget.isCheck,
                      ),
                    ),
                  );
                },
              ),
            );
          } catch (e) {
            return const SizedBox();
          }
        },
      ),
    );
    // return DefaultTabController(
    //   length: 2,
    //   child: NestedScrollView(
    //     headerSliverBuilder: (
    //       BuildContext context,
    //       bool innerBoxIsScrolled,
    //     ) {
    //       return [
    //         SliverToBoxAdapter(
    //           child: Container(
    //             color: backgroundColorApp,
    //             child: ChooseTimeScreen(
    //               baseChooseTimeCubit: chooseTimeCubit,
    //               today: DateTime.now(),
    //               onSubmit: (value) {},
    //               onChangTime: () {
    //                 danhSachCubit.ngayDauTien = chooseTimeCubit.startDate;
    //                 danhSachCubit.ngayKetThuc = chooseTimeCubit.endDate;
    //                 danhSachCubit.callApiDashBroash(true);
    //               },
    //             ),
    //           ),
    //         ),
    //         SliverToBoxAdapter(
    //           child: Column(
    //             children: [
    //               Container(
    //                 color: bgQLVBTablet,
    //                 child: Container(
    //                   margin: const EdgeInsets.only(
    //                     top: 20.0,
    //                     right: 30.0,
    //                     left: 30.0,
    //                   ),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(12),
    //                     border: Border.all(
    //                       color: borderColor.withOpacity(0.5),
    //                     ),
    //                   ),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Expanded(
    //                         child: StreamBuilder<List<ChartData>>(
    //                           stream: danhSachCubit.statusNhiemVuCaNhanSuject,
    //                           initialData: danhSachCubit.chartDataNhiemVuCaNhan,
    //                           builder: (context, snapshot) {
    //                             final data = snapshot.data ??
    //                                 widget.cubit.chartDataNhiemVu;
    //                             return BieuDoNhiemVuTablet(
    //                               title: S.current.nhiem_vu,
    //                               chartData: data,
    //                               isCheck: true,
    //                               cubit: danhSachCubit,
    //                               onTap: (value) {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         DanhSachNhiemVuTablet(
    //                                       isCheck: widget.isCheck,
    //                                       ngayBatDau: danhSachCubit.ngayDauTien,
    //                                       ngayKetThuc:
    //                                           danhSachCubit.ngayKetThuc,
    //                                       mangTrangThai:
    //                                           value.trangThaiBieuDoNhiemVu(),
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               onTapStatusBox: (value) {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         DanhSachNhiemVuTablet(
    //                                       isCheck: widget.isCheck,
    //                                       ngayBatDau: danhSachCubit.ngayDauTien,
    //                                       ngayKetThuc:
    //                                           danhSachCubit.ngayKetThuc,
    //                                       mangTrangThai: [],
    //                                       trangThaiHanXuLy: value,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: StreamBuilder<List<ChartData>>(
    //                           stream: danhSachCubit.statusCongViecCaNhanSuject,
    //                           initialData:
    //                               danhSachCubit.chartDataCongViecCaNhan,
    //                           builder: (context, snapshot) {
    //                             final data = snapshot.data ??
    //                                 widget.cubit.chartDataNhiemVu;
    //                             return BieuDoNhiemVuTablet(
    //                               title: S.current.cong_viec,
    //                               isCheck: false,
    //                               cubit: danhSachCubit,
    //                               chartData: data,
    //                               onTap: (value) {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         DanhSachCongViecTablet(
    //                                       isCheck: widget.isCheck,
    //                                       ngayBatDau: danhSachCubit.ngayDauTien,
    //                                       ngayKetThuc:
    //                                           danhSachCubit.ngayKetThuc,
    //                                       mangTrangThai: [value],
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               onTapStatusBox: (value) {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         DanhSachCongViecTablet(
    //                                       isCheck: widget.isCheck,
    //                                       ngayBatDau: danhSachCubit.ngayDauTien,
    //                                       ngayKetThuc:
    //                                           danhSachCubit.ngayKetThuc,
    //                                       mangTrangThai: [],
    //                                       trangThaiHanXuLy: value,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 color: bgQLVBTablet,
    //                 height: 18,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ];
    //     },
    //     body: StickyHeader(
    //       overlapHeaders: true,
    //       header: Container(
    //         color: bgQLVBTablet,
    //         height: 50,
    //         child: TabBar(
    //           unselectedLabelStyle: titleAppbar(fontSize: 16),
    //           unselectedLabelColor: AqiColor,
    //           labelColor: AppTheme.getInstance().colorField(),
    //           labelStyle: titleText(fontSize: 16),
    //           indicatorColor: AppTheme.getInstance().colorField(),
    //           tabs: [
    //             Container(
    //               padding: const EdgeInsets.only(bottom: 8),
    //               child: Text(S.current.danh_sach_nhiem_vu),
    //             ),
    //             Container(
    //               padding: const EdgeInsets.only(bottom: 8),
    //               child: Text(S.current.danh_sach_cong_viec),
    //             ),
    //           ],
    //         ),
    //       ),
    //       content: TabBarView(
    //         children: [
    //           StreamBuilder<List<PageData>>(
    //             stream: danhSachCubit.dataSubject,
    //             builder: (context, snapshot) {
    //               final data = snapshot.data ?? [];
    //               if (data.isNotEmpty) {
    //                 return ListDanhSachNhiemVu(
    //                   titleButton: S.current.xem_danh_sach,
    //                   list: data,
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => DanhSachNhiemVuTablet(
    //                           isCheck: widget.isCheck,
    //                           ngayBatDau: danhSachCubit.ngayDauTien,
    //                           ngayKetThuc: danhSachCubit.ngayKetThuc,
    //                           mangTrangThai: [],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                   isCheck: widget.isCheck,
    //                 );
    //               }
    //               return SizedBox(
    //                 child: Text(
    //                   S.current.khong_co_du_lieu,
    //                   style: titleAppbar(fontSize: 16.0),
    //                 ),
    //               );
    //             },
    //           ),
    //           StreamBuilder<List<PageDatas>>(
    //             stream: danhSachCubit.dataSubjects,
    //             builder: (context, snapshot) {
    //               final data = snapshot.data ?? [];
    //               if (data.isNotEmpty) {
    //                 return ListDanhSachCongViec(
    //                   titleButton: S.current.xem_danh_sach,
    //                   list: data,
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => DanhSachCongViecTablet(
    //                           isCheck: widget.isCheck,
    //                           ngayBatDau: danhSachCubit.ngayDauTien,
    //                           ngayKetThuc: danhSachCubit.ngayKetThuc,
    //                           mangTrangThai: [],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 );
    //               }
    //               return SizedBox(
    //                 child: Text(
    //                   S.current.khong_co_du_lieu,
    //                   style: titleAppbar(fontSize: 16.0),
    //                 ),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
