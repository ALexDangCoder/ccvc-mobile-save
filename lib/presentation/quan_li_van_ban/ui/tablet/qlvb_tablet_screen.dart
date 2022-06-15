import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/search_bar.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/document_in_page_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/document_out_page_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xffF9FAFF),
      appBar: AppBarDefaultBack(
        S.current.thong_tin_chung,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('1', ''),
        stream: qlvbCubit.stateStream,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  FilterDateTimeWidget(
                    context: context,
                    isMobile: false,
                    initStartDate: DateTime.parse(qlvbCubit.startDate),
                    onChooseDateFilter: (startDate, endDate) {
                      qlvbCubit.startDate = startDate.formatApi;
                      qlvbCubit.endDate = endDate.formatApi;
                      qlvbCubit.showLoading();
                      qlvbCubit.getDashBoardIncomeDocument();
                      qlvbCubit.getDashBoardOutcomeDocument();
                      qlvbCubit.getListIncomeDocument();
                      qlvbCubit.getListOutcomeDocument();
                      qlvbCubit.showContent();
                    },
                  ),
                  Expanded(
                    child: SearchBarDocumentManagement(
                      qlvbCubit: qlvbCubit,
                      isTablet: true,
                      initKeyWord: qlvbCubit.keySearch,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
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
                    Expanded(
                      child: TabBarView(
                        children: [
                          DocumentInPageTablet(
                            qlvbCubit: qlvbCubit,
                          ),
                          DocumentOutPageTablet(
                            qlvbCubit: qlvbCubit,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
