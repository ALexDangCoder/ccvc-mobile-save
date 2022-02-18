import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/tablet/incoming_document_tablet.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/ui/tablet/outgoing_document_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/common_infor_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/list_vb_den.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/list_vb_di.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
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
  OutgoingDocumentCubit outgoingDocumentCubit = OutgoingDocumentCubit();
  IncomingDocumentCubit incomingDocumentCubit = IncomingDocumentCubit();
  late TabController controller;

  late ScrollController scrollController;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    super.initState();
    qlvbCubit.callAPi();
    outgoingDocumentCubit.callAPi();
    incomingDocumentCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.thong_tin_chung,
      ),
      body: DefaultTabController(
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
                    today: DateTime.now(),
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
                                  final dataVBDen =
                                      snapshot.data ?? DocumentDashboardModel();
                                  return CommonInformationTablet(
                                    documentDashboardModel: dataVBDen,
                                    isVbDen: true,
                                    title: S.current.document_incoming,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder<DocumentDashboardModel>(
                                stream: qlvbCubit.getVbDi,
                                builder: (context, snapshot) {
                                  final dataVBDi =
                                      snapshot.data ?? DocumentDashboardModel();
                                  return CommonInformationTablet(
                                    documentDashboardModel: dataVBDi,
                                    isVbDen: false,
                                    title: S.current.document_out_going,
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
                  stream: incomingDocumentCubit.getListVbDen,
                  builder: (context, snapshot) {
                    final List<VanBanModel> listData =
                        snapshot.data ?? [];
                    if (listData.isNotEmpty) {
                      return  ListVBDen(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const IncomingDocumentScreenTablet(),
                              ),
                            );
                          },
                          titleButton: S.current.xem_danh_sach,
                          list:listData
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                StreamBuilder<List<VanBanModel>>(
                  stream: outgoingDocumentCubit.getListVbDi,
                  builder: (context, snapshot) {
                    final List<VanBanModel> listData =
                        snapshot.data ?? [];
                    if (listData.isNotEmpty) {
                      return  ListVBDen(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const IncomingDocumentScreenTablet(),
                            ),
                          );
                        },
                        titleButton: S.current.xem_danh_sach,
                        list:listData
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
    );
  }
}
