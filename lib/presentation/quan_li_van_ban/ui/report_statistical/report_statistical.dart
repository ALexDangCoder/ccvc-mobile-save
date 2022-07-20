import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/document_in_statistical_page.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/tab_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReportStatical extends StatefulWidget {
  final QLVBCCubit cubit;

  const ReportStatical({Key? key, required this.cubit}) : super(key: key);

  @override
  State<ReportStatical> createState() => _ReportStaticalState();
}

class _ReportStaticalState extends State<ReportStatical>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    widget.cubit.generateListTime();
    widget.cubit.getReportStatisticalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          S.current.bao_cao_thong_ke,
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
              DrawerSlide.navigatorSlide(
                context: context,
                screen: VanBanMenuMobile(
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
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          if (widget.cubit.showSearchSubject.value == true) {
            widget.cubit.showSearchSubject.sink.add(false);
          }
        },
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: widget.cubit.stateStream,
          child: Column(
            children: [
              Container(
                color: isMobile() ? bgTabletColor : backgroundColorApp,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.nam,
                              style: tokenDetailAmount(
                                fontSize: 14.0.textScale(),
                                color: color586B8B,
                              ),
                            ),
                            spaceH8,
                            CoolDropDown(
                              listData: widget.cubit.yearsList,
                              onChange: (int index) {},
                              initData: '',
                              placeHoder: S.current.tat_ca,
                            ),
                          ],
                        ),
                      ),
                      spaceW16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.thang,
                              style: tokenDetailAmount(
                                fontSize: 14.0.textScale(),
                                color: color586B8B,
                              ),
                            ),
                            spaceH8,
                            CoolDropDown(
                              listData: widget.cubit.monthsList,
                              onChange: (int index) {},
                              initData: '',
                              placeHoder: S.current.tat_ca,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              spaceH20,
              tabBar(_tabController),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DocumentInStatisticalPage(
                      cubit: widget.cubit,
                    ),
                    Container(
                      color: Colors.blueAccent.withOpacity(0.1),
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
}
