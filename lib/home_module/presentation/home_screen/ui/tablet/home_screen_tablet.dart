import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/mequee_widget.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/tablet/thong_bao_screen_tablet.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';

import '/data/exception/app_exception.dart';
import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_item.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/app_bar_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/header_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/thong_bao_message_widget.dart';
import '/widgets/views/state_stream_layout.dart';

GlobalKey<HomeScreenTabletState> keyHomeTablet =
    GlobalKey<HomeScreenTabletState>();

class HomeScreenTablet extends StatefulWidget {
  const HomeScreenTablet({Key? key}) : super(key: key);

  @override
  State<HomeScreenTablet> createState() => HomeScreenTabletState();
}

class HomeScreenTabletState extends State<HomeScreenTablet>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  HomeCubit homeCubit = HomeCubit();
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    super.initState();
    homeCubit.loadApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
    homeCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      homeCubit: homeCubit,
      controller: scrollController,
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: homeCubit.stateStream,
        child: Scaffold(
          backgroundColor: bgTabletColor,
          appBar: AppBarWidget(
            title: S.current.home,
            acction: [
              const SizedBox(
                width: 31,
              ),
              GestureDetector(
                onTap: () {
                  DrawerSlide.navigatorSlide(
                    context: context,
                    screen: const ThongBaoScreenTablet(),
                    isLeft: false,
                  );
                },
                child: const ThongBaoWidget(
                  sum: 19,
                ),
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await homeCubit.refreshData();
            },
            child: Column(
              children: [
                const HeaderTabletWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: StreamBuilder<List<WidgetModel>>(
                            stream: homeCubit.getConfigWidget,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? <WidgetModel>[];
                              if (data.isNotEmpty) {
                                return Column(
                                  children: List.generate(data.length, (index) {
                                    final type = data[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child:
                                          type.widgetType?.getItemsTablet() ??
                                              const SizedBox(),
                                    );
                                  }),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          color: backgroundColorApp,
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: const MarqueeWidget(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
