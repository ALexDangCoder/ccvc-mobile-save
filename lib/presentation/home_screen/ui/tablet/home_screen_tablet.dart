import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_item.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/app_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/header_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/thong_bao_message_widget.dart';

import 'package:ccvc_mobile/presentation/search_screen/ui/tablet/search_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/tablet/thong_bao_screen_tablet.dart';

import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

final keyHomeTablet = GlobalKey<_HomeScreenTabletState>();

class HomeScreenTablet extends StatefulWidget {
  const HomeScreenTablet({Key? key}) : super(key: key);

  @override
  State<HomeScreenTablet> createState() => _HomeScreenTabletState();
}

class _HomeScreenTabletState extends State<HomeScreenTablet>
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
    homeCubit.configWidget();
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
      child: Scaffold(
        backgroundColor: bgTabletColor,
        appBar: AppBarWidget(
          leading: const Icon(
            Icons.menu,
            size: 26,
            color: backgroundColorApp,
          ),
          title: S.current.home,
          acction: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreenTablet(),
                  ),
                );
              },
              child: SvgPicture.asset(ImageAssets.icSearchWhite),
            ),
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
        body: SizedBox.expand(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: [
                const HeaderTabletWidget(),
                StreamBuilder<List<WidgetModel>>(
                  stream: homeCubit.getConfigWidget,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <WidgetModel>[];
                    if (data.isNotEmpty) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = data.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Interval(
                                (1 / count) * index,
                                1.0,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          );
                          if (animationController.status ==
                              AnimationStatus.dismissed) {
                            animationController.forward();
                          }
                          final type = data[index];
                          return AnimatedBuilder(
                            animation: animationController,
                            builder: (context, _) {
                              return FadeTransition(
                                opacity: animation,
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                    0.0,
                                    100 * (1.0 - animation.value),
                                    0.0,
                                  ),
                                  child: type.widgetType?.getItemsTablet() ??
                                      const SizedBox(),
                                ),
                              );
                            },
                          );
                        },
                        staggeredTileBuilder: (int index) {
                          final type = data[index];
                          if (type.widgetType == WidgetType.wordProcessState) {
                            return const StaggeredTile.fit(2);
                          }
                          return const StaggeredTile.fit(1);
                        },
                        mainAxisSpacing: 28,
                        crossAxisSpacing: 28,
                      );
                    }
                    return const SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
