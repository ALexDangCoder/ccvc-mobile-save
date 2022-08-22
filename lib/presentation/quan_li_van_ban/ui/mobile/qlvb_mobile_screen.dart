import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/document_in_page.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/document_out_page.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/search_bar.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/tab_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QLVBMobileScreen extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const QLVBMobileScreen({Key? key, required this.qlvbCubit}) : super(key: key);

  @override
  _QLVBMobileScreenState createState() => _QLVBMobileScreenState();
}

class _QLVBMobileScreenState extends State<QLVBMobileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.qlvbCubit.initTimeRange();
    widget.qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: widget.qlvbCubit.showSearchStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? SearchBarDocumentManagement(
                    qlvbCubit: widget.qlvbCubit,
                    initKeyWord: widget.qlvbCubit.keySearch,
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
                          widget.qlvbCubit.setSelectSearch();
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
                              cubit: widget.qlvbCubit,
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
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.qlvbCubit.stateStream,
        child: Column(
          children: [
            Container(
              color: colorFFFFFF,
              child: FilterDateTimeWidget(
                context: context,
                initStartDate: DateTime.parse(widget.qlvbCubit.startDate),
                onChooseDateFilter: (startDate, endDate) {
                  widget.qlvbCubit.startDate = startDate.formatApi;
                  widget.qlvbCubit.endDate = endDate.formatApi;
                  widget.qlvbCubit.callAPi(initTime: false);
                },
              ),
            ),
            spaceH20,
            tabBar(_tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DocumentInPage(
                    qlvbCubit: widget.qlvbCubit,
                  ),
                  DocumentOutPage(
                    qlvbCubit: widget.qlvbCubit,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
