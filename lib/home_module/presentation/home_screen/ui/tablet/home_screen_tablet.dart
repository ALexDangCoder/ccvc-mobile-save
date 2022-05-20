
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
import '/home_module/utils/constants/image_asset.dart';
import '/widgets/views/state_stream_layout.dart';

GlobalKey<HomeScreenTabletState> keyHomeTablet = GlobalKey<HomeScreenTabletState>();

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
            child: SizedBox.expand(
              child: SingleChildScrollView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    const HeaderTabletWidget(),
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
                                  child: type.widgetType?.getItemsTablet() ??
                                      const SizedBox(),
                                );
                              }),
                            );
                            // return StaggeredGridView.countBuilder(
                            //   crossAxisCount: 2,
                            //   shrinkWrap: true,
                            //   padding: const EdgeInsets.symmetric(horizontal: 30),
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: data.length,
                            //   itemBuilder: (BuildContext context, int index) {
                            //     final int count = data.length;
                            //     final Animation<double> animation =
                            //         Tween<double>(begin: 0.0, end: 1.0).animate(
                            //       CurvedAnimation(
                            //         parent: animationController,
                            //         curve: Interval(
                            //           (1 / count) * index,
                            //           1.0,
                            //           curve: Curves.fastOutSlowIn,
                            //         ),
                            //       ),
                            //     );
                            //     if (animationController.status ==
                            //         AnimationStatus.dismissed) {
                            //       animationController.forward();
                            //     }
                            //     final type = data[index];
                            //     return AnimatedBuilder(
                            //       animation: animationController,
                            //       builder: (context, _) {
                            //         return FadeTransition(
                            //           opacity: animation,
                            //           child: Transform(
                            //             transform: Matrix4.translationValues(
                            //               0.0,
                            //               100 * (1.0 - animation.value),
                            //               0.0,
                            //             ),
                            //             child:
                            //                 type.widgetType?.getItemsTablet() ??
                            //                     const SizedBox(),
                            //           ),
                            //         );
                            //       },
                            //     );
                            //   },
                            //   staggeredTileBuilder: (int index) {
                            //     final type = data[index];
                            //     if (type.widgetType ==
                            //         WidgetType.wordProcessState) {
                            //       return const StaggeredTile.fit(2);
                            //     }
                            //     return const StaggeredTile.fit(1);
                            //   },
                            //   mainAxisSpacing: 28,
                            //   crossAxisSpacing: 28,
                            // );
                          }
                          return const SizedBox();
                        },
                      ),
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
          ),
        ),
      ),
    );
  }
}
