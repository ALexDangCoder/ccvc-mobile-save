import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/mequee_widget.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/mobile/thong_bao_screen.dart';
import 'package:flutter/material.dart';

import '/data/exception/app_exception.dart';
import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_item.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/header_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/thong_bao_message_widget.dart';
import '/widgets/views/state_stream_layout.dart';
import 'home_icon.dart';

GlobalKey<HomeScreenMobileState> keyHomeMobile =
    GlobalKey<HomeScreenMobileState>();

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenMobile> createState() => HomeScreenMobileState();
}

class HomeScreenMobileState extends State<HomeScreenMobile> {
  ScrollController scrollController = ScrollController();
  HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit.loadApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
        error: AppException(S.current.error, S.current.something_went_wrong),
        stream: homeCubit.stateStream,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: GestureDetector(
              onTap: () {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              child: Text(
                S.current.home,
                style: textNormalCustom(
                  fontSize: 18,
                  color: backgroundColorApp,
                ),
              ),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(appBarUrlIcon()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ThongBaoScreen(),
                      ),
                    );
                  },
                  child: const SizedBox(
                    width: 24,
                    height: 25,
                    child: ThongBaoWidget(
                      sum: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          backgroundColor: homeColor,
          body: RefreshIndicator(
            onRefresh: () async {
              await homeCubit.refreshData();
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                 const HeaderWidget(),
                  Column(
                    children: [
                      StreamBuilder<List<WidgetModel>>(
                        stream: homeCubit.getConfigWidget,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? <WidgetModel>[];
                          if (data.isNotEmpty) {
                            return Column(
                              children: List.generate(data.length, (index) {
                                final type = data[index];
                                return type.widgetType?.getItemsMobile() ??
                                    const SizedBox();
                              }),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: backgroundColorApp,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: const MarqueeWidget(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
