import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/document_in_page.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/document_out_page.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QLVBMobileScreen extends StatefulWidget {
  const QLVBMobileScreen({Key? key}) : super(key: key);

  @override
  _QLVBMobileScreenState createState() => _QLVBMobileScreenState();
}

class _QLVBMobileScreenState extends State<QLVBMobileScreen>
    with TickerProviderStateMixin {
  QLVBCCubit qlvbCubit = QLVBCCubit();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    qlvbCubit.initTimeRange();
    qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: qlvbCubit.showSearchStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? SearchBarDocumentManagement(
                    qlvbCubit: qlvbCubit,
                    initKeyWord: qlvbCubit.keySearch,
                  )
                : AppBar(
                    elevation: 0.0,
                    title: Text(
                      S.current.thong_tin_van_ban,
                      style: titleAppbar(),
                    ),
                    leading: IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: SvgPicture.asset(
                        ImageAssets.icBack,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          qlvbCubit.setSelectSearch();
                        },
                        child: const Icon(
                          Icons.search,
                          color: textBodyTime,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          DrawerSlide.navigatorSlide(
                            context: context,
                            screen: VanBanMenuMobile(
                              cubit: qlvbCubit,
                            ),
                          );
                        },
                        child: SvgPicture.asset(ImageAssets.icMenuCalender),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                    centerTitle: true,
                  );
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (qlvbCubit.showSearchSubject.value == true) {
            qlvbCubit.showSearchSubject.sink.add(false);
          }
        },
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: qlvbCubit.stateStream,
          child: Column(
            children: [
              FilterDateTimeWidget(
                context: context,
                isMobile: true,
                initStartDate: DateTime.parse(qlvbCubit.startDate),
                onChooseDateFilter: (startDate, endDate) {
                  qlvbCubit.startDate = startDate.formatApi;
                  qlvbCubit.endDate = endDate.formatApi;
                  qlvbCubit.getDashBoardIncomeDocument();
                  qlvbCubit.getDashBoardOutcomeDocument();
                  qlvbCubit.getListIncomeDocument();
                  qlvbCubit.getListOutcomeDocument();
                },
              ),
              spaceH20,
              tabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DocumentInPage(
                      qlvbCubit: qlvbCubit,
                    ),
                    DocumentOutPage(
                      qlvbCubit: qlvbCubit,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgTag,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: radioFocusColor,
        ),
        labelColor: backgroundColorApp,
        unselectedLabelColor: radioFocusColor,
        tabs: [
          Tab(
            text: S.current.document_incoming,
          ),
          Tab(
            text: S.current.document_out_going,
          ),
        ],
      ),
    );
  }
}
