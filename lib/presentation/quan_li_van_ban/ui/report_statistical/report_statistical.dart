import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReportStatical extends StatefulWidget {
  const ReportStatical({Key? key}) : super(key: key);

  @override
  State<ReportStatical> createState() => _ReportStaticalState();
}

class _ReportStaticalState extends State<ReportStatical>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final QLVBCCubit cubit = QLVBCCubit();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: cubit.showSearchStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? Container()
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
                        onTap: () {},
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
                            screen: Container(),
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
          if (cubit.showSearchSubject.value == true) {
            cubit.showSearchSubject.sink.add(false);
          }
        },
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: Column(
            children: [
              spaceH20,
              tabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [],
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
        color: AppTheme.getInstance().colorField().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppTheme.getInstance().colorField(),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.getInstance().colorField(),
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
