import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/tablet/imcoming_document_screen_dashboard_tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/tablet/incoming_document_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/common_infor_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/list_vb_den.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/list_vb_di.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class QLVBScreenTablet extends StatefulWidget {
  const QLVBScreenTablet({Key? key}) : super(key: key);

  @override
  _QLVBScreenTabletState createState() => _QLVBScreenTabletState();
}

class _QLVBScreenTabletState extends State<QLVBScreenTablet>
    with SingleTickerProviderStateMixin {
  QLVBCCubit qlvbCubit = QLVBCCubit();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  late TabController controller;
  late ScrollController scrollController;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    super.initState();
    qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.thong_tin_chung,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('1', ''),
        stream: qlvbCubit.stateStream,
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: ChooseTimeScreen(
                      baseChooseTimeCubit: chooseTimeCubit,
                      today: DateTime.now(),
                      onSubmit: (value) {
                        qlvbCubit.searchDataDanhSachVBDen(
                          startDate: chooseTimeCubit.startDate,
                          endDate: chooseTimeCubit.endDate,
                          keySearch: value,
                        );
                        qlvbCubit.searchDataDanhSachVBDi(
                          startDate: chooseTimeCubit.startDate,
                          endDate: chooseTimeCubit.endDate,
                          keySearch: value,
                        );
                        qlvbCubit.listDataDanhSachVBDen(
                            endDate: qlvbCubit.endDate,
                            startDate: qlvbCubit.startDate);
                        qlvbCubit.listDataDanhSachVBDi(
                            endDate: qlvbCubit.endDate,
                            startDate: qlvbCubit.startDate);
                      },
                      onChangTime: () {
                        qlvbCubit.dataVBDen(
                          startDate: chooseTimeCubit.startDate,
                          endDate: chooseTimeCubit.endDate,
                        );
                        qlvbCubit.dataVBDi(
                          startDate: chooseTimeCubit.startDate,
                          endDate: chooseTimeCubit.endDate,
                        );
                        qlvbCubit.listDataDanhSachVBDen(
                            endDate: qlvbCubit.endDate,
                            startDate: qlvbCubit.startDate);
                        qlvbCubit.listDataDanhSachVBDi(
                            endDate: qlvbCubit.endDate,
                            startDate: qlvbCubit.startDate);
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
                                child: StreamBuilder<DocumentDashboardModel>(
                                  stream: qlvbCubit.getVbDen,
                                  builder: (context, snapshot) {
                                    final dataVBDen = snapshot.data ??
                                        DocumentDashboardModel();
                                    return CommonInformationTablet(
                                      documentDashboardModel: dataVBDen,
                                      qlvbcCubit: qlvbCubit,
                                      isVbDen: true,
                                      title: S.current.document_incoming,
                                      ontap: (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                IncomingDocumentScreenTablet(
                                              title: S.current
                                                  .danh_sach_van_ban_den,
                                              type: TypeScreen.VAN_BAN_DEN,
                                              startDate: qlvbCubit.startDate,
                                              endDate: qlvbCubit.endDate,
                                              isDanhSachDaXuLy:
                                                  value.isDanhSachDaXuLy(),
                                              maTrangThai: value.daHoanThanh(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: StreamBuilder<DocumentDashboardModel>(
                                  stream: qlvbCubit.getVbDi,
                                  builder: (context, snapshot) {
                                    final dataVBDi = snapshot.data ??
                                        DocumentDashboardModel();
                                    return CommonInformationTablet(
                                      qlvbcCubit: qlvbCubit,
                                      documentDashboardModel: dataVBDi,
                                      isVbDen: false,
                                      title: S.current.document_out_going,
                                      ontap: (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                IncomingDocumentScreenDashBoardTablet(
                                              title: S
                                                  .current.danh_sach_van_ban_di,
                                              type: TypeScreen.VAN_BAN_DI,
                                              startDate: qlvbCubit.startDate,
                                              endDate: qlvbCubit.endDate,
                                              isDanhSachDaXuLy: value
                                                  .getTrangThaiDaXuLy(value),
                                              isDanhSachChoTrinhKy:
                                                  value.getTrangThaiChoTrinhKy(
                                                      value),
                                              isDanhSachChoXuLy: value
                                                  .getTrangThaiChoXuLy(value),
                                              trangThaiFilter:
                                                  value.getTrangThaiNumber(),
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
                  labelColor: AppTheme.getInstance().colorField(),
                  labelStyle: titleText(fontSize: 16),
                  indicatorColor: AppTheme.getInstance().colorField(),
                  tabs: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(S.current.danh_sach_van_ban_den),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(S.current.danh_sach_van_ban_di),
                    ),
                  ],
                ),
              ),
              content: TabBarView(
                children: [
                  StreamBuilder<List<VanBanModel>>(
                    stream: qlvbCubit.getDanhSachVbDen,
                    builder: (context, snapshot) {
                      final List<VanBanModel> listData = snapshot.data ?? [];
                      if (listData.isNotEmpty) {
                        return ListVBDen(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IncomingDocumentScreenTablet(
                                    title: S.current.danh_sach_van_ban_den,
                                    type: TypeScreen.VAN_BAN_DEN,
                                    startDate: qlvbCubit.startDate,
                                    endDate: qlvbCubit.endDate,
                                    maTrangThai: [],
                                  ),
                                ),
                              );
                            },
                            titleButton: S.current.xem_danh_sach,
                            list: listData);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  StreamBuilder<List<VanBanModel>>(
                    stream: qlvbCubit.getDanhSachVbDi,
                    builder: (context, snapshot) {
                      final List<VanBanModel> listData = snapshot.data ?? [];
                      if (listData.isNotEmpty) {
                        return ListVBDi(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IncomingDocumentScreenTablet(
                                  title: S.current.danh_sach_van_ban_di,
                                  type: TypeScreen.VAN_BAN_DI,
                                  startDate: qlvbCubit.startDate,
                                  endDate: qlvbCubit.endDate,
                                  maTrangThai: [],
                                ),
                              ),
                            );
                          },
                          titleButton: S.current.xem_danh_sach,
                          list: listData,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
